//
//  NewsChannelCell.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "NewsChannelCell.h"

@interface NewsChannelCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@end
@implementation NewsChannelCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}
- (void)setChannel:(Channel *)channel{
    _channel = channel;
    self.nameLabel.text = channel.tname;
    
    UIFont *font;
    if (self.selected) {
        self.nameLabel.textColor = [UIColor yellowColor];
        font = [UIFont systemFontOfSize:17];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        font = [UIFont systemFontOfSize:14];
    }
    self.nameLabel.font = font;
    [self.nameLabel sizeToFit];
    //选中(取消选中)cell后并不会掉用layoutSubviews方法,需要手动调用才可以
    [self layoutSubviews];

}

- (void)layoutSubviews{
    [super layoutSubviews];
   
    self.nameLabel.frame = CGRectMake((self.contentView.bounds.size.width - self.nameLabel.bounds.size.width)*0.5, (self.contentView.bounds.size.height - self.nameLabel.bounds.size.height)*0.5, self.nameLabel.bounds.size.width, self.nameLabel.bounds.size.height);
}
@end
