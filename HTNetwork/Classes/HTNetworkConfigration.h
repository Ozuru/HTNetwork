//
//  HTNetworkConfigration.h
//  HTNetwork
//
//  Created by brant on 2017/1/17.
//  Copyright © 2017年 brant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTNetworkConfigration : NSObject

+ (HTNetworkConfigration *)shareInstance;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

// base request url, default is empty(@""). e.g: @"http://www.nihao520.com"
@property (nonatomic, copy) NSString *baseUrl;

// test server base url
@property (nonatomic, copy) NSString *baseTestUrl;

// http headers, default is nil. e.g: @{ @"version" : @"2.2.8" }
@property (nonatomic, copy, nullable) NSDictionary *httpHeaders;

// request timeout interval
@property (nonatomic) NSTimeInterval timeoutInterval;

@end

NS_ASSUME_NONNULL_END
