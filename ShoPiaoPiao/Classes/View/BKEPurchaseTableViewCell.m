//
//  BKEPurchaseTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEPurchaseTableViewCell.h"
#import <Masonry/Masonry.h>

@interface BKEPurchaseTableViewCell ()

@property(nonatomic, strong, readwrite) UIButton *purchaseButton;

@end

@implementation BKEPurchaseTableViewCell

#pragma mark - Public Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];  // 需要先调用父类方法
    if (self) {
        [self setupView];
    }
    
    return self;
}

- (void)purchaseButtonClick {
    NSLog(@"Go To Purchase Page!");
}

#pragma mark - Private Method

- (void)setupView {
    [self addSubview:self.purchaseButton];
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    return ;
}

# pragma mark - Getter

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc] init];
        _purchaseButton.backgroundColor = [UIColor redColor];
        [_purchaseButton setTitle:@"购票" forState:UIControlStateNormal];
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _purchaseButton.layer.cornerRadius = 10;
        _purchaseButton.layer.masksToBounds = YES;
    }
    return _purchaseButton;
}

@end
