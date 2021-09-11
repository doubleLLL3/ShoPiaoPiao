//
//  BKEHomeTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import "BKEHomeTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#define kMargin 10
#define kLargeMargin 20
#define kImageHeight 130
#define kImageWidth kImageHeight / 1.5
#define kLabelHeight 20
#define kLabelWidth 180
#define kTitleLabelHeight 30
#define kActorLabelHeight 60
#define kButtonHeight 25
#define kButtonWidth 50
#define kFontOfSize 12
#define kFontOfTitleLabelSize 16
#define kFontOfActorLabelSize 10
#define kCornerRadius 10

#define kRatingFormat @"%.1f"
#define kToPurchaseState @"购票"
#define kPurchasedState @"已购票"

#define kShopeeColor [UIColor colorWithRed:238/255.0f green:77/255.0f blue:61/255.0f alpha:1.0f]

@interface BKEHomeTableViewCell ()

@end

@implementation BKEHomeTableViewCell

#pragma mark - Public Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void) updateMovieBasic:(BKEMovieBasicModel *)movieBasic {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:movieBasic.imageURL]];
    [self.titleLabel setText:movieBasic.name];
    
    NSString *sRating = [NSString stringWithFormat:kRatingFormat, movieBasic.rating.doubleValue];
    [self.ratingLabel setText:sRating];

    [self.directorLabel setText:movieBasic.director];
    [self.actorLabel setText:movieBasic.starring];
}

#pragma mark - Private Method

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.ratingLabel];
    [self addSubview:self.directorLabel];
    [self addSubview:self.actorLabel];
    [self.contentView addSubview:self.purchaseButton];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(kImageHeight);
        make.width.mas_equalTo(kImageWidth);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(kMargin);
        make.top.mas_equalTo(self.leftImageView);
        make.height.mas_equalTo(kTitleLabelHeight);
        make.width.mas_equalTo(kLabelWidth);
    }];
    
    [self.ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(kLabelHeight);
        make.width.mas_equalTo(kLabelWidth);
    }];
    
    [self.directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.ratingLabel.mas_bottom);
        make.height.mas_equalTo(kLabelHeight);
        make.width.mas_equalTo(kLabelWidth);
    }];
    
    [self.actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.directorLabel.mas_bottom);
        make.height.mas_equalTo(kActorLabelHeight);
        make.width.mas_equalTo(kLabelWidth);
    }];
    
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kLargeMargin);
        make.centerY.mas_equalTo(self);
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

#pragma mark - Getter

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kFontOfTitleLabelSize];
    }
    return _titleLabel;
}

- (UILabel *)ratingLabel {
    if (!_ratingLabel) {
        _ratingLabel = [[UILabel alloc] init];
        _ratingLabel.font = [UIFont systemFontOfSize:kFontOfSize];
        _ratingLabel.textColor = kShopeeColor;
    }
    return _ratingLabel;
}

- (UILabel *)directorLabel {
    if (!_directorLabel) {
        _directorLabel = [[UILabel alloc] init];
        _directorLabel.font = [UIFont systemFontOfSize:kFontOfSize];
    }
    return _directorLabel;
}

- (UILabel *)actorLabel {
    if (!_actorLabel) {
        _actorLabel = [[UILabel alloc] init];
        _actorLabel.font = [UIFont systemFontOfSize:kFontOfActorLabelSize];
        _actorLabel.textColor = [UIColor grayColor];
        _actorLabel.numberOfLines = 0;
    }
    return _actorLabel;
}

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc] init];
        _purchaseButton.backgroundColor = kShopeeColor;
        _purchaseButton.layer.cornerRadius = kCornerRadius;
        _purchaseButton.layer.masksToBounds = YES;
        _purchaseButton.titleLabel.font = [UIFont systemFontOfSize:kFontOfSize];
        
        [_purchaseButton setTitle:kToPurchaseState forState:UIControlStateNormal];
        [_purchaseButton setTitle:kPurchasedState forState:UIControlStateDisabled];
        
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _purchaseButton;
}

@end
