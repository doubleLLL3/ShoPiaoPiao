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
@property(nonatomic, strong) UILabel *summaryTextLabel;
@property(nonatomic, strong) UILabel *actorsInfoTextLabel;
@property(nonatomic, strong) UILabel *moreTextLabel;

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

- (void) updateMovieDetail:(BKEMovieDetailModel *)movieDetail {
    [self.summaryTextLabel setText:movieDetail.intro];
    
    NSMutableString *actorsInfo = [NSMutableString string];
    for (NSDictionary *actorDic in movieDetail.actors) {
        NSString *actorInfo = [NSString stringWithFormat:
                               @"%@\n\n "
                               "%@\n "
                               "[简介] %@\n "
                               "[链接] %@\n-------------------------\n\n",
                               actorDic[@"name"],
                               actorDic[@"title"],
                               actorDic[@"abstract"],
                               actorDic[@"sharing_url"]
                               ];
        [actorsInfo appendString:actorInfo];
    }

    [self.actorsInfoTextLabel setText:actorsInfo];
    
    [self.moreTextLabel setText:@"赶紧购票吧！"];
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;  // 选中Cell不变色
    [self.contentView addSubview:self.summaryTabLabel];
    [self.contentView addSubview:self.actorsInfoTabLabel];
    [self.contentView addSubview:self.moreTabLabel];
    [self.contentView addSubview:self.detailScrollView];
    // ❗️如果添加到self里而不是contentView
    //      使用self.contentView.userInteractionEnabled = NO 禁止contentView里的交互，否则会覆盖子View的交互；
    //      或者提前加载contentView
    
    [self.detailScrollView addSubview:self.summaryTextView];
    [self.detailScrollView addSubview:self.actorsInfoTextView];
    [self.detailScrollView addSubview:self.moreTextView];
    
    [self.summaryTextView addSubview:self.summaryTextLabel];
    [self.actorsInfoTextView addSubview:self.actorsInfoTextLabel];
    [self.moreTextView addSubview:self.moreTextLabel];
    
    [self.summaryTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.actorsInfoTabLabel);
        make.height.mas_equalTo(20);
    }];
    
    [self.actorsInfoTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.summaryTabLabel.mas_right);
        make.width.mas_equalTo(self.moreTabLabel);
        make.height.mas_equalTo(20);
    }];
    
    [self.moreTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.actorsInfoTabLabel.mas_right);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.detailScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
//        make.top.mas_equalTo(self.summaryTabLabel.mas_bottom);
        make.top.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(380);          // ❗️设置height撑开
    }];
    
    [self.summaryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.detailScrollView);
        make.width.mas_equalTo(self.contentView);                       // ❗️设置width撑开
    }];

    [self.actorsInfoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.detailScrollView);
        make.left.mas_equalTo(self.summaryTextView.mas_right);
        make.width.mas_equalTo(self.contentView);                       // 设置width撑开
    }];

    [self.moreTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.detailScrollView);
        make.left.mas_equalTo(self.actorsInfoTextView.mas_right);
        make.width.mas_equalTo(self.contentView);                      // 设置width撑开
        make.right.mas_equalTo(self.detailScrollView);                 // ❗️最后需要和父视图连通；以一个整体来考虑
    }];
    
    // 每个View包含一个UILabel，用来显示文字
    [self.summaryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.summaryTextView).offset(10);    // 设置边距
        make.right.mas_equalTo(self.summaryTextView).offset(-10);
        // ❗️不设bottom约束，让文字居上对齐
    }];
    [self.actorsInfoTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.actorsInfoTextView).offset(10);
        make.right.mas_equalTo(self.actorsInfoTextView).offset(-10);
    }];
    [self.moreTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.moreTextView).offset(10);
        make.right.mas_equalTo(self.moreTextView).offset(-10);
    }];
    
    return ;
}

#pragma mark - Getter

- (UIScrollView *)detailScrollView {
    if (!_detailScrollView) {
        _detailScrollView = [[UIScrollView alloc] init];
        _detailScrollView.contentSize = CGSizeMake(self.contentView.bounds.size.width * 3, 380);
        _detailScrollView.pagingEnabled = YES;
        _detailScrollView.delegate = self;
    }
    return _detailScrollView;
}

- (UILabel *)summaryTabLabel {
    if (!_summaryTabLabel) {
        _summaryTabLabel = [[UILabel alloc] init];
        // 设置边框和圆角
        _summaryTabLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _summaryTabLabel.layer.borderWidth = 0.5;
        _summaryTabLabel.layer.cornerRadius = 5;
        _summaryTabLabel.layer.masksToBounds = YES;
        // 设置文本
        _summaryTabLabel.font = [UIFont systemFontOfSize:16];
        _summaryTabLabel.textAlignment = NSTextAlignmentCenter;
        _summaryTabLabel.textColor = [UIColor brownColor];
        [_summaryTabLabel setText:@"电影简介"];
        // 设置手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(summaryTabTapAction)];
        [_summaryTabLabel addGestureRecognizer:tapGesture];
        _summaryTabLabel.userInteractionEnabled = YES;
    }
    return _summaryTabLabel;
}

- (UILabel *)actorsInfoTabLabel {
    if (!_actorsInfoTabLabel) {
        _actorsInfoTabLabel = [[UILabel alloc] init];
        // 设置边框和圆角
        _actorsInfoTabLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _actorsInfoTabLabel.layer.borderWidth = 0.5;
        _actorsInfoTabLabel.layer.cornerRadius = 5;
        _actorsInfoTabLabel.layer.masksToBounds = YES;
        // 设置文本
        _actorsInfoTabLabel.font = [UIFont systemFontOfSize:16];
        _actorsInfoTabLabel.textAlignment = NSTextAlignmentCenter;
        _actorsInfoTabLabel.textColor = [UIColor orangeColor];
        [_actorsInfoTabLabel setText:@"演员信息"];
        // 设置手势
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
        // 设置边框和圆角
        _moreTabLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _moreTabLabel.layer.borderWidth = 0.5;
        _moreTabLabel.layer.cornerRadius = 5;
        _moreTabLabel.layer.masksToBounds = YES;
        // 设置文本
        _moreTabLabel.font = [UIFont systemFontOfSize:16];
        _moreTabLabel.textAlignment = NSTextAlignmentCenter;
        _moreTabLabel.textColor = [UIColor redColor];
        [_moreTabLabel setText:@"更多信息"];
        // 设置手势
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

- (UILabel *)summaryTextLabel {
    if (!_summaryTextLabel) {
        _summaryTextLabel = [[UILabel alloc] init];
        
        _summaryTextLabel.layer.borderColor = [UIColor brownColor].CGColor;
        _summaryTextLabel.layer.borderWidth = 1;
        _summaryTextLabel.layer.cornerRadius = 5;
        _summaryTextLabel.layer.masksToBounds = YES;
        
        _summaryTextLabel.font = [UIFont systemFontOfSize:15];
        _summaryTextLabel.numberOfLines = 0;
    }
    return _summaryTextLabel;
}

- (UILabel *)actorsInfoTextLabel {
    if (!_actorsInfoTextLabel) {
        _actorsInfoTextLabel = [[UILabel alloc] init];
        
        _actorsInfoTextLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        _actorsInfoTextLabel.layer.borderWidth = 1;
        _actorsInfoTextLabel.layer.cornerRadius = 5;
        _actorsInfoTextLabel.layer.masksToBounds = YES;
        
        _actorsInfoTextLabel.font = [UIFont systemFontOfSize:12];
        _actorsInfoTextLabel.numberOfLines = 0;
    }
    return _actorsInfoTextLabel;
}

- (UILabel *)moreTextLabel {
    if (!_moreTextLabel) {
        _moreTextLabel = [[UILabel alloc] init];
        
        _moreTextLabel.layer.borderColor = [UIColor redColor].CGColor;
        _moreTextLabel.layer.borderWidth = 1;
        _moreTextLabel.layer.cornerRadius = 5;
        _moreTextLabel.layer.masksToBounds = YES;
        
        _moreTextLabel.font = [UIFont systemFontOfSize:15];
        _moreTextLabel.numberOfLines = 0;
    }
    return _moreTextLabel;
}

@end
