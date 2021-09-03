//
//  BKEInfoTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEInfoTableViewCell.h"

@interface BKEInfoTableViewCell ()

// 电影封面、标题、评分、导演、演员表、购票按钮
@property(nonatomic, strong, readwrite) UIImageView *leftImageView;
@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *typeLabel;
@property(nonatomic, strong, readwrite) UILabel *showDateLabel;

@end

@implementation BKEInfoTableViewCell

#pragma mark - Public Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.showDateLabel];
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

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 100, 10)];
        _typeLabel.backgroundColor = [UIColor grayColor];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textColor = [UIColor redColor];
    }
    return _typeLabel;
}

- (UILabel *)showDateLabel {
    if (!_showDateLabel) {
        _showDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 60, 100, 20)];
        _showDateLabel.backgroundColor = [UIColor lightGrayColor];
        _showDateLabel.font = [UIFont systemFontOfSize:12];
        _showDateLabel.textColor = [UIColor redColor];
    }
    return _showDateLabel;
}

@end
