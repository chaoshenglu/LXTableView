//
//  JsonHelper.m
//  ConvertJsonToSwiftVar
//
//  Created by lixiang on 2018/2/2.
//  Copyright © 2018年 com.lixiang. All rights reserved.
//

#import "JsonHelper.h"

@implementation JsonHelper

+ (id)removeNull:(id)dicOrArr {
    if ([dicOrArr isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)dicOrArr count]];
        for (id value in (NSArray *)dicOrArr) {
            if (![value isEqual:[NSNull null]]) {
                [mutableArray addObject:[self removeNull:value]];
            }
        }
        return [NSArray arrayWithArray:mutableArray];
    } else if ([dicOrArr isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:dicOrArr];
        for (id <NSCopying> key in [(NSDictionary *)dicOrArr allKeys]) {
            id value = (NSDictionary *)dicOrArr[key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDictionary[key] = [self removeNull:value];
            }
        }
        return [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    return dicOrArr;
}

@end


