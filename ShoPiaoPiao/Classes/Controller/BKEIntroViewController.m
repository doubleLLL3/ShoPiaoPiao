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

@interface BKEIntroViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UITableView *introTableView;

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
        static NSString *id1 = @"CellInfo";
        // 去系统回收池中取对应id的Cell（只有某个Cell被移出屏幕后才会有，所以一开始需要创建很多个Cell）
        BKEInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:id1];
        if (!infoCell) {
            infoCell = [[BKEInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id1];
//            cell.delegate = self;
        }
        return infoCell;

    } else if (indexPath.row == 1) {
        static NSString *id2 = @"CellDetail";
        BKEDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:id2];
        if (!detailCell) {
            detailCell = [[BKEDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:id2];
        }
        return detailCell;
    } else {
        static NSString *id3 = @"CellPurchase";
        BKEPurchaseTableViewCell *purchaseCell = [tableView dequeueReusableCellWithIdentifier:id3];
        if (!purchaseCell) {
            purchaseCell = [[BKEPurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id3];
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
        self.introTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 90)];
        self.introTableView.backgroundColor = [UIColor whiteColor];
        self.introTableView.dataSource = self;
        self.introTableView.delegate = self;
    }
    return _introTableView;
}

@end
