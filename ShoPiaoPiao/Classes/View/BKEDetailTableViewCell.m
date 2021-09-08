//
//  BKEDetailTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEDetailTableViewCell.h"
#import <Masonry/Masonry.h>

@interface BKEDetailTableViewCell () <UIScrollViewDelegate>

@property(nonatomic, strong) UILabel *summaryTabLabel;
@property(nonatomic, strong) UILabel *actorsInfoTabLabel;
@property(nonatomic, strong) UILabel *moreTabLabel;
@property(nonatomic, strong) UIScrollView *detailScrollView;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UIView *summaryTextView;
@property(nonatomic, strong) UIView *actorsInfoTextView;
@property(nonatomic, strong) UIView *moreTextView;
@property(nonatomic, strong) UILabel *summaryText;
@property(nonatomic, strong) UILabel *actorsInfoText;
@property(nonatomic, strong) UILabel *moreText;

@end

@implementation BKEDetailTableViewCell

#pragma mark - Public Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];  // 需要先调用父类方法
    if (self) {
        [self setupView];
    }
    return self;
}

- (void) setMovieDetail:(BKEMovieDetailModel *)movieDetail {
    [self.summaryText setText:movieDetail.intro];
    
    NSString *actorsInfo = @"";
    for (NSDictionary *actorDic in movieDetail.actors) {
        NSString *actorInfo = [NSString stringWithFormat:
                               @"[%@]\n\n"
                               "%@\n"
                               "简介：%@\n"
                               "链接：%@\n-------------------------\n\n",
                               actorDic[@"name"],
                               actorDic[@"title"],
                               actorDic[@"abstract"],
                               actorDic[@"sharing_url"]
                               ];
        actorsInfo = [actorsInfo stringByAppendingString:actorInfo];
    }

    [self.actorsInfoText setText:actorsInfo];
    
    [self.moreText setText:@"赶紧购票吧！"];
}

#pragma mark - Other Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   if (scrollView.contentOffset.x >= self.detailScrollView.bounds.size.width * 1.5) {
        [self.summaryTabLabel setEnabled:NO];
        [self.actorsInfoTabLabel setEnabled:NO];
        [self.moreTabLabel setEnabled:YES];
    } else if (scrollView.contentOffset.x >= self.detailScrollView.bounds.size.width * 0.5) {
        [self.summaryTabLabel setEnabled:NO];
        [self.actorsInfoTabLabel setEnabled:YES];
        [self.moreTabLabel setEnabled:NO];
    } else {
        [self.summaryTabLabel setEnabled:YES];
        [self.actorsInfoTabLabel setEnabled:NO];
        [self.moreTabLabel setEnabled:NO];
    }
}

#pragma mark - Actions

-(void) summaryTabTapAction {
    [self.detailScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void) actorsInfoTabTapAction {
    [self.detailScrollView setContentOffset:CGPointMake(self.detailScrollView.bounds.size.width, 0) animated:YES];
}

-(void) moreTabTapAction {
    [self.detailScrollView  setContentOffset:CGPointMake(self.detailScrollView.bounds.size.width * 2, 0) animated:YES];
}

#pragma mark - Private Method

- (void)setupView {
    [self addSubview:self.summaryTabLabel];
    [self addSubview:self.actorsInfoTabLabel];
    [self addSubview:self.moreTabLabel];
    [self addSubview:self.detailScrollView];
    
    [self.detailScrollView addSubview:self.containerView];  // ❗️先用一个UIView包一层
    [self.containerView addSubview:self.summaryTextView];
    [self.containerView addSubview:self.actorsInfoTextView];
    [self.containerView addSubview:self.moreTextView];
    [self.summaryTextView addSubview:self.summaryText];
    [self.actorsInfoTextView addSubview:self.actorsInfoText];
    [self.moreTextView addSubview:self.moreText];

    [self.summaryTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.width.mas_equalTo(self).dividedBy(3);
    }];
    
    [self.actorsInfoTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self.summaryTabLabel.mas_right);
        make.width.mas_equalTo(self).dividedBy(3);
    }];
    
    [self.moreTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self.actorsInfoTabLabel.mas_right);
        make.width.mas_equalTo(self).dividedBy(3);
    }];
    
    [self.detailScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.summaryTabLabel.mas_bottom);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.detailScrollView);
        make.height.mas_equalTo(self.detailScrollView);     // 设置height撑开
    }];
    
    [self.summaryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.containerView);
        make.width.mas_equalTo(self);                       // 设置width撑开
    }];

    [self.actorsInfoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.summaryTextView.mas_right);
        make.width.mas_equalTo(self);                       // 设置width撑开
    }];

    [self.moreTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.actorsInfoTextView.mas_right);
        make.width.mas_equalTo(self);                      // 设置width撑开
        make.right.mas_equalTo(self.containerView);        // ❗️最后需要和父视图连通；以一个整体来考虑
    }];
    
    // 每个View包含一个UILabel，用来显示文字
    [self.summaryText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.summaryTextView).offset(10);  // 设置边距
        make.right.mas_equalTo(self.summaryTextView).offset(-10);
        // ❗️不设bottom约束，让文字居上对齐
    }];
    [self.actorsInfoText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.actorsInfoTextView).offset(10);
        make.right.mas_equalTo(self.actorsInfoTextView).offset(-10);
    }];
    [self.moreText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.moreTextView).offset(10);
        make.right.mas_equalTo(self.moreTextView).offset(-10);
    }];
    
    return ;
}

#pragma mark - Getter

- (UIScrollView *)detailScrollView {
    if (!_detailScrollView) {
        _detailScrollView = [[UIScrollView alloc] init];
        _detailScrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _detailScrollView.pagingEnabled = YES;
        _detailScrollView.delegate = self;
    }
    return _detailScrollView;
}

- (UILabel *)summaryTabLabel {
    if (!_summaryTabLabel) {
        _summaryTabLabel = [[UILabel alloc] init];
        _summaryTabLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _summaryTabLabel.layer.borderWidth = 0.5;
        _summaryTabLabel.font = [UIFont systemFontOfSize:18];
        _summaryTabLabel.textAlignment = NSTextAlignmentCenter;
        [_summaryTabLabel setText:@"电影简介"];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(summaryTabTapAction)];
        [_summaryTabLabel addGestureRecognizer:tapGesture];
        _summaryTabLabel.userInteractionEnabled = YES;
    }
    return _summaryTabLabel;
}

- (UILabel *)actorsInfoTabLabel {
    if (!_actorsInfoTabLabel) {
        _actorsInfoTabLabel = [[UILabel alloc] init];
        _actorsInfoTabLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _actorsInfoTabLabel.layer.borderWidth = 0.5;
        _actorsInfoTabLabel.font = [UIFont systemFontOfSize:18];
        _actorsInfoTabLabel.textAlignment = NSTextAlignmentCenter;
        [_actorsInfoTabLabel setText:@"演员信息"];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actorsInfoTabTapAction)];
        [_actorsInfoTabLabel addGestureRecognizer:tapGesture];
        _actorsInfoTabLabel.userInteractionEnabled = YES;
        [_actorsInfoTabLabel setEnabled:NO];
    }
    return _actorsInfoTabLabel;
}

- (UILabel *)moreTabLabel {
    if (!_moreTabLabel) {
        _moreTabLabel = [[UILabel alloc] init];
        _moreTabLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _moreTabLabel.layer.borderWidth = 0.5;
        _moreTabLabel.font = [UIFont systemFontOfSize:18];
        _moreTabLabel.textAlignment = NSTextAlignmentCenter;
        [_moreTabLabel setText:@"更多信息"];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreTabTapAction)];
        [_moreTabLabel addGestureRecognizer:tapGesture];
        _moreTabLabel.userInteractionEnabled = YES;
        [_moreTabLabel setEnabled:NO];
    }
    return _moreTabLabel;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
};

- (UIView *)summaryTextView {
    if (!_summaryTextView) {
        _summaryTextView = [[UIView alloc] init];
    }
    return _summaryTextView;
};

- (UIView *)actorsInfoTextView {
    if (!_actorsInfoTextView) {
        _actorsInfoTextView = [[UIView alloc] init];
    }
    return _actorsInfoTextView;
}

- (UIView *)moreTextView {
    if (!_moreTextView) {
        _moreTextView = [[UIView alloc] init];
    }
    return _moreTextView;
}

- (UILabel *)summaryText {
    if (!_summaryText) {
        _summaryText = [[UILabel alloc] init];
        _summaryText.font = [UIFont systemFontOfSize:14];
        _summaryText.numberOfLines = 0;
    }
    return _summaryText;
}

- (UILabel *)actorsInfoText {
    if (!_actorsInfoText) {
        _actorsInfoText = [[UILabel alloc] init];
        _actorsInfoText.font = [UIFont systemFontOfSize:12];
        _actorsInfoText.numberOfLines = 0;
    }
    return _actorsInfoText;
}

- (UILabel *)moreText {
    if (!_moreText) {
        _moreText = [[UILabel alloc] init];
        _moreText.font = [UIFont systemFontOfSize:14];
        _moreText.textColor = [UIColor redColor];
        _moreText.numberOfLines = 0;
    }
    return _moreText;
}

@end
