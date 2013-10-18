//
//  CK2Client+TestingClient.m
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Client+TestingClient.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface CK2TestClient : CK2Client
@property (nonatomic) NSMutableSet *errorPaths;
@property (nonatomic) NSMutableDictionary *objectsByPath;
@end

@implementation CK2Client (TestingClient)

+ (CK2Client *)testClient
{
    static CK2Client *testClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        testClient = [CK2TestClient new];
    });
    return testClient;
}

+ (void)useTestClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sharedClient = class_getClassMethod(self, @selector(sharedClient));
        Method testClient = class_getClassMethod(self, @selector(testClient));
        method_exchangeImplementations(sharedClient, testClient);
    });
}

- (void)returnErrorForPath:(NSString *)path
{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)returnResponseObject:(id)responseObject forPath:(NSString *)path
{
    [self doesNotRecognizeSelector:_cmd];
}

@end


@implementation CK2TestClient

- (id)init
{
    self = [super init];
    if (self) {
        self.errorPaths = [NSMutableSet set];
        self.objectsByPath = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)returnErrorForPath:(NSString *)path
{
    [self.errorPaths addObject:path];
}

- (void)returnResponseObject:(id)responseObject forPath:(NSString *)path
{
    // path is required to be non-nil
    NSParameterAssert(path);
    
    if (responseObject == nil) {
        [self.objectsByPath removeObjectForKey:path];
    } else {
        [self.errorPaths removeObject:path];
        self.objectsByPath[path] = responseObject;
    }
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSParameterAssert(URLString);
    
    if ([self.errorPaths containsObject:URLString]) {
        failure(nil, [NSError errorWithDomain:@"com.instructure.CanvasKit" code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"CK2TestClient error.", @"Error only used in testing")}]);
        return nil;
    }
    
    id responseObject = self.objectsByPath[URLString];
    if (responseObject != nil) {
        success(nil, responseObject);
        return nil;
    }
    
    [NSException raise:NSInvalidArgumentException format:@"There is no test configuration for the given path (%@)", URLString];
    return nil;
}

//- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSHTTPURLResponse *, id))success failure:(void (^)(NSError *))failure
//{
//    NSParameterAssert(URLString);
//    
//    if ([self.errorPaths containsObject:URLString]) {
//        failure([NSError errorWithDomain:@"com.instructure.CanvasKit" code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"CK2TestClient error.", @"Error only used in testing")}]);
//        return nil;
//    }
//    
//    id responseObject = self.objectsByPath[URLString];
//    if (responseObject != nil) {
//        success(nil, responseObject);
//        return nil;
//    }
//
//    [NSException raise:NSInvalidArgumentException format:@"There is no test configuration for the given path (%@)", URLString];
//    return nil;
//}

@end
