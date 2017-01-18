//
//  AFNetworkingAgent.h
//  HTNetwork
//
//  Created by brant on 2017/1/17.
//  Copyright © 2017年 brant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFNetworkingAgent : NSObject

+ (AFNetworkingAgent *)shareInstance;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
