//
//  BKEInfoTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEInfoTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#define kMargin 10
#define kLargeMargin 20
#define kImageHeight 180
#define kImageWidth kImageHeight / 1.5
#define kLabelHeight 20
#define kLabelWidth 180
#define kTitleLabelHeight 30
#define kSubtitleLabelHeight 60
#define kAkaLabelHeight 30
#define kFontOfSize 12
#define kFontOfTitleLabelSize 16

#define kDurationsPrefix @"片长："
#define kAkasPrefix @"又名："

#define kShopeeColor [UIColor colorWithRed:238/255.0f green:77/255.0f blue:61/255.0f alpha:1.0f]

@interface BKEInfoTableViewCell ()

// 电影封面、标题、副标题、片长、又名
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

// 更新Cell数据
- (void) updateMovieBasic:(BKEMovieBasicModel *)movieBasic movieDetail:(BKEMovieDetailModel *)movieDetail {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:movieBasic.imageURL]];
    [self.titleLabel setText:movieBasic.name];
    
    [self.subtitleLabel setText:movieDetail.card_subtitle];
    NSString *durations = kDurationsPrefix;
    for (NSString *duration in movieDetail.durations) {
        NSString *durationWithSpace = [NSString stringWithFormat:@"%@ ", duration];  // 用空格隔开
        durations = [durations stringByAppendingString:durationWithSpace];
    }
    [self.durationsLabel setText:durations];
    
    NSString *akas = kAkasPrefix;
    for (NSString *aka in movieDetail.aka) {
        NSString *akaWithSpace = [NSString stringWithFormat:@"%@ ", aka];            // 用空格隔开
        akas = [akas stringByAppendingString:akaWithSpace];
    }
    [self.akaLabel setText:akas];
}

#pragma mark - Private Method

- (void)setupView {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;  // 选中Cell不变色
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.durationsLabel];
    [self addSubview:self.akaLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(kImageHeight);
        make.width.mas_equalTo(kImageWidth);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(kLargeMargin);
        make.top.mas_equalTo(self.leftImageView).offset(kMargin);
        make.height.mas_equalTo(kTitleLabelHeight);
        make.width.mas_equalTo(kLabelWidth);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(kSubtitleLabelHeight);
        make.width.mas_equalTo(kLabelWidth);
    }];
    
    [self.durationsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.subtitleLabel.mas_bottom);
        make.bottom.mas_equalTo(self.akaLabel.mas_top);
        make.width.mas_equalTo(kLabelWidth);
    }];
    
    [self.akaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.durationsLabel.mas_bottom);
        make.bottom.mas_equalTo(self.leftImageView);
        make.height.mas_equalTo(kAkaLabelHeight);
        make.width.mas_equalTo(kLabelWidth);
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
        _titleLabel.font = [UIFont systemFontOfSize:kFontOfTitleLabelSize];
        _titleLabel.textColor = kShopeeColor;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:kFontOfSize];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UILabel *)durationsLabel {
    if (!_durationsLabel) {
        _durationsLabel = [[UILabel alloc] init];
        _durationsLabel.font = [UIFont systemFontOfSize:kFontOfSize];
        _durationsLabel.textColor = [UIColor grayColor];
        _durationsLabel.numberOfLines = 0;
    }
    return _durationsLabel;
}

- (UILabel *)akaLabel {
    if (!_akaLabel) {
        _akaLabel = [[UILabel alloc] init];
        _akaLabel.font = [UIFont systemFontOfSize:kFontOfSize];
        _akaLabel.textColor = [UIColor grayColor];
        _akaLabel.numberOfLines = 0;
    }
    return _akaLabel;
}

@end
