//
//  DataNews.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/4.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "DataNews.h"

@implementation DataNews
+ (instancetype)dataNewsWithDict:(NSDictionary *)dict{
    DataNews *news = [[DataNews alloc] init];
    [news setValuesForKeysWithDictionary:dict];
    return news;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
