//
//  NewsChannelView.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "NewsChannelView.h"
#import "NewsChannelCell.h"
#import "Channel.h"

#define kNewsChannelCell @"NewsChannelCell"

@interface NewsChannelView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *channels;
@property (nonatomic,strong) NewsChannelCell *selectedCell;
@end
@implementation NewsChannelView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.allowsMultipleSelection = NO;
        
        [self registerClass:[NewsChannelCell class] forCellWithReuseIdentifier:kNewsChannelCell];
        
        //MARK:加载数据源 http://127.0.0.1/news.json
        [self loadDataWithUrlStr:@"http://127.0.0.1/news.json" completionBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChannelDidLoadData" object:self.channels];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [self selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            
//            NewsChannelCell *cell = (NewsChannelCell *)[self cellForItemAtIndexPath:indexPath];
//            NSLog(@"%@",self.channels);
//            cell.selected = YES;
//            self.selectedCell = cell;
//             NSLog(@"%@",self.selectedCell);
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MainDataDidScroll:) name:@"MainDataCollectionViewDidScroll" object:nil];
        }];
        

    }
    return self;
}

#warning 下面滑动页面 上面选中cell无法取消?
- (void)MainDataDidScroll:(NSNotification *)notify{
    NSIndexPath *indexPath = notify.object;
//    NSLog(@"%@",indexPath);
//    NSLog(@"%@",self.selectedCell);
    self.selectedCell.selected = NO;
     NewsChannelCell *cell = (NewsChannelCell *)[self cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    self.selectedCell = cell;

//    NSLog(@"%@",self.selectedCell);
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self collectionView:self didSelectItemAtIndexPath:indexPath];
    [self selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
}
- (void)loadDataWithUrlStr:(NSString *)urlStr completionBlock:(void(^)())completionBlock{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data && !connectionError) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0 error:NULL];
            NSArray *array = dict[@"tList"];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                Channel *channel = [Channel channelWithDict:obj];
                [self.channels addObject:channel];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
                if (completionBlock) {
                    completionBlock();
                }
            });
            
        }
    }];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    Channel *channel = self.channels[indexPath.item];
    return  [self sizeForNSString:channel.tname];
}

- (CGSize)sizeForNSString:(NSString *)str{
    UILabel *label = [[UILabel alloc] init];
    label.text = str;
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    return label.bounds.size;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NewsChannelCell *cell = (NewsChannelCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.channel = self.channels[indexPath.item];
    
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"channelSelectItemAtIndexPath" object:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NewsChannelCell *cell = (NewsChannelCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.channel = self.channels[indexPath.item];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channels.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewsChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsChannelCell forIndexPath:indexPath];
    
    Channel *channel = self.channels[indexPath.item];
    cell.channel = channel;
//    NSLog(@"%@",cell);
    return cell;
}
- (NSMutableArray *)channels{
    if (_channels == nil) {
        _channels = [NSMutableArray array];
    }
    return _channels;
}
@end
