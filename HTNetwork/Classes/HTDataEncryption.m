//
//  HTDataEncryption.m
//  HTNetwork
//
//  Created by brant on 2017/1/18.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "HTDataEncryption.h"
#import "HTBaseRequest.h"

@implementation HTDataEncryption

- (void)encryptRequest:(HTBaseRequest *)request {
    
    switch (request.encryptionType) {
        case HTEncryptionTypeNone:
            
            break;
        case HTEncryptionTypeRandom: {
            
            break;
        }
        case HTEncryptionTypeSession: {
            
            break;
        }
            
        default:
            break;
    }
    
    
}

@end
