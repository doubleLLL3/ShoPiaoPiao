//
//  BKEIntroViewController.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import "BKEIntroViewController.h"
#import "BKEInfoTableViewCell.h"
#import "BKEDetailTableViewCell.h"
#import "BKEPurchaseTableViewCell.h"
#import "BKEMovieBasicModel.h"
#import "BKEMovieDetailModel.h"

#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>

#define infoTableViewCellHeight 200
#define detailTableViewCellHeight 400
#define purchaseTableViewCellHeight 50
#define defaultTableViewCellHeight 50


static NSString *const kCellInfo = @"CellInfo";
static NSString *const kCellDetail = @"CellDetail";
static NSString *const kCellPurchase = @"CellPurchase";

@interface BKEIntroViewController () <UITableViewDataSource, UITableViewDelegate, BKEPurchaseTableViewCellDelegate>

@property(nonatomic, strong) UITableView *introTableView;
@property(nonatomic, strong) BKEMovieBasicModel *movieBasic;
@property(nonatomic, strong) BKEMovieDetailModel *movieDetail;

@end

@implementation BKEIntroViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.introTableView];
    
    [self requestMovieDetail:self.movieBasic.movieId];
    
}

#pragma mark - Public Method
- (void) receiveMovieBasic:(BKEMovieBasicModel *)movieBasic {
    self.movieBasic = movieBasic;
    return ;
}

# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieDetail? 3: 0;  // 没数据时不渲染Cell
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 去系统回收池中取对应id的Cell（只有某个Cell被移出屏幕后才会有，所以一开始需要创建很多个Cell）
        BKEInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:kCellInfo];
        if (!infoCell) {
            infoCell = [[BKEInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellInfo];
        }
        [infoCell updateMovieBasic:self.movieBasic movieDetail:self.movieDetail];
        return infoCell;

    } else if (indexPath.row == 1) {
        BKEDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:kCellDetail];
        if (!detailCell) {
            detailCell = [[BKEDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kCellDetail];
        }
        [detailCell updateMovieDetail:self.movieDetail];
        return detailCell;
    } else {
        BKEPurchaseTableViewCell *purchaseCell = [tableView dequeueReusableCellWithIdentifier:kCellPurchase];
        if (!purchaseCell) {
            purchaseCell = [[BKEPurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellPurchase];
        }
        purchaseCell.delegate = self;
        return purchaseCell;
    }
}

#pragma mark - UITableViewDelegate

// 每个Cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return infoTableViewCellHeight;
        case 1:
            return detailTableViewCellHeight;
        case 2:
            return purchaseTableViewCellHeight;
        default:
            return defaultTableViewCellHeight;
    }
}

#pragma mark - Other Delegate

// 实现点击购买按钮后的事件：按钮变灰，文本变为“已购买”。❗️应该放在View里
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickPuchaseButton:(UIButton *)purchaseButton {
    purchaseButton.backgroundColor = [UIColor grayColor];
    [purchaseButton setEnabled:NO];
    return ;
}

#pragma mark - Private Method

- (void)requestMovieDetail:(NSString *)movieId {
    // 从URL GET json数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;  // 设置不走缓存
    // ❗️weak解决循环引用
    // ❗️❗️❗️
    [manager GET:[NSString stringWithFormat:@"https://douban.8610000.xyz/data/%@.json", movieId]
      parameters:nil
         headers:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        self.movieDetail = [BKEMovieDetailModel yy_modelWithJSON: responseObject];
        
        [self.introTableView reloadData];  // 渲染Cell
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error!");
    }];
}

#pragma mark - Getter

- (UITableView *)introTableView {
    if (!_introTableView) {
        _introTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _introTableView.backgroundColor = [UIColor whiteColor];
        _introTableView.separatorStyle = UITableViewCellSeparatorStyleNone;  // 隐藏分割线
        _introTableView.dataSource = self;
        _introTableView.delegate = self;
    }
    return _introTableView;
}

@end
