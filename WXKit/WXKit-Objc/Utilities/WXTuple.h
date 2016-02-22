//
//  WXTuple.h
//  WXKit
//
//  Created by Charlie Wu on 2/09/2015.
//  Copyright (c) 2015 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXTuple : NSObject

@property (nonatomic, strong) id first;
@property (nonatomic, strong) id second;
@property (nonatomic, strong) id thrid;
@property (nonatomic, strong) id fourth;
@property (nonatomic, strong) id fifth;
@property (nonatomic, strong) id sixth;
@property (nonatomic, strong) id seventh;
@property (nonatomic, strong) id eighth;
@property (nonatomic, strong) id ninth;
@property (nonatomic, strong) id tenth;

+ (instancetype)tupleWithArray:(NSArray *)array;

@end
