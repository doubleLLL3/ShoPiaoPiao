//
//  BKEDetailTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEDetailTableViewCell.h"
#import <Masonry/Masonry.h>

#define kMargin 10
#define kLargeMargin 20
#define kTabsHeight 30
#define kScrollViewHeight 340
#define kBoderWidth 0.5
#define kCornerRadius 5
#define kFontOfTabSize 16
#define kFontOfTextSize 14

#define kScreenWidth UIScreen.mainScreen.bounds.size.width
#define kSummaryTabText @"电影简介"
#define kActorsInfoTabText @"演员信息"
#define kMoreTabText @"更多信息"
#define kActorInfoFormat \
@"%@\n"\
"%@\n"\
"[简介] %@\n"\
"[链接] %@\n\n"
#define kKeyActorName @"name"
#define kKeyActorTitle @"title"
#define kKeyActorAbstract @"abstract"
#define kKeyActorURL @"sharing_url"
#define kMoreText @"赶紧购票吧！"
#define kShadowOffset CGSizeMake(0, 0)
#define kShadowOpacity 0.8

#define kShopeeColor [UIColor colorWithRed:238/255.0f green:77/255.0f blue:61/255.0f alpha:1.0f]

@interface BKEDetailTableViewCell () <UIScrollViewDelegate>

@property(nonatomic, strong) UIView *tabsView;
@property(nonatomic, strong) UILabel *summaryTabLabel;
@property(nonatomic, strong) UILabel *actorsInfoTabLabel;
@property(nonatomic, strong) UILabel *moreTabLabel;

@property(nonatomic, strong) UIScrollView *detailScrollView;
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
        NSString *actorInfo = [NSString stringWithFormat:kActorInfoFormat,
                               actorDic[kKeyActorName],
                               actorDic[kKeyActorTitle],
                               actorDic[kKeyActorAbstract],
                               actorDic[kKeyActorURL]
                               ];
        [actorsInfo appendString:actorInfo];
    }

    [self.actorsInfoTextLabel setText:actorsInfo];
    
    [self.moreTextLabel setText:kMoreText];
}

#pragma mark - Other Delegate
// 滑动时更改Tab状态
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
// 点击Tab标签时，滑动到对应内容
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

    // 两个主View：TabsView + ScrollView
    [self.contentView addSubview:self.tabsView];
    [self.contentView addSubview:self.detailScrollView];
    // ⬆️如果添加到self里而不是contentView
    //      使用self.contentView.userInteractionEnabled = NO 禁止contentView里的交互，否则会覆盖子View的交互；
    //      或者提前加载contentView

    // 1⃣️TabsView里有三个TabLabel
    [self.tabsView addSubview:self.summaryTabLabel];
    [self.tabsView addSubview:self.actorsInfoTabLabel];
    [self.tabsView addSubview:self.moreTabLabel];
    
    // 2⃣️ScrollView里有三个TextView
    [self.detailScrollView addSubview:self.summaryTextView];
    [self.detailScrollView addSubview:self.actorsInfoTextView];
    [self.detailScrollView addSubview:self.moreTextView];
    // 每个TextView里一个TextLabel
    [self.summaryTextView addSubview:self.summaryTextLabel];
    [self.actorsInfoTextView addSubview:self.actorsInfoTextLabel];
    [self.moreTextView addSubview:self.moreTextLabel];
    
    // 1⃣️Tabs栏
    [self.tabsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(kMargin);
        make.right.mas_equalTo(self.contentView).offset(-kMargin);
        make.top.mas_equalTo(self.contentView).offset(kMargin);
        make.height.mas_equalTo(kTabsHeight);
    }];
    
    [self.summaryTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.mas_equalTo(self.tabsView);
        make.width.mas_equalTo(self.actorsInfoTabLabel);
    }];
    
    [self.actorsInfoTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(self.tabsView);
        make.left.mas_equalTo(self.summaryTabLabel.mas_right);
        make.width.mas_equalTo(self.moreTabLabel);
    }];
    
    [self.moreTabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.height.mas_equalTo(self.tabsView);
        make.left.mas_equalTo(self.actorsInfoTabLabel.mas_right);
    }];
    
    // 2⃣️滑动栏——电影简介、演员信息、更多信息
    [self.detailScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.tabsView.mas_bottom);
    }];
    
    // ❗️scrollView里的子View要注意三点
    [self.summaryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.detailScrollView);
        make.height.mas_equalTo(kScrollViewHeight);  // 1⃣️设置height撑开
        make.width.mas_equalTo(kScreenWidth);        // 2⃣️设置width撑开
    }];

    [self.actorsInfoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.detailScrollView);
        make.left.mas_equalTo(self.summaryTextView.mas_right);
        make.width.mas_equalTo(kScreenWidth);        // 设置width撑开
    }];

    [self.moreTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.detailScrollView);
        make.left.mas_equalTo(self.actorsInfoTextView.mas_right);
        make.width.mas_equalTo(kScreenWidth);        // 设置width撑开
        make.right.mas_equalTo(self.detailScrollView);
        // 3⃣️最后滑动边界right需要和父视图绑定；以一个整体来考虑
    }];
    
    // 每个TextView包含一个UILabel，显示文字
    [self.summaryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.summaryTextView).offset(kLargeMargin);  // 设置边距
        make.right.mas_equalTo(self.summaryTextView).offset(-kLargeMargin);
        make.bottom.mas_lessThanOrEqualTo(self.summaryTextView).offset(-kLargeMargin);
        // ❗️bottom约束不设死，让文字居上对齐
    }];
    [self.actorsInfoTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.actorsInfoTextView).offset(kLargeMargin);
        make.right.mas_equalTo(self.actorsInfoTextView).offset(-kLargeMargin);
        make.bottom.mas_lessThanOrEqualTo(self.actorsInfoTextView).offset(-kLargeMargin);
    }];
    [self.moreTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.moreTextView).offset(kLargeMargin);
        make.right.mas_equalTo(self.moreTextView).offset(-kLargeMargin);
        make.bottom.mas_lessThanOrEqualTo(self.moreTextView).offset(-kLargeMargin);
    }];
    // 思考：当文字超出UILabel的高度时，应该再用一个ScrollView承载UILabel，从而出现垂直的滑动条
    
    return ;
}

#pragma mark - Getter

- (UIView *)tabsView {
    if (!_tabsView) {
        _tabsView = [[UIView alloc] init];
        // 设置阴影
        _tabsView.layer.shadowColor = [UIColor grayColor].CGColor;
        _tabsView.layer.shadowOffset = kShadowOffset;    // 阴影偏移，默认(0, -3)；和shadowRadius配合使用，默认3
        _tabsView.layer.shadowOpacity = kShadowOpacity;  // 阴影透明度，默认0
        // 设置边框和圆角
        _tabsView.layer.borderColor = [UIColor grayColor].CGColor;
        _tabsView.layer.borderWidth = kBoderWidth;
        _tabsView.layer.cornerRadius = kCornerRadius;
        _tabsView.layer.masksToBounds = YES;
    }
    return _tabsView;
}

- (UILabel *)summaryTabLabel {
    if (!_summaryTabLabel) {
        _summaryTabLabel = [[UILabel alloc] init];
        // 设置文本
        _summaryTabLabel.font = [UIFont systemFontOfSize:kFontOfTabSize];
        _summaryTabLabel.textAlignment = NSTextAlignmentCenter;
        _summaryTabLabel.textColor = kShopeeColor;
        [_summaryTabLabel setText:kSummaryTabText];
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
        // 设置文本
        _actorsInfoTabLabel.font = [UIFont systemFontOfSize:kFontOfTabSize];
        _actorsInfoTabLabel.textAlignment = NSTextAlignmentCenter;
        _actorsInfoTabLabel.textColor = kShopeeColor;
        [_actorsInfoTabLabel setText:kActorsInfoTabText];
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
        // 设置文本
        _moreTabLabel.font = [UIFont systemFontOfSize:kFontOfTabSize];
        _moreTabLabel.textAlignment = NSTextAlignmentCenter;
        _moreTabLabel.textColor = kShopeeColor;
        [_moreTabLabel setText:kMoreTabText];
        // 设置手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreTabTapAction)];
        [_moreTabLabel addGestureRecognizer:tapGesture];
        _moreTabLabel.userInteractionEnabled = YES;
        [_moreTabLabel setEnabled:NO];
    }
    return _moreTabLabel;
}

- (UIScrollView *)detailScrollView {
    if (!_detailScrollView) {
        _detailScrollView = [[UIScrollView alloc] init];
        // 设置阴影
        _detailScrollView.layer.shadowColor = [UIColor grayColor].CGColor;
        _detailScrollView.layer.shadowOffset = kShadowOffset;
        _detailScrollView.layer.shadowOpacity = kShadowOpacity;
        
        _detailScrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
        _detailScrollView.pagingEnabled = YES;
        _detailScrollView.bounces = NO;  // 超出contentSize不回弹
        _detailScrollView.delegate = self;
    }
    return _detailScrollView;
}

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
        _summaryTextLabel.font = [UIFont systemFontOfSize:kFontOfTextSize];
        _summaryTextLabel.numberOfLines = 0;
    }
    return _summaryTextLabel;
}

- (UILabel *)actorsInfoTextLabel {
    if (!_actorsInfoTextLabel) {
        _actorsInfoTextLabel = [[UILabel alloc] init];
        _actorsInfoTextLabel.font = [UIFont systemFontOfSize:kFontOfTextSize];
        _actorsInfoTextLabel.numberOfLines = 0;
    }
    return _actorsInfoTextLabel;
}

- (UILabel *)moreTextLabel {
    if (!_moreTextLabel) {
        _moreTextLabel = [[UILabel alloc] init];
        _moreTextLabel.font = [UIFont systemFontOfSize:kFontOfTextSize];
        _moreTextLabel.numberOfLines = 0;
    }
    return _moreTextLabel;
}

@end
