//
//  CKIClient+CKISubmissionComment.m
//  CanvasKit
//
//  Created by Brandon Pluim on 8/28/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CKISubmissionComment.h"
#import "CKISubmissionRecord.h"
#import "CKIMediaFileUPloadTokenParser.h"
#import "CKIMediaServer.h"
#import <AFHTTPRequestOperationManager.h>

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
    
    [self postMediaCommentAtPath:mediaComment.url.absoluteString ofMediaType:CKIAttachmentMediaTypeVideo success:^(NSString *mediaUploadID){
        
        CKISubmissionComment *comment = [[CKISubmissionComment alloc] init];
        mediaComment.mediaType = @"video";
        mediaComment.contentType = @"video/mp4";
        mediaComment.mediaID = mediaUploadID;
        comment.mediaComment = mediaComment;
        
        NSString *path = [[[submissionRecord.context path] stringByAppendingPathComponent:@"submissions"] stringByAppendingPathComponent:submissionRecord.userID];
        NSDictionary *params = @{@"media_comment_id": mediaUploadID, @"media_comment_type": @"video", @"text_comment": @""};
        [self PUT:path parameters:@{@"comment": params} success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success();
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"#fail");
    }];
    
}

- (void)configureMediaServerWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    if (self.mediaServer) {
        if (success) {
            success();
        }
        return;
    }
    
    NSString *urlString = @"api/v1/services/kaltura.json";
    [self GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.mediaServer = [[CKIMediaServer alloc] initWithInfo:responseObject];
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postMediaCommentAtPath:(NSString *)path ofMediaType:(CKIAttachmentMediaType *)mediaType success:(void(^)(NSString *mediaUploadID))success failure:(void(^)(NSError *error))failure
{

    [self configureMediaServerWithSuccess:^{
        [self getMediaSessionWithSuccess:^(NSString *sessionID) {
            [self getFileUploadTokenWithSessionID:sessionID success:^(NSString *uploadToken) {
                [self uploadFileAtPath:path ofMediaType:mediaType withToken:uploadToken sessionID:sessionID success:^{
                    [self getMediaIDForUploadedFileToken:uploadToken withMediaType:mediaType file:[NSURL URLWithString:path] sessionID:sessionID success:^(NSString *mediaUploadID) {
                        if (success) {
                            success(mediaUploadID);
                        }
                    } failure:^(NSError *error) {
                        if (failure) { failure(error); }
                    }];
                } failure:^(NSError *error) {
                    if (failure) { failure(error); }
                }];
            } failure:^(NSError *error) {
                if (failure) { failure(error); }
            }];
        } failure:^(NSError *error) {
            if (failure) { failure(error); }
        }];
    } failure:^(NSError *error) {
        if (failure) { failure(error); }
    }];

}
- (void)getMediaSessionWithSuccess:(void(^)(NSString *sessionID))success failure:(void(^)(NSError *error))failure {
    NSString *urlString = @"api/v1/services/kaltura_session";
    
    [self POST:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *ks = [responseObject valueForKey:@"ks"];
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
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.baseURL];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", self.accessToken] forHTTPHeaderField:@"Authorization"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:url.absoluteString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Handle failure to parse
        // Get the token id from the XML
        CKIMediaFileUploadTokenParser *parser = [[CKIMediaFileUploadTokenParser alloc] initWithXMLParser:responseObject];
        [parser parseWithSuccess:^(NSString *uploadID) {
            if (success) {
                success(uploadID);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)uploadFileAtPath:(NSString *)path ofMediaType:(CKIAttachmentMediaType)mediaType withToken:(NSString *)token sessionID:(NSString *)sessionID success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.baseURL];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@&uploadTokenId=%@&ks=%@", [self.mediaServer apiURLUpload], token, sessionID];

    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL URLWithString:path] name:@"fileData" fileName:@"videocomment.mp4" mimeType:@"video/mp4" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Should get some XML back here. Might want to check it.
        if (success) {
            success();
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getMediaIDForUploadedFileToken:(NSString *)token withMediaType:(CKIAttachmentMediaType)mediaType file:(NSURL *)fileURL sessionID:(NSString *)sessionID success:(void(^)(NSString *mediaUploadID))success failure:(void(^)(NSError *error))failure {
    // POST http://www.kaltura.com/api_v3/index.php?service=media&action=addFromUploadedFile
    // ks=NGMwNzVmZmM2NzUwOWEyZmRiYmYzNDU5OGVmOTAxYTdiY2E5ZjU4MnwxNTY2NTI7MTU2NjUyOzEyNzk2NTY3NTQ7MDsxMjc5NTcwMzU0LjQ3NDk7MjMxODkwXzEwOw%3D%3D
    // uploadTokenId=0_5e929ce09b1155753a3921e78d65e992
    // mediaEntry%3Aname=zach+test+3
    // mediaEntry%3AmediaType=5
    // response: <?xml version="1.0" encoding="utf-8"?><xml><result><objectType>KalturaMediaEntry</objectType><id>0_e3ropkdb</id><name>zach test 3</name><description></description><partnerId>156652</partnerId><userId>231890_10</userId><tags></tags><adminTags></adminTags><categories></categories><status>1</status><moderationStatus>6</moderationStatus><moderationCount>0</moderationCount><type>1</type><createdAt>1279571324</createdAt><rank>0</rank><totalRank>0</totalRank><votes>0</votes><groupId></groupId><partnerData></partnerData><downloadUrl>http://cdnbakmi.kaltura.com/p/156652/sp/15665200/raw/entry_id/0_e3ropkdb/version/0</downloadUrl><searchText>  zach test 3 </searchText><licenseType>-1</licenseType><version>0</version><thumbnailUrl>http://cdnbakmi.kaltura.com/p/156652/sp/15665200/thumbnail/entry_id/0_e3ropkdb/version/0</thumbnailUrl><accessControlId>63362</accessControlId><startDate></startDate><endDate></endDate><plays>0</plays><views>0</views><width></width><height></height><duration>0</duration><msDuration>0</msDuration><durationType></durationType><mediaType>5</mediaType><conversionQuality></conversionQuality><sourceType>1</sourceType><searchProviderType></searchProviderType><searchProviderId></searchProviderId><creditUserName></creditUserName><creditUrl></creditUrl><mediaDate></mediaDate><dataUrl>http://cdnbakmi.kaltura.com/p/156652/sp/15665200/flvclipper/entry_id/0_e3ropkdb/version/0</dataUrl><flavorParamsIds></flavorParamsIds></result><executionTime>6.2773299217224</executionTime></xml>
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.baseURL];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@&uploadTokenId=%@&ks=%@", [self.mediaServer apiURLAddFromUploadedFile], token, sessionID];
    NSString *mediaTypeString = (mediaType == CKIAttachmentMediaTypeVideo ? @"1" : @"5");
    NSDictionary *parameters = @{@"mediaEntry:name": @"Media Comment", @"mediaEntry:mediaType": mediaTypeString};
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CKIMediaFileUploadTokenParser *parser = [[CKIMediaFileUploadTokenParser alloc] initWithXMLParser:responseObject];
        [parser parseWithSuccess:^(NSString *uploadID) {
            if (success) {
                success(uploadID);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)getThumbnailForMediaComment:(CKIMediaComment *)mediaComment success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.baseURL];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    CGFloat *height = 100;
    CGFloat *width = 100;
    NSString *urlString = [NSString stringWithFormat:@"/p/%@/thumbnail/entry_id/%@/width/%@/height/%@/bgcolor/000000/type/1/vid_sec/5", self.mediaServer.partnerId, mediaComment.mediaID, width, height];
    
    [self configureMediaServerWithSuccess:^{
        [self GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Got the url for thumb");
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
    
}

@end
