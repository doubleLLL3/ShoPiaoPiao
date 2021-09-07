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

static NSString *const kCellInfo = @"CellInfo";
static NSString *const kCellDetail = @"CellDetail";
static NSString *const kCellPurchase = @"CellPurchase";

@interface BKEIntroViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *introTableView;

@end

@implementation BKEIntroViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.introTableView];
    
}

# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 去系统回收池中取对应id的Cell（只有某个Cell被移出屏幕后才会有，所以一开始需要创建很多个Cell）
        BKEInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:kCellInfo];
        if (!infoCell) {
            infoCell = [[BKEInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellInfo];
//            cell.delegate = self;
        }
        return infoCell;

    } else if (indexPath.row == 1) {
        BKEDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:kCellDetail];
        if (!detailCell) {
            detailCell = [[BKEDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kCellDetail];
            detailCell.contentView.userInteractionEnabled = NO;  // ❗️禁止Cell里的交互，否则会和UIScrollView的滚动冲突
        }
        return detailCell;
    } else {
        BKEPurchaseTableViewCell *purchaseCell = [tableView dequeueReusableCellWithIdentifier:kCellPurchase];
        if (!purchaseCell) {
            purchaseCell = [[BKEPurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellPurchase];
        }
        return purchaseCell;
    }
}

#pragma mark - UITableViewDelegate

// 每个Cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

#pragma mark - Getter

- (UITableView *)introTableView {
    if (!_introTableView) {
        _introTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 90)];
        _introTableView.backgroundColor = [UIColor whiteColor];
        _introTableView.dataSource = self;
        _introTableView.delegate = self;
    }
    return _introTableView;
}

@end
