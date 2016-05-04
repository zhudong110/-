//
//  Channel.h
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
@property (nonatomic,copy) NSString *tid;
@property (nonatomic,copy) NSString *tname;

+ (instancetype)channelWithDict:(NSDictionary *)dict;
@end
