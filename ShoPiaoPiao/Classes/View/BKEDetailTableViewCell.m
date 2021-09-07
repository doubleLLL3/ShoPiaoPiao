//
//  BKEDetailTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEDetailTableViewCell.h"
#import <Masonry/Masonry.h>

@interface BKEDetailTableViewCell ()

@property(nonatomic, strong) UIScrollView *detailView;
@property(nonatomic, strong) UIView *scrollContainerView;
@property(nonatomic, strong) UIView *summaryTextView;
@property(nonatomic, strong) UIView *commentTextView;
@property(nonatomic, strong) UIView *moreTextView;

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

#pragma mark - Private Method

- (void)setupView {
    [self addSubview:self.detailView];
    [self.detailView addSubview:self.scrollContainerView];  // ❗️先用一个UIView包一层
    [self.scrollContainerView addSubview:self.summaryTextView];
    [self.scrollContainerView addSubview:self.commentTextView];
    [self.scrollContainerView addSubview:self.moreTextView];

    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.scrollContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.detailView);
        make.height.mas_equalTo(self);                      // 设置height撑开
    }];
    
    [self.summaryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.scrollContainerView);
        make.width.mas_equalTo(self);                       // 设置width撑开
    }];

    [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.scrollContainerView);
        make.left.mas_equalTo(self.summaryTextView.mas_right);
        make.width.mas_equalTo(self);                       // 设置width撑开
    }];

    [self.moreTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.scrollContainerView);
        make.left.mas_equalTo(self.commentTextView.mas_right);
        make.width.mas_equalTo(self);                      // 设置width撑开
        make.right.mas_equalTo(self.scrollContainerView);  // 最后需要和父视图连通；以一个整体来考虑
    }];
    return ;
}

#pragma mark - Getter

- (UIScrollView *)detailView {
    if (!_detailView) {
        _detailView = [[UIScrollView alloc] init];
        _detailView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _detailView.pagingEnabled = YES;
    }
    return _detailView;
}

- (UIView *)scrollContainerView {
    if (!_scrollContainerView) {
        _scrollContainerView = [[UIView alloc] init];
    }
    return _scrollContainerView;
};

- (UIView *)summaryTextView {
    if (!_summaryTextView) {
        _summaryTextView = [[UIView alloc] init];
        _summaryTextView.backgroundColor = [UIColor redColor];
    }
    return _summaryTextView;
};

- (UIView *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[UIView alloc] init];
        _commentTextView.backgroundColor = [UIColor yellowColor];
    }
    return _commentTextView;
}

- (UIView *)moreTextView {
    if (!_moreTextView) {
        _moreTextView = [[UIView alloc] init];
        _moreTextView.backgroundColor = [UIColor grayColor];
    }
    return _moreTextView;
}

@end
