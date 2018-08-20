//
//  JsonHelper.m
//  ConvertJsonToSwiftVar
//
//  Created by lixiang on 2018/2/2.
//  Copyright © 2018年 com.lixiang. All rights reserved.
//

#import "JsonHelper.h"

@implementation JsonHelper

+ (BOOL)judgePureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)judgePureFloat:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)stringWithDic:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)findVarWithDic:(NSDictionary *)dic {
    NSMutableDictionary *newDic = [NSMutableDictionary new];
    for (NSString *key in dic.allKeys) {
        id value = dic[key];
        if ([value isKindOfClass:[NSDictionary class]] == NO && [value isKindOfClass:[NSArray class]] == NO){
            [newDic addEntriesFromDictionary:@{key:value}];
        }
    }
    if (newDic.allKeys == 0){
        return @"无法解析此字典";
    }
    NSString *jsonStr = [self stringWithDic:newDic];
    if (jsonStr == nil){
        return @"无法解析此字典";
    }
    NSMutableString *result = [NSMutableString new];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSArray *arr = [jsonStr componentsSeparatedByString:@","];
    for (NSString *kvStr in arr) {
        NSString *str = @"";
        NSArray *kvArr = [kvStr componentsSeparatedByString:@":"];
        NSString *key_quotation_marks = kvArr.firstObject;
        NSString *key = [key_quotation_marks stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        key = [key stringByReplacingOccurrencesOfString:@"{" withString:@""];
        NSString *value = kvArr.lastObject;
        if ([value containsString:@"\""]){
            
            str = [NSString stringWithFormat:@"\n///\nvar %@ : String?",key];
            
        }else if([value containsString:@"["]){
            
            str = [NSString stringWithFormat:@"\n///\nvar %@ : [XXModel]?",key];
            
        }else if([value containsString:@"."]){
            
            if ([self judgePureFloat:value]) {
                str = [NSString stringWithFormat:@"\n///\nvar %@ : Double?",key];
            }
            
        }else if([value containsString:@"null"]){
            
            str = [NSString stringWithFormat:@"\n///\nvar %@ :xxx?",key];
            
        }else if([value containsString:@"{"]){
            
            str = [NSString stringWithFormat:@"\n///\nvar %@ : XXModel?",key];
            
        }else if([value containsString:@"false"]){
            
            str = [NSString stringWithFormat:@"\n///\nvar %@ : Bool?",key];
            
        }else if([value containsString:@"true"]){
            
            str = [NSString stringWithFormat:@"\n///\nvar %@ : Bool?",key];
            
        }else {
            
            if ([self judgePureInt:value]) {
                str = [NSString stringWithFormat:@"\n///\nvar %@ : Int?",key];
            }
            
        }
        
        if ([result containsString:str] == false) {
            [result appendString:str];
        }
    }
    
    return [NSString stringWithString:result];
}

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


