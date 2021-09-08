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
#import "BKEMovieModel.h"
#import "BKEMovieDetailModel.h"

static NSString *const kCellInfo = @"CellInfo";
static NSString *const kCellDetail = @"CellDetail";
static NSString *const kCellPurchase = @"CellPurchase";

@interface BKEIntroViewController () <UITableViewDataSource, UITableViewDelegate, BKEPurchaseTableViewCellDelegate>

@property(nonatomic, strong) UITableView *introTableView;
@property(nonatomic, strong) BKEMovieModel *movieModel;
@property(nonatomic, strong) BKEMovieDetailModel *movieDetailModel;

@end

@implementation BKEIntroViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.introTableView];
    
}

#pragma mark - Public Method
- (void) setupMovieData:(BKEMovieModel *)movieData setupMovieDetail:(BKEMovieDetailModel *)movieDetail {
    self.movieModel = movieData;
    self.movieDetailModel = movieDetail;
    [self.introTableView reloadData];  // 渲染Cell
}

# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieDetailModel? 3: 0;  // 没数据时不渲染Cell
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 去系统回收池中取对应id的Cell（只有某个Cell被移出屏幕后才会有，所以一开始需要创建很多个Cell）
        BKEInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:kCellInfo];
        if (!infoCell) {
            infoCell = [[BKEInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellInfo];
            infoCell.selectionStyle = UITableViewCellSelectionStyleNone;  // 选中Cell不变色
        }
        [infoCell setMovieData:self.movieModel setMovieDetail:self.movieDetailModel];
        return infoCell;

    } else if (indexPath.row == 1) {
        BKEDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:kCellDetail];
        if (!detailCell) {
            detailCell = [[BKEDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kCellDetail];
            detailCell.selectionStyle = UITableViewCellSelectionStyleNone;  // 选中Cell不变色
            detailCell.contentView.userInteractionEnabled = NO;  // ❗️禁止Cell里的交互，否则会和UIScrollView的滚动冲突
        }
        [detailCell setMovieDetail:self.movieDetailModel];
        return detailCell;
    } else {
        BKEPurchaseTableViewCell *purchaseCell = [tableView dequeueReusableCellWithIdentifier:kCellPurchase];
        if (!purchaseCell) {
            purchaseCell = [[BKEPurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellPurchase];
            purchaseCell.selectionStyle = UITableViewCellSelectionStyleNone;  // 选中Cell不变色
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
            return 200;
        case 1:
            return 400;
        case 2:
            return 100;
        default:
            return 100;
    }
}

#pragma mark - Other Delegate

// 实现点击购买按钮后的事件：按钮变灰，文本变为“已购买”
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickPuchaseButton:(UIButton *)purchaseButton {
    purchaseButton.backgroundColor = [UIColor grayColor];
    [purchaseButton setEnabled:NO];
    return ;
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
