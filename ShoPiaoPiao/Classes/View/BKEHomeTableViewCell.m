//
//  BKEHomeTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import "BKEHomeTableViewCell.h"

@interface BKEHomeTableViewCell ()

// 电影封面、标题、评分、导演、演员表、购票按钮
@property(nonatomic, strong, readwrite) UIImageView *leftImageView;
@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *ratingLabel;
@property(nonatomic, strong, readwrite) UILabel *directorLabel;
@property(nonatomic, strong, readwrite) UILabel *actorLabel;
@property(nonatomic, strong, readwrite) UIButton *purchaseButton;

@end

@implementation BKEHomeTableViewCell

#pragma mark - Public Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.leftImageView];
        
        [self.contentView addSubview:self.titleLabel];
        
        [self.contentView addSubview:self.ratingLabel];
        
        [self.contentView addSubview:self.directorLabel];
        
        [self.contentView addSubview:self.actorLabel];
        
        [self.contentView addSubview:self.purchaseButton];
    }
    return self;
}


// ❓这个里面可以包含delegate的Click；捋一捋怎么用
- (void)purchaseButtonClick {
    NSLog(@"Go To Purchase Page!");
}

#pragma mark - Getter

// ❗️修改为相对布局（Mansory）
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 70, 70)];
        _leftImageView.backgroundColor = [UIColor orangeColor];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, 200, 30)];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)ratingLabel {
    if (!_ratingLabel) {
        _ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 100, 10)];
        _ratingLabel.backgroundColor = [UIColor grayColor];
        _ratingLabel.font = [UIFont systemFontOfSize:12];
        _ratingLabel.textColor = [UIColor redColor];
    }
    return _ratingLabel;
}

- (UILabel *)directorLabel {
    if (!_directorLabel) {
        _directorLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 60, 100, 20)];
        _directorLabel.backgroundColor = [UIColor lightGrayColor];
        _directorLabel.font = [UIFont systemFontOfSize:12];
        _directorLabel.textColor = [UIColor redColor];
    }
    return _directorLabel;
}

- (UILabel *)actorLabel {
    if (!_actorLabel) {
        _actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 85, 100, 20)];
        _actorLabel.backgroundColor = [UIColor grayColor];
        _actorLabel.font = [UIFont systemFontOfSize:12];
        _actorLabel.textColor = [UIColor redColor];
    }
    return _actorLabel;
}

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc] initWithFrame:CGRectMake(330, 40, 50, 30)];
        _purchaseButton.backgroundColor = [UIColor redColor];
        [_purchaseButton setTitle:@"购票" forState:UIControlStateNormal];
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _purchaseButton.layer.cornerRadius = 10;
        _purchaseButton.layer.masksToBounds = YES;
    }
    return _purchaseButton;
}

@end
