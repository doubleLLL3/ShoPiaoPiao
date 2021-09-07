//
//  BKEInfoTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEInfoTableViewCell.h"
#import <Masonry/Masonry.h>

@interface BKEInfoTableViewCell ()

// 电影封面、标题、评分、导演、演员表、购票按钮
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *typeLabel;
@property(nonatomic, strong) UILabel *showDateLabel;

@end

@implementation BKEInfoTableViewCell

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

#pragma mark - Private Method

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.typeLabel];
    [self addSubview:self.showDateLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self).multipliedBy(0.85);
        make.width.mas_equalTo(self.leftImageView.mas_height).dividedBy(1.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.leftImageView);
        make.height.mas_equalTo(self).multipliedBy(0.2);
        make.width.mas_equalTo(self).dividedBy(2.5);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(self.titleLabel).multipliedBy(0.8);
        make.width.mas_equalTo(self.titleLabel).multipliedBy(0.8);
    }];
    
    [self.showDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.typeLabel.mas_bottom);
        make.height.mas_equalTo(self.titleLabel).multipliedBy(0.8);
        make.width.mas_equalTo(self.titleLabel).multipliedBy(0.8);
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

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.backgroundColor = [UIColor grayColor];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textColor = [UIColor redColor];
    }
    return _typeLabel;
}

- (UILabel *)showDateLabel {
    if (!_showDateLabel) {
        _showDateLabel = [[UILabel alloc] init];
        _showDateLabel.backgroundColor = [UIColor lightGrayColor];
        _showDateLabel.font = [UIFont systemFontOfSize:12];
        _showDateLabel.textColor = [UIColor redColor];
    }
    return _showDateLabel;
}

@end
