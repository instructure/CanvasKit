//
//  CKIClient+CKISubmissionComment.m
//  CanvasKit
//
//  Created by Brandon Pluim on 8/28/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CKISubmissionComment.h"
#import "CKISubmissionRecord.h"
#import "CKIXMLParser.h"

// Legacy Stuff that was copied over since the Kaltura implementation hasn't changed much
@interface CKMediaServer : NSObject

@property (nonatomic, assign, getter = isEnabled) BOOL enabled;
@property (nonatomic, strong) NSURL *domain;
@property (nonatomic, strong) NSURL *resourceDomain;
@property (nonatomic, assign) uint64_t partnerId;

- (id)initWithInfo:(NSDictionary *)info;

// API URLs
- (NSURL *)apiURLAdd;
- (NSURL *)apiURLUpload;
- (NSURL *)apiURLAddFromUploadedFile;

@end
@implementation CKMediaServer

@synthesize enabled, domain, resourceDomain, partnerId;

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        enabled = [info[@"enabled"] boolValue];
        NSString *domainString = [self objectForKeyCheckingNull:@"domain" inDictionary:info];
        if (domainString) {
            if (![domainString hasPrefix:@"http"]) {
                domainString = [NSString stringWithFormat:@"http://%@",domainString];
            }
            domain = [[NSURL alloc] initWithString:domainString];
        }
        NSString *resourceDomainString = [self objectForKeyCheckingNull:@"resource_domain" inDictionary:info];
        if (resourceDomainString) {
            if (![resourceDomainString hasPrefix:@"http"]) {
                resourceDomainString = [NSString stringWithFormat:@"http://%@",resourceDomainString];
            }
            resourceDomain = [[NSURL alloc] initWithString:resourceDomainString];
        }
        partnerId = [[self objectForKeyCheckingNull:@"partner_id" inDictionary:info] unsignedLongLongValue];
    }
    
    return self;
}

- (NSURL *)apiURLAdd
{
    NSString *apiString = @"/api_v3/index.php?service=uploadtoken&action=add";
    NSString *apiAbsoluteString = [[self.domain host] stringByAppendingPathComponent:apiString];
    NSString *urlString = [NSString stringWithFormat:@"%@://%@",[self.domain scheme], apiAbsoluteString];
    return [NSURL URLWithString:urlString];
}

- (NSURL *)apiURLUpload
{
    NSString *apiString = @"/api_v3/index.php?service=uploadtoken&action=upload";
    NSString *apiAbsoluteString = [[self.domain host] stringByAppendingPathComponent:apiString];
    NSString *urlString = [NSString stringWithFormat:@"%@://%@",[self.domain scheme], apiAbsoluteString];
    return [NSURL URLWithString:urlString];
}

- (NSURL *)apiURLAddFromUploadedFile
{
    NSString *apiString = @"/api_v3/index.php?service=media&action=addFromUploadedFile";
    NSString *apiAbsoluteString = [[self.domain host] stringByAppendingPathComponent:apiString];
    NSString *urlString = [NSString stringWithFormat:@"%@://%@",[self.domain scheme], apiAbsoluteString];
    return [NSURL URLWithString:urlString];
}

- (id)objectForKeyCheckingNull:(id)aKey inDictionary:(NSDictionary *)dict
{
    id obj = dict[aKey];
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

@end

@implementation CKIClient (CKISubmissionComment)

- (RACSignal *)createSubmissionComment:(CKISubmissionComment *)comment {
    
    NSMutableDictionary *commentDictionary = [@{ @"text_comment" : comment.comment } mutableCopy];
    if (comment.mediaComment.mediaID) {
        commentDictionary[@"media_comment_id"] = comment.mediaComment.mediaID;
        commentDictionary[@"media_comment_type"] = comment.mediaComment.mediaType;
    }
    NSDictionary *params = @{@"comment" : commentDictionary};
    return [self updateModel:comment.context parameters:params];
}

- (void)createCommentWithMedia:(CKIMediaComment *)mediaComment forSubmissionRecord:(CKISubmissionRecord *)submissionRecord success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    NSData *data = [NSData dataWithContentsOfURL:mediaComment.url];
    
    [self postMediaCommentAtPath:mediaComment.url ofMediaType:CKIAttachmentMediaTypeVideo success:^{
        NSLog(@"The end");
    } failure:^(NSError *error) {
        NSLog(@"#fail");
    }];
    
}

- (void)getMediaServerConfigurationWithBlock:(void(^)(void))block
{
    
    block = [block copy];
    
    NSString *urlString = [@"services" stringByAppendingPathComponent:@"kaltura.json"];
    [self GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict = [responseObject dictionaryValue];
        self.mediaServer = [[CKMediaServer alloc] initWithInfo:dict];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail");
    }];
    
}

- (void)postMediaCommentAtPath:(NSString *)path ofMediaType:(CKIAttachmentMediaType *)mediaType success:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    // If the media server is disabled or nil, return an error
    if (!self.mediaServer || ![self.mediaServer isEnabled]) {
//        block([NSError errorWithDomain:@"" code:00001 userInfo:nil], YES, mediaType, nil);
        return;
    }
    
    [self getMediaSessionWithSuccess:^(NSString *sessionID) {
        [self getFileUploadTokenWithSessionID:sessionID success:^(NSString *uploadToken) {
            
            [self uploadFileAtPath:path ofMediaType:mediaType withToken:uploadToken sessionID:sessionID success:^{
                
                [self getMediaIDForUploadedFileToken:uploadToken withMediaType:mediaType sessionID:sessionID success:^{
                    NSLog(@"Finished all the things");
                } failure:^(NSError *error) {
                    NSLog(@"Failed to get media id for uploaded file");
                }];

            } failure:^(NSError *error) {
                NSLog(@"Failed to upload the file");
            }];
        } failure:^(NSError *error) {
            NSLog(@"Failed to get file upload token");
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get media recording session");
    }];

}
- (void)getMediaSessionWithSuccess:(void(^)(NSString *sessionID))success failure:(void(^)(NSError *error))failure {
    NSString *urlString = [@"services" stringByAppendingPathComponent:@"kaltura_session"];
    
    [self POST:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *ks = [responseObject objectForKeyCheckingNull:@"" inDictionary:responseObject];
        if (success) {
            success(ks);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getFileUploadTokenWithSessionID:(NSString *)sessionID success:(void(^)(NSString *uploadToken))success failure:(void(^)(NSError *error))failure {
    // POST http://www.kaltura.com/api_v3/index.php?service=uploadtoken&action=add
    // ks=NGMwNzVmZmM2NzUwOWEyZmRiYmYzNDU5OGVmOTAxYTdiY2E5ZjU4MnwxNTY2NTI7MTU2NjUyOzEyNzk2NTY3NTQ7MDsxMjc5NTcwMzU0LjQ3NDk7MjMxODkwXzEwOw%3D%3D
    // response: <?xml version="1.0" encoding="utf-8"?><xml><result><objectType>KalturaUploadToken</objectType><id>0_5e929ce09b1155753a3921e78d65e992</id><partnerId>156652</partnerId><userId>231890_10</userId><status>0</status><fileName></fileName><fileSize></fileSize><uploadedFileSize></uploadedFileSize><createdAt>1279570943</createdAt><updatedAt>1279570943</updatedAt></result><executionTime>0.034272909164429</executionTime></xml>
    NSURL *url = [self.mediaServer apiURLAdd];
    NSDictionary *parameters = @{@"ks": sessionID};
    
    [self POST:url.absoluteString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        // Handle failure to parse
        // Get the token id from the XML
        CKIXMLParser *parser = [[CKIXMLParser alloc] init];
        [parser parseShiz:responseObject];
        
        if (success) {
            success(@"faketokenid");
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)uploadFileAtPath:(NSString *)path ofMediaType:(CKIAttachmentMediaType)mediaType withToken:(NSString *)token sessionID:(NSString *)sessionID success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    
    
    [self POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFormData:sessionID name:@"ks"];
        [formData appendPartWithFormData:token name:@"uploadTokenId"];
        [formData appendPartWithFileURL:path name:@"fileData" fileName:@"videocomment.mp4" mimeType:@"video/mp4" error:nil];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        // Should get some XML back here. Might want to check it.
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) { 
            failure(error);
        }
    }];
    
    
    
}

//- (void)uploadFileAtPath:(NSString *)path ofMediaType:(CKIAttachmentMediaType)mediaType withToken:(NSString *)token sessionId:(NSString *)sessionId block:(CKSimpleBlock)block
//{
//    // POST http://www.kaltura.com/api_v3/index.php?service=uploadtoken&action=upload
//    // (multipart body:)
//    // ks=blah
//    // uploadTokenId=from above # Content-Disposition: form-data; name="uploadTokenId"
//    // fileData=<file data>  # Content-Disposition: form-data; name="fileData"; filename="2010-07-19 13:20:06 -0600.mov"
//    // response: <?xml version="1.0" encoding="utf-8"?><xml><result><objectType>KalturaUploadToken</objectType><id>0_5e929ce09b1155753a3921e78d65e992</id><partnerId>156652</partnerId><userId>231890_10</userId><status>2</status><fileName>2010-07-19 13:20:06 -0600.mov</fileName><fileSize></fileSize><uploadedFileSize>213603</uploadedFileSize><createdAt>1279570943</createdAt><updatedAt>1279571114</updatedAt></result><executionTime>0.051121950149536</executionTime></xml>
//    NSURL *url = [self.mediaServer apiURLUpload];
//    
//    NSString *boundary = @"---------------------------3klfenalksjflkjoi9auf89eshajsnl3kjnwal";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ks\"\r\n\r\n%@", sessionId] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadTokenId\"\r\n\r\n%@", token] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    if (mediaType == CKAttachmentMediaTypeAudio) {
//        [body appendData:[@"Content-Disposition: form-data; name=\"fileData\"; filename=\"audiocomment.wav\"\r\nContent-Type: audio/x-aiff\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    else {
//        [body appendData:[@"Content-Disposition: form-data; name=\"fileData\"; filename=\"videocomment.mp4\"\r\nContent-Type: video/mp4\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    [body appendData:[NSData dataWithContentsOfFile:path]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    block = [block copy];
//    [self runForURL:url options:@{CKAPIHTTPMethodKey: @"POST", CKAPIHTTPBodyDataKey: body, CKAPIShouldIgnoreCacheKey: @YES, CKAPIHTTPHeadersKey: @{@"Content-Type": contentType}, CKAPIProgressNotificationObjectKey: path} block:^(NSError *error, CKCanvasAPIResponse *apiResponse, BOOL isFinalValue) {
//        if (error != nil) {
//            NSLog(@"Error uploading media comment: %@", error);
//            block(error, isFinalValue);
//            return;
//        }
//
//        // Verify that the returned token id is the same. If it is, we assume the upload succeeded.
//        CXMLDocument *doc = [apiResponse XMLValue];
//        if (!doc) {
//            NSLog(@"Error parsing XML: %@", [[NSString alloc] initWithData:apiResponse.data encoding:NSUTF8StringEncoding]);
//            block([NSError errorWithDomain:CKCanvasErrorDomain code:1 userInfo:nil], isFinalValue);
//            return;
//        }
//
//        CXMLElement *el = [doc rootElement];
//        NSError *xmlError = nil;
//        CXMLNode *tokenIdNode = [el nodeForXPath:@"/xml/result/id" error:&xmlError];
//        if (!tokenIdNode || xmlError) {
//            NSLog(@"Could not find token id in xml: %@", [[NSString alloc] initWithData:apiResponse.data encoding:NSUTF8StringEncoding]);
//            block([NSError errorWithDomain:CKCanvasErrorDomain code:1 userInfo:nil], isFinalValue);
//            return;
//        }
//
//        if (![[tokenIdNode stringValue] isEqualToString:token]) {
//            NSLog(@"token id from response: %@ does not match supplied token: %@", [tokenIdNode stringValue], token);
//            block([NSError errorWithDomain:CKCanvasErrorDomain code:1 userInfo:nil], isFinalValue);
//            return;
//        }
//
//        block(nil, isFinalValue);
//    }];
//}

- (void)getMediaIDForUploadedFileToken:(NSString *)token withMediaType:(CKIAttachmentMediaType)mediaType sessionID:(NSString *)sessionID success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    // POST http://www.kaltura.com/api_v3/index.php?service=media&action=addFromUploadedFile
    // ks=NGMwNzVmZmM2NzUwOWEyZmRiYmYzNDU5OGVmOTAxYTdiY2E5ZjU4MnwxNTY2NTI7MTU2NjUyOzEyNzk2NTY3NTQ7MDsxMjc5NTcwMzU0LjQ3NDk7MjMxODkwXzEwOw%3D%3D
    // uploadTokenId=0_5e929ce09b1155753a3921e78d65e992
    // mediaEntry%3Aname=zach+test+3
    // mediaEntry%3AmediaType=5
    // response: <?xml version="1.0" encoding="utf-8"?><xml><result><objectType>KalturaMediaEntry</objectType><id>0_e3ropkdb</id><name>zach test 3</name><description></description><partnerId>156652</partnerId><userId>231890_10</userId><tags></tags><adminTags></adminTags><categories></categories><status>1</status><moderationStatus>6</moderationStatus><moderationCount>0</moderationCount><type>1</type><createdAt>1279571324</createdAt><rank>0</rank><totalRank>0</totalRank><votes>0</votes><groupId></groupId><partnerData></partnerData><downloadUrl>http://cdnbakmi.kaltura.com/p/156652/sp/15665200/raw/entry_id/0_e3ropkdb/version/0</downloadUrl><searchText>  zach test 3 </searchText><licenseType>-1</licenseType><version>0</version><thumbnailUrl>http://cdnbakmi.kaltura.com/p/156652/sp/15665200/thumbnail/entry_id/0_e3ropkdb/version/0</thumbnailUrl><accessControlId>63362</accessControlId><startDate></startDate><endDate></endDate><plays>0</plays><views>0</views><width></width><height></height><duration>0</duration><msDuration>0</msDuration><durationType></durationType><mediaType>5</mediaType><conversionQuality></conversionQuality><sourceType>1</sourceType><searchProviderType></searchProviderType><searchProviderId></searchProviderId><creditUserName></creditUserName><creditUrl></creditUrl><mediaDate></mediaDate><dataUrl>http://cdnbakmi.kaltura.com/p/156652/sp/15665200/flvclipper/entry_id/0_e3ropkdb/version/0</dataUrl><flavorParamsIds></flavorParamsIds></result><executionTime>6.2773299217224</executionTime></xml>
    NSURL *url = [self.mediaServer apiURLAddFromUploadedFile];
    
    NSString *mediaTypeString = (mediaType == CKIAttachmentMediaTypeVideo ? @"1" : @"5");
    
    NSDictionary *parameters = @{@"ks": sessionID, @"uploadTokenId": token, @"mediaEntry:name": @"Media Comment", @"mediaEntry:mediaType": mediaTypeString};
    
    [self POST:url.absoluteString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//- (void)getMediaIdForUploadedFileToken:(NSString *)token withMediaType:(CKAttachmentMediaType)mediaType sessionId:(NSString *)sessionId block:(CKStringBlock)block
//{
//    
//    
//    block = [block copy];
//    [self runForURL:url options:@{CKAPIHTTPMethodKey: @"POST", CKAPIHTTPPOSTParameters: parameters} block:^(NSError *error, CKCanvasAPIResponse *apiResponse, BOOL isFinalValue) {
//        if (error) {
//            NSLog(@"Error getting media id for uploaded file: %@", error);
//            block(error, isFinalValue, nil);
//            return;
//        }
//
//        CXMLDocument *doc = [apiResponse XMLValue];
//        if (!doc) {
//            NSLog(@"Error parsing XML: %@", [[NSString alloc] initWithData:apiResponse.data encoding:NSUTF8StringEncoding]);
//            block([NSError errorWithDomain:CKCanvasErrorDomain code:1 userInfo:nil], isFinalValue, nil);
//            return;
//        }
//
//        CXMLElement *el = [doc rootElement];
//        NSError *xmlError = nil;
//        CXMLNode *mediaIdNode = [el nodeForXPath:@"/xml/result/id" error:&xmlError];
//        if (!mediaIdNode || xmlError) {
//            NSLog(@"Could not find media id in xml: %@", [[NSString alloc] initWithData:apiResponse.data encoding:NSUTF8StringEncoding]);
//            block([NSError errorWithDomain:CKCanvasErrorDomain code:1 userInfo:nil], isFinalValue, nil);
//            return;
//        }
//
//        NSString *mediaId = [mediaIdNode stringValue];
//        if (!mediaId || (id)mediaId == [NSNull null] || [mediaId length] == 0) {
//            NSLog(@"Did not get back a media id in xml: %@", [[NSString alloc] initWithData:apiResponse.data encoding:NSUTF8StringEncoding]);
//            block([NSError errorWithDomain:CKCanvasErrorDomain code:1 userInfo:nil], isFinalValue, nil);
//            return;
//        }
//
//        block(nil, isFinalValue, [mediaIdNode stringValue]);
//    }];
//}


@end
