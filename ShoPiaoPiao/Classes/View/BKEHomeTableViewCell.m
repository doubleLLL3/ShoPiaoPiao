//
//  BKEHomeTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import "BKEHomeTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

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

// ❓这个里面可以包含delegate的Click；捋一捋怎么用
- (void)purchaseButtonClick {
    NSLog(@"Go To Purchase Page!");
}

- (void) setMovieData:(BKEMovieModel *)movieData {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:movieData.imageURL]];
    [self.titleLabel setText:movieData.name];
    [self.ratingLabel setText:movieData.rating];
    [self.directorLabel setText:movieData.director];
    [self.actorLabel setText:movieData.starring];
}

#pragma mark - Private Method

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.ratingLabel];
    [self addSubview:self.directorLabel];
    [self addSubview:self.actorLabel];
    [self addSubview:self.purchaseButton];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(130);
        make.width.mas_equalTo(self.leftImageView.mas_height).dividedBy(1.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.leftImageView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self).dividedBy(2.5);
    }];
    
    [self.ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(self.titleLabel).multipliedBy(0.8);
        make.width.mas_equalTo(self.titleLabel).multipliedBy(0.8);
    }];
    
    [self.directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.ratingLabel.mas_bottom);
        make.height.mas_equalTo(self.titleLabel).multipliedBy(0.8);
        make.width.mas_equalTo(self.titleLabel).multipliedBy(0.8);
    }];
    
    [self.actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.directorLabel.mas_bottom);
        make.height.mas_equalTo(self).multipliedBy(0.3);
        make.width.mas_equalTo(self.titleLabel).multipliedBy(0.8);
    }];
    
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self).multipliedBy(0.2);
        make.width.mas_equalTo(self).multipliedBy(0.15);
    }];
    
    return ;
}

#pragma mark - Getter

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor orangeColor];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)ratingLabel {
    if (!_ratingLabel) {
        _ratingLabel = [[UILabel alloc] init];
        _ratingLabel.backgroundColor = [UIColor grayColor];
        _ratingLabel.font = [UIFont systemFontOfSize:12];
        _ratingLabel.textColor = [UIColor redColor];
    }
    return _ratingLabel;
}

- (UILabel *)directorLabel {
    if (!_directorLabel) {
        _directorLabel = [[UILabel alloc] init];
        _directorLabel.backgroundColor = [UIColor lightGrayColor];
        _directorLabel.font = [UIFont systemFontOfSize:12];
        _directorLabel.textColor = [UIColor redColor];
    }
    return _directorLabel;
}

- (UILabel *)actorLabel {
    if (!_actorLabel) {
        _actorLabel = [[UILabel alloc] init];
        _actorLabel.backgroundColor = [UIColor yellowColor];
        _actorLabel.font = [UIFont systemFontOfSize:12];
        _actorLabel.textColor = [UIColor redColor];
    }
    return _actorLabel;
}

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
