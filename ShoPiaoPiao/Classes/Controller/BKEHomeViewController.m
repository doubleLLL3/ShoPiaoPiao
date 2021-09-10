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
#import "BKEMovieBasicModel.h"
#import "BKEMovieDetailModel.h"

#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/SDWebImage.h>

static NSString *const kCellId = @"CellInfo";

@interface BKEHomeViewController () <UITableViewDataSource, UITableViewDelegate, BKEHomeTableViewCellDelegate>

@property(nonatomic, strong) UITableView *homeTableView;
@property(nonatomic, strong) NSMutableArray *movieList;
@property(nonatomic, strong) BKEMovieBasicModel *movieBasic;
@property(nonatomic, strong) MJRefreshNormalHeader *dropDownHeader;
@property(nonatomic, strong) MJRefreshBackNormalFooter *pullFooter;
@property(nonatomic, assign) NSInteger movieListIndex;
@property(nonatomic, strong) BKEIntroViewController *introViewController;


@end

@implementation BKEHomeViewController

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movieListIndex = 0;
    
    [self.view addSubview:self.homeTableView];

    // 下拉刷新
    self.homeTableView.mj_header = self.dropDownHeader;
 
    // 上拉加载更多
    self.homeTableView.mj_footer = self.pullFooter;

    // 先加载一次数据
    [self requestMovieList];
    
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
    }  // ❗️可以在getter方法里注册所有的Cell
    [cell updateMovieBasic:self.movieList[indexPath.row]];

    cell.purchaseButton.backgroundColor = [UIColor redColor];

    [cell.purchaseButton setEnabled:YES];

    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

// 每个Cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

// 点击Cell后进入详细信息页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.introViewController = [[BKEIntroViewController alloc] init];
    self.introViewController.title = @"电影详情";
    
    self.movieBasic = self.movieList[indexPath.row];
    [self.introViewController receiveMovieBasic:self.movieBasic];
    
    [self.navigationController pushViewController:self.introViewController animated:YES];
}

#pragma mark - Other Delegate

// 实现点击购买按钮后的事件：按钮变灰，文本变为“已购买”
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickPuchaseButton:(UIButton *)purchaseButton {
    purchaseButton.backgroundColor = [UIColor grayColor];
    [purchaseButton setEnabled:NO];
    return ;
}

#pragma mark - Private Method
- (void)requestMovieList {
    // 从URL GET json数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;  // 设置不走缓存
    // ❗️weak解决循环引用
    
    [manager GET:@"http://0.0.0.0:8888/data0.json"
      parameters:nil
         headers:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self.movieList removeAllObjects];
        self.movieListIndex = 1;
        
        NSArray *movieArray = responseObject[@"data"];
        for (NSDictionary *movieDic in movieArray) {
            BKEMovieBasicModel *movieBasic = [BKEMovieBasicModel yy_modelWithJSON: movieDic];
            [self.movieList addObject:movieBasic];
        }
        
        [self.homeTableView reloadData];  // 要关注线程，可能需要切换线程
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error!");
    }];
    [self.dropDownHeader endRefreshing];
    [self.pullFooter endRefreshing];      // 只要下拉，就重置上拉的状态
}

- (void)requestMoreMovieBasic {
    // 从URL GET json数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;  // 设置不走缓存
    // ❗️weak解决循环引用
    
    [manager GET:[NSString stringWithFormat:@"http://0.0.0.0:8888/data%ld.json", self.movieListIndex]
      parameters:nil
         headers:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.movieListIndex += 1;
        
        NSArray *movieArray = responseObject[@"data"];
        for (NSDictionary *movieDic in movieArray) {
            BKEMovieBasicModel *movieBasic = [BKEMovieBasicModel yy_modelWithJSON: movieDic];
            [self.movieList addObject:movieBasic];
        }
        
        [self.homeTableView reloadData];
        
        if (((NSArray *)responseObject[@"data"]).count < 1) {
            [self.pullFooter endRefreshingWithNoMoreData];
        } else {
            [self.pullFooter endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error!");
    }];
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

- (MJRefreshNormalHeader *)dropDownHeader {
    if (!_dropDownHeader) {
        _dropDownHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMovieList)];
        
//        // Set the ordinary state of animated images
//        UIImage *idleImages = [UIImage imageNamed:idleImages];
//        [_dropDownHeader setImages:@[idleImages] forState:MJRefreshStateIdle];
//        // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
//        UIImage *pullingImages = [UIImage imageNamed:pullingImages];
//        [_dropDownHeader setImages:@[pullingImages] forState:MJRefreshStatePulling];
//        // Set the refreshing state of animated images
////        SDAnimatedImage *refreshingImages = [SDAnimatedImage imageNamed:@"refreshingImages.gif"];
////        [_dropDownHeader setImages:@[refreshingImages] forState:MJRefreshStateRefreshing];
//        UIImage *refreshingImages = [UIImage imageNamed:refreshingImages];
//        [_dropDownHeader setImages:@[refreshingImages] forState:MJRefreshStateRefreshing];
        
        _dropDownHeader.lastUpdatedTimeLabel.hidden = YES;
        
        [_dropDownHeader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [_dropDownHeader setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [_dropDownHeader setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
    }
    return _dropDownHeader;
}

- (MJRefreshBackNormalFooter *)pullFooter {
    if (!_pullFooter) {
        _pullFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreMovieBasic)];
        
        [_pullFooter setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
        [_pullFooter setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
        [_pullFooter setTitle:@"正在加载更多数据..." forState:MJRefreshStateRefreshing];
        [_pullFooter setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    }
    return _pullFooter;
}

@end
