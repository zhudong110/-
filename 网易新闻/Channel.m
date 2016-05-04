//
//  Channel.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "Channel.h"

@implementation Channel
+ (instancetype)channelWithDict:(NSDictionary *)dict{
    Channel *channel = [[Channel alloc] init];
    [channel setValuesForKeysWithDictionary:dict];
    return channel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
