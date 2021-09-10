//
//  BKEPurchaseTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEPurchaseTableViewCell.h"
#import <Masonry/Masonry.h>

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
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    return ;
}

- (void)purchaseButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickPuchaseButton:)]) {
        [self.delegate tableViewCell:self clickPuchaseButton:self.purchaseButton];
    }
}

# pragma mark - Getter

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc] init];
        _purchaseButton.backgroundColor = [UIColor redColor];
        _purchaseButton.layer.cornerRadius = 10;
        _purchaseButton.layer.masksToBounds = YES;
        _purchaseButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_purchaseButton setTitle:@"购票" forState:UIControlStateNormal];
        [_purchaseButton setTitle:@"已购票" forState:UIControlStateDisabled];
        
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _purchaseButton;
}

@end
