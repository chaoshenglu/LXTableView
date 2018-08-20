//
//  JsonHelper.h
//  ConvertJsonToSwiftVar
//
//  Created by lixiang on 2018/2/2.
//  Copyright © 2018年 com.lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonHelper : NSObject

+ (NSString *)findVarWithDic:(NSDictionary *)dic;

+ (id)removeNull:(id)dicOrArr;

@end
