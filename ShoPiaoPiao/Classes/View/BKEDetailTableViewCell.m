//
//  BKEDetailTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEDetailTableViewCell.h"
#import <Masonry/Masonry.h>

@interface BKEDetailTableViewCell ()

@property(nonatomic, strong, readwrite) UIScrollView *detailView;
@property(nonatomic, strong, readwrite) UIView *summaryTextView;
@property(nonatomic, strong, readwrite) UIView *commentTextView;
@property(nonatomic, strong, readwrite) UIView *moreTextView;

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
    self.backgroundColor = [UIColor blueColor];
    
    [self addSubview:self.detailView];
  
//    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(self);
//        make.width.mas_equalTo(self.mas_width).multipliedBy(3);
//        make.height.mas_equalTo(self);
//    }];
    
    // ❓为什么不显示；改变的是contentsize，frame为0/
//    [self.summaryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.mas_equalTo(self.detailView);
//        make.width.mas_equalTo(self.mas_width);
//    }];
//
//    [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(self.detailView);
//        make.centerX.mas_equalTo(self.detailView);
//        make.width.mas_equalTo(self.mas_width);
//    }];
//
//    [self.moreTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.mas_equalTo(self.detailView);
//        make.width.mas_equalTo(self.mas_width);
//    }];
    
    self.detailView.frame = self.bounds;
    
    [self.detailView addSubview:self.summaryTextView];
//        [_detailView addSubview:self.commentTextView];
//        [_detailView addSubview:self.moreTextView];
    
    self.summaryTextView.frame = CGRectMake(0, 0, self.detailView.frame.size.width, self.detailView.frame.size.height);
//    self.commentTextView.frame = CGRectMake(self.detailView.frame.size.width, 0, self.detailView.frame.size.width, self.detailView.frame.size.height);
//    self.moreTextView.frame = CGRectMake(self.detailView.frame.size.width * 2, 0, self.detailView.frame.size.width, self.detailView.frame.size.height);
}

#pragma mark - Getter

- (UIScrollView *)detailView {
    if (!_detailView) {
        _detailView = [[UIScrollView alloc] init];
        _detailView.backgroundColor = [UIColor blackColor];
        _detailView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        
        
        
        _detailView.pagingEnabled = YES;
    }
    return _detailView;
}

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
