//
//  HTNetworkConfigration.m
//  HTNetwork
//
//  Created by brant on 2017/1/17.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "HTNetworkConfigration.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HTNetworkConfigration

+ (HTNetworkConfigration *)shareInstance {
    static HTNetworkConfigration *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    
    return config;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseUrl = @"";
    }
    
    return self;
}

@end

NS_ASSUME_NONNULL_END
