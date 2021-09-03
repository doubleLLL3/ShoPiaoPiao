//
//  BKEHomeViewController.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/8/11.
//

#import "BKEHomeViewController.h"
#import "BKEHomeTableViewCell.h"
#import "BKEIntroViewController.h"

@interface BKEHomeViewController () <UITableViewDataSource, UITableViewDelegate, BKEHomeTableViewCellDelegate>

@property(nonatomic, strong, readwrite) UITableView *homeTableView;

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
    
    return ;
}

#pragma mark - UITableViewDataSource

// 一次缓冲的Cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

// 每个位置的Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BKEHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[BKEHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    
//    [cell ];
    
    return cell;
}

#pragma mark - UITableViewDelegate

// 每个Cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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

@end
