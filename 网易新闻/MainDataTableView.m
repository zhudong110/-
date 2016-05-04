//
//  MainDataTableView.m
//  网易新闻
//
//  Created by ZhuDong on 16/5/3.
//  Copyright © 2016年 itheima.com. All rights reserved.
//

#import "MainDataTableView.h"
#import "DataNews.h"
#import "MainTableViewCell.h"
#define kMainDataCell @"kMainDataCell"


@interface MainDataTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIActivityIndicatorView *activity;
@property (nonatomic,strong) NSMutableArray *newses;
@end
@implementation MainDataTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self addSubview:self.activity];
        
        [self registerClass:[MainTableViewCell class] forCellReuseIdentifier:kMainDataCell];
        self.rowHeight = 80;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  self;
}
- (void)setChannel:(Channel *)channel{
    _channel = channel;
    [self.newses removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/0-20.html",channel.tid];
    [self.activity startAnimating];
    [self loadDataWithUrlStr:urlStr channel:channel];
}

- (void)loadDataWithUrlStr:(NSString *)urlStr channel:(Channel *)channel{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (data && !error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSArray *array = dict[channel.tid];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                DataNews *news = [DataNews dataNewsWithDict:dic];
                [self.newses addObject:news];
            }];
            //MARK:刷新数据
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"加载数据完毕");
                [self reloadData];
                [self.activity stopAnimating];
            });
            
        }
    }] resume];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMainDataCell forIndexPath:indexPath];
    
    DataNews *news = self.newses[indexPath.item];

    cell.news = news;
    return cell;
}
- (NSMutableArray *)newses{
    if (!_newses) {
        _newses = [NSMutableArray array];
    }
    return _newses;
}
- (UIActivityIndicatorView *)activity{
    if (_activity == nil) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.center = self.center;
    }
    return _activity;
}
@end
