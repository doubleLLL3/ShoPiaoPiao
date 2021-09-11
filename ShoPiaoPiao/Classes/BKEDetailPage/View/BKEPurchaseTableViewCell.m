//
//  BKEPurchaseTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEPurchaseTableViewCell.h"
#import <Masonry/Masonry.h>

#define kButtonHeight 30
#define kButtonWidth 80
#define kCornerRadius 10
#define kFontOfButtonSize 14

#define kToPurchaseState @"购票"
#define kPurchasedState @"已购票"

#define kShopeeColor [UIColor colorWithRed:238/255.0f green:77/255.0f blue:61/255.0f alpha:1.0f]

@interface BKEPurchaseTableViewCell ()

@property(nonatomic, strong) UIButton *purchaseButton;

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

#pragma mark - Private Method

- (void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;  // 选中Cell不变色
    [self.contentView addSubview:self.purchaseButton];
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(kButtonHeight);
        make.width.mas_equalTo(kButtonWidth);
    }];
    return ;
}

// 点击购票按钮
- (void)purchaseButtonClick {
    self.purchaseButton.backgroundColor = [UIColor grayColor];
    [self.purchaseButton setEnabled:NO];
    
    // 点击购票按钮后，让Controller处理数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickPuchaseButton:)]) {
        [self.delegate tableViewCell:self clickPuchaseButton:self.purchaseButton];
    }
}

# pragma mark - Getter

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc] init];
        _purchaseButton.backgroundColor = kShopeeColor;
        _purchaseButton.layer.cornerRadius = kCornerRadius;
        _purchaseButton.layer.masksToBounds = YES;
        _purchaseButton.titleLabel.font = [UIFont systemFontOfSize:kFontOfButtonSize];
        
        [_purchaseButton setTitle:kToPurchaseState forState:UIControlStateNormal];
        [_purchaseButton setTitle:kPurchasedState forState:UIControlStateDisabled];
        
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _purchaseButton;
}

@end
