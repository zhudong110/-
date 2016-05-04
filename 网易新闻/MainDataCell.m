//
//  MainDataCell.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "MainDataCell.h"
#import "MainDataTableView.h"

@interface MainDataCell ()
@property (nonatomic,strong) MainDataTableView *tableView;
@end
@implementation MainDataCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        MainDataTableView *tableView = [[MainDataTableView alloc] initWithFrame:self.contentView.bounds];
        self.tableView = tableView;

        [self.contentView addSubview:tableView];
    }
    return self;
}

- (void)setChannel:(Channel *)channel{
    _channel = channel;
    self.tableView.channel = channel;
}
@end
