//
//  MainTableViewCell.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/4.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UIImageView+WebCache.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kMainDataCell @"kMainDataCell"

@interface MainTableViewCell ()
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *replyCount;
@property (nonatomic,strong) UIView *sepView;
@end
@implementation MainTableViewCell
//即时用注册制实现tableViewCell的新建,仍然是调用此方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.subTitleLabel = [[UILabel alloc] init];
        self.replyCount = [[UILabel alloc] init];
        self.sepView = [[UIView alloc] init];
        self.sepView.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:self.sepView];
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.replyCount];
    }
    return self;
}
-(void)setNews:(DataNews *)news{
    _news = news;
    NSURL *url = [NSURL URLWithString:news.imgsrc];
    [self.iconView sd_setImageWithURL:url];
    
    self.titleLabel.text = news.title;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.subTitleLabel.text = news.digest;
    self.subTitleLabel.font = [UIFont systemFontOfSize:14];
    self.subTitleLabel.numberOfLines = 2;
    

    self.replyCount.text = [NSString stringWithFormat:@"回帖数:%@",news.replyCount];
    self.replyCount.font = [UIFont systemFontOfSize:14];
    self.replyCount.textColor = [UIColor lightGrayColor];
    

}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 8;
    CGFloat imageW = 100;
    CGFloat imageH = 64;
    self.iconView.frame = CGRectMake(margin, margin, imageW, imageH);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + margin, margin, kScreenSize.width - 3 * margin - imageW, 25);

    self.subTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + margin, CGRectGetMaxY(self.titleLabel.frame), kScreenSize.width - 3 * margin - imageW, 40);
    
    [self.replyCount sizeToFit];
    self.replyCount.frame = CGRectMake(kScreenSize.width - margin - self.replyCount.bounds.size.width, CGRectGetMaxY(self.iconView.frame) - self.replyCount.bounds.size.height, self.replyCount.bounds.size.width, self.replyCount.bounds.size.height);
    
    self.sepView.frame = CGRectMake(0, self.contentView.bounds.size.height - 5, kScreenSize.width, 5);
}
@end
