//
//  NSArray+WXKit.h
//  WXKit
//
//  Created by Charlie Wu on 23/12/2013.
//  Copyright (c) 2013 Charlie Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WXKit)

- (id)objectOrNilAtIndex:(NSUInteger)index;

- (instancetype)reverse;

- (id)firstObjectPassTest:(BOOL(^)(id obj))block;

- (NSDictionary *)dictionaryWithKeyPath:(NSString *)keyPath;

- (NSMutableDictionary *)mutableDictionaryWithKeyPath:(NSString *)keyPath;
@end
