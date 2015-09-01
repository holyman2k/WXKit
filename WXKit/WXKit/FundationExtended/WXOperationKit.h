//
//  WXProgressKit.h
//  WXKit
//
//  Created by Charlie Wu on 1/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^TaskBlock)(NSDictionary *previousResults);

@interface WXOperationKit : NSObject

+ (instancetype)kit;

- (WXOperationKit *)joinTask:(TaskBlock)task withName:(NSString *)name;
- (WXOperationKit *)thenDoTask:(TaskBlock)task withName:(NSString *)name;
- (void)startOnCompletion:(VoidBlock)completion;

@end
