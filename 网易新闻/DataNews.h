//
//  DataNews.h
//  网易新闻
//
//  Created by ZhuDong on 16/5/4.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataNews : NSObject
@property (nonatomic ,copy) NSString *title;
@property (nonatomic,copy) NSString  *digest;
@property (nonatomic,copy) NSString *imgsrc;
@property (nonatomic,copy) NSNumber *replyCount;
+ (instancetype)dataNewsWithDict:(NSDictionary *)dict;
@end
