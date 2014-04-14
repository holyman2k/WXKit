//
//  WXAccount.h
//  WXKit
//
//  Created by Charlie Wu on 14/04/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXUser : NSObject
@property (copy, nonatomic) NSNumber *accountId;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@end
