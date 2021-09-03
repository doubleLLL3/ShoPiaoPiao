//
//  BKEPurchaseTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEPurchaseTableViewCell.h"

@interface BKEPurchaseTableViewCell ()

@property(nonatomic, strong, readwrite) UIButton *purchaseButton;

@end

@implementation BKEPurchaseTableViewCell

#pragma mark - Public Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];  // 需要先调用父类方法
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.purchaseButton];
    }
    
    return self;
}

- (void)purchaseButtonClick {
    NSLog(@"Go To Purchase Page!");
}

# pragma mark - Getter

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 80, 60, 20)];
        _purchaseButton.backgroundColor = [UIColor redColor];
        [_purchaseButton setTitle:@"购票" forState:UIControlStateNormal];
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _purchaseButton.layer.cornerRadius = 10;
        _purchaseButton.layer.masksToBounds = YES;
    }
    return _purchaseButton;
}

@end
