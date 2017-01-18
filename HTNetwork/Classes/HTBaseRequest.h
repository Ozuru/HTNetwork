//
//  HTBaseRequest.h
//  HTNetwork
//
//  Created by brant on 2017/1/17.
//  Copyright © 2017年 brant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^AFConstructingBlock)(id<AFMultipartFormData> formData);

typedef NS_ENUM(NSInteger, HTAgentType) {
    HTAgentTypeWNS,
    HTAgentTypeAFN,
};

typedef NS_ENUM(NSInteger, HTRequestMethod) {
    HTRequestMethodGet,
    HTRequestMethodPost,
};

typedef NS_ENUM(NSInteger, HTResponseSerializerType) {
    // Default is NSData
    HTResponseSerializerTypeData,
    // JSON object type
    HTResponseSerializerTypeJSON,
    // NSXMLParser type
    HTResponseSerializerTypeXML,
};

// 加密类型
typedef NS_ENUM(NSInteger, HTEncryptionType) {
    // no encryption
    HTEncryptionTypeNone = 0,
    // Session key encryption
    HTEncryptionTypeSession,
    // Random key encryption
    HTEncryptionTypeRandom,
};

@interface HTBaseRequest : NSObject

// http request method. e.g: GET/POST
@property (nonatomic) HTRequestMethod requestMethod;

// request path. e.g: /user/login
@property (nonatomic, copy) NSString *path;

@property (nonatomic) HTResponseSerializerType responseSerializerType;

@property (nonatomic) HTEncryptionType encryptionType;

@property (nonatomic, copy) AFConstructingBlock afConstructingBlock;

@end
