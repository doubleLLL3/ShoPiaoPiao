//
//  BKEHomeViewController.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/8/11.
//

#import "BKEHomeViewController.h"
#import "BKEHomeTableViewCell.h"
#import "BKEIntroViewController.h"
#import "BKEMovieListLoader.h"
#import "BKEMovieModel.h"

#import <AFNetworking/AFNetworking.h>
#include <YYModel/YYModel.h>

static NSString *const kCellId = @"CellInfo";

@interface BKEHomeViewController () <UITableViewDataSource, UITableViewDelegate, BKEHomeTableViewCellDelegate>

@property(nonatomic, strong, readwrite) UITableView *homeTableView;
@property(nonatomic, strong, readwrite) NSMutableArray *movieList;

@end

@implementation BKEHomeViewController

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    //
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.homeTableView];
    
    // 拉取网络json数据
    [[AFHTTPSessionManager manager] GET:@"http://localhost:8888/data1.json" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        for (int i = 0; i < ((NSArray *)responseObject[@"data"]).count; ++i) {
            BKEMovieModel *movieData = [BKEMovieModel yy_modelWithJSON: responseObject[@"data"][i]];  // ❓是否需要进入"data"
            [self.movieList addObject:movieData];
        }
        
        [self.homeTableView reloadData];  // ❗️要关注线程，如果不是主线程，先切换线程
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"0");
    }];
    
    
    return ;
}

#pragma mark - UITableViewDataSource

// 一次缓冲的Cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieList.count;
}

// 每个位置的Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BKEHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (!cell) {
        cell = [[BKEHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellId];
        [cell setMovieData:self.movieList[indexPath.row]];
        cell.delegate = self;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

// 每个Cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

// 点击Cell后响应的View
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BKEIntroViewController *introController = [[BKEIntroViewController alloc] init];
    introController.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.navigationController pushViewController:introController animated:YES];
}

#pragma mark - Other Delegate

// 实现点击购买按钮后的事件：按钮变灰，文本变为“已购买”，需存储状态
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickPuchaseButton:(UIButton *)purchaseButton {
    
}

#pragma mark - Getter

- (UITableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _homeTableView.backgroundColor = [UIColor whiteColor];
        _homeTableView.dataSource = self;
        _homeTableView.delegate = self;
    }
    return _homeTableView;
}

- (NSMutableArray *)movieList {
    if (!_movieList) {
        _movieList = @[].mutableCopy;
    }
    return _movieList;
}

@end
