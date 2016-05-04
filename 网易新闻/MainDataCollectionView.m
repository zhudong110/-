//
//  MainDataCollectionView.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "MainDataCollectionView.h"
#import "MainDataCell.h"
#define kMainDataCell @"MainDataCell"


@interface MainDataCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) NSMutableArray *channels;
@end
@implementation MainDataCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;

        [self registerClass:[MainDataCell class] forCellWithReuseIdentifier:kMainDataCell];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotify:) name:@"ChannelDidLoadData" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(channelDidSelected:) name:@"channelSelectItemAtIndexPath" object:nil];
    }
    return self;
}

- (void)channelDidSelected:(NSNotification *)notify{
    NSIndexPath *indexPath = notify.object;
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
- (void)recieveNotify:(NSNotification *)notify{
    self.channels = notify.object;
    [self reloadData];
}
#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSIndexPath *indexPath = [[self indexPathsForVisibleItems] lastObject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MainDataCollectionViewDidScroll" object:indexPath];
    NSLog(@"scrollView%@",indexPath);
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainDataCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainDataCell forIndexPath:indexPath];
    Channel *channel = self.channels[indexPath.item];
    cell.channel = channel;
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}

@end
