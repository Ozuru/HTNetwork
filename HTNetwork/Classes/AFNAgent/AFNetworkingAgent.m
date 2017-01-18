//
//  AFNetworkingAgent.m
//  HTNetwork
//
//  Created by brant on 2017/1/17.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "AFNetworkingAgent.h"
#import <AFNetworking.h>
#import "HTNetworkConfigration.h"
#import "HTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFNetworkingAgent ()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSURLSessionDataTask *> *allTaskIdentifiers;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, HTBaseRequest *> *requests;

@property (nonatomic, strong) NSCondition *lock;

// the run queue of afn callback block
@property (nonatomic, strong) dispatch_queue_t completionQueue;

@end

@implementation AFNetworkingAgent

+ (AFNetworkingAgent *)shareInstance {
    static AFNetworkingAgent *agent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        agent = [[self alloc] init];
    });
    
    return agent;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _lock = [[NSCondition alloc] init];
        _completionQueue = dispatch_queue_create("com.hellotalk.afnetworking.completionQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}


/**
 * Send data request
 *
 * @param request url request
 * @return identifier  an identifier for this task, assigned by and unique to the owning session, can use to cancel the task
 */
- (NSInteger)dataTaskWithRequest:(NSMutableURLRequest *)request {
    
    __weak typeof(self) weakSelf = self;
    __block NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id  _Nullable responseObject, NSError *_Nullable error) {
        [weakSelf requestResult:task response:response responseObject:responseObject error:error];
    }];
    
    // save the task identifier in memory
    NSInteger taskIdentifier = task.taskIdentifier;
    [self.lock lock];
    [self.allTaskIdentifiers setObject:task forKey:@(taskIdentifier)];
    [self.lock unlock];
    
    // resume the task
    [task resume];
    
    return taskIdentifier;
}

/**
 Cancel all task
 */
- (void)cancelAllTasks {
    __weak typeof(self) weakSelf = self;
    [self.allTaskIdentifiers enumerateKeysAndObjectsUsingBlock:^(id key, NSURLSessionDataTask *task, BOOL * stop) {
        
        [weakSelf.lock lock];
        [self.allTaskIdentifiers removeObjectForKey:key];
        [weakSelf.lock unlock];
        
        [task cancel];
    }];
}

/**
 Cancel the task by task identifier

 @param requestIdentifier the task identifier to cancel
 */
- (void)cancelTaskWithIdentifier:(NSInteger)requestIdentifier {
    NSURLSessionDataTask *task = [self.allTaskIdentifiers objectForKey:@(requestIdentifier)];
    
    [self.lock lock];
    [self.allTaskIdentifiers removeObjectForKey:@(requestIdentifier)];
    [self.lock unlock];
    
    [task cancel];
}

#pragma mark - private method

- (void)requestResult:(NSURLSessionDataTask *)task response:(NSURLResponse *)response responseObject:(nullable id)responseObject error:(nullable NSError *)error {
    
}

#pragma mark - getters/setters

- (AFURLSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:self.sessionConfiguration];
        _sessionManager.completionQueue = self.completionQueue;
    }

    return _sessionManager;
}

- (NSURLSessionConfiguration *)sessionConfiguration {
    if (!_sessionConfiguration) {
        _sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        if ([HTNetworkConfigration shareInstance].timeoutInterval > 0) {
            _sessionConfiguration.timeoutIntervalForRequest = [HTNetworkConfigration shareInstance].timeoutInterval;
        }
    }
    
    return _sessionConfiguration;
}

- (NSMutableDictionary<NSNumber *, NSURLSessionDataTask *> *)allTaskIdentifiers {
    if (!_allTaskIdentifiers) {
        _allTaskIdentifiers = [[NSMutableDictionary alloc] init];
    }
    
    return _allTaskIdentifiers;
}

- (NSMutableDictionary *)requests {
    if (!_requests) {
        _requests = [[NSMutableDictionary alloc] init];
    }
    
    return _requests;
}

@end

NS_ASSUME_NONNULL_END
