//
//  BKEInfoTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEInfoTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface BKEInfoTableViewCell ()

// 电影封面、标题、评分、导演、演员表、购票按钮
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subtitleLabel;
@property(nonatomic, strong) UILabel *durationsLabel;
@property(nonatomic, strong) UILabel *akaLabel;

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

- (void) setMovieData:(BKEMovieModel *)movieData setMovieDetail:(BKEMovieDetailModel *)movieDetail {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:movieData.imageURL]];
    [self.titleLabel setText:movieData.name];
    
    [self.subtitleLabel setText:movieDetail.card_subtitle];
    NSString *durations = @"片长：";
    for (NSString *duration in movieDetail.durations) {
        NSString *durationWithSpace = [NSString stringWithFormat:@"%@ ", duration];  // 用空格隔开
        durations = [durations stringByAppendingString:durationWithSpace];
    }
    [self.durationsLabel setText:durations];
    
    NSString *akas = @"又名：";
    for (NSString *aka in movieDetail.aka) {
        NSString *akaWithSpace = [NSString stringWithFormat:@"%@ ", aka];            // 用空格隔开
        akas = [akas stringByAppendingString:akaWithSpace];
    }
    [self.akaLabel setText:akas];
}

#pragma mark - Private Method

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.durationsLabel];
    [self addSubview:self.akaLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(180);
        make.width.mas_equalTo(self.leftImageView.mas_height).dividedBy(1.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.leftImageView).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self).dividedBy(1.8);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(70);
        make.width.mas_equalTo(self.titleLabel);
    }];
    
    [self.durationsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.subtitleLabel.mas_bottom);
        make.width.mas_equalTo(self.titleLabel);
    }];
    
    [self.akaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.durationsLabel.mas_bottom);
        make.bottom.mas_equalTo(self.leftImageView);
        make.width.mas_equalTo(self.titleLabel);
    }];
    
    return ;
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
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:12];
        _subtitleLabel.textColor = [UIColor grayColor];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UILabel *)durationsLabel {
    if (!_durationsLabel) {
        _durationsLabel = [[UILabel alloc] init];
        _durationsLabel.font = [UIFont systemFontOfSize:12];
        _durationsLabel.textColor = [UIColor grayColor];
        _durationsLabel.numberOfLines = 0;
    }
    return _durationsLabel;
}

- (UILabel *)akaLabel {
    if (!_akaLabel) {
        _akaLabel = [[UILabel alloc] init];
        _akaLabel.font = [UIFont systemFontOfSize:12];
        _akaLabel.textColor = [UIColor grayColor];
        _akaLabel.numberOfLines = 0;
    }
    return _akaLabel;
}

@end
