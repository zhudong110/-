//
//  ViewController.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "ViewController.h"
#import "NewsChannelView.h"
#import "MainDataCollectionView.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frameOne =   CGRectMake(0, 50, kScreenSize.width, kScreenSize.height - 50);
    UICollectionViewFlowLayout *layoutOne = [[UICollectionViewFlowLayout alloc] init];
    layoutOne.itemSize = frameOne.size;
    layoutOne.minimumInteritemSpacing = 0;
    layoutOne.minimumLineSpacing = 0;
    layoutOne.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    MainDataCollectionView *mainView = [[MainDataCollectionView alloc] initWithFrame:frameOne collectionViewLayout:layoutOne];

    [self.view addSubview:mainView];
    
    
    
    CGRect frame = CGRectMake(0, 20, kScreenSize.width, 30);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    NewsChannelView *channelView = [[NewsChannelView alloc] initWithFrame:frame collectionViewLayout:layout];
    channelView.showsVerticalScrollIndicator = NO;
    channelView.showsHorizontalScrollIndicator = NO;
    channelView.bounces = NO;
                                   
    channelView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:channelView];
}

@end
