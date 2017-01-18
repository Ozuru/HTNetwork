//
//  HTAFRequestGenerator.m
//  HTNetwork
//
//  Created by brant on 2017/1/18.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "HTAFRequestGenerator.h"
#import <AFNetworking.h>
#import "HTBaseRequest.h"
#import "HTNetworkConfigration.h"

@implementation HTAFRequestGenerator

+ (NSMutableURLRequest *)generatorURLRequest:(HTBaseRequest *)request {
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    NSError *error = nil;
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:[HTAFRequestGenerator requestMethod:request.requestMethod] URLString:@"" parameters:@{} error:&error];
    
    if (request.afConstructingBlock) {
//        urlRequest = requestSerializer multipartFormRequestWithMethod:<#(nonnull NSString *)#> URLString:<#(nonnull NSString *)#> parameters:<#(nullable NSDictionary<NSString *,id> *)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData>  _Nonnull formData)block#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>
    }
    
    return urlRequest;
}

+ (NSString *)requestMethod:(HTRequestMethod)method {
    NSString *requestMethod = nil;
    switch (method) {
        case HTRequestMethodGet:
            requestMethod = @"GET";
            break;
        case HTRequestMethodPost:
            requestMethod = @"POST";
            break;
            
        default:
            requestMethod = @"POST";
            break;
    }
    
    return requestMethod;
}

@end
