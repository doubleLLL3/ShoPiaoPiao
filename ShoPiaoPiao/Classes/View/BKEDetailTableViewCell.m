//
//  BKEDetailTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import "BKEDetailTableViewCell.h"

@interface BKEDetailTableViewCell ()

@property(nonatomic, strong, readwrite) UIScrollView *detailView;
@property(nonatomic, strong, readwrite) UILabel *summaryTextView;
@property(nonatomic, strong, readwrite) UILabel *commentTextView;
@property(nonatomic, strong, readwrite) UILabel *moreTextView;

@end

@implementation BKEDetailTableViewCell

#pragma mark - Public Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];  // 需要先调用父类方法
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.detailView];
        
    }
    return self;
}

#pragma mark - Getter

- (UIScrollView *)detailView {
    if (!_detailView) {
        _detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _detailView.backgroundColor = [UIColor blackColor];
        _detailView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        
        [_detailView addSubview:self.summaryTextView];
        [_detailView addSubview:self.commentTextView];
        [_detailView addSubview:self.moreTextView];
        
        _detailView.pagingEnabled = YES;
    }
    return _detailView;
}

- (UILabel *)summaryTextView {
    if (!_summaryTextView) {
        _summaryTextView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _detailView.bounds.size.width, _detailView.bounds.size.height)];
        _summaryTextView.backgroundColor = [UIColor redColor];
    }
    return _summaryTextView;
};

- (UILabel *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[UILabel alloc] initWithFrame:CGRectMake(_detailView.bounds.size.width, 0, _detailView.bounds.size.width, _detailView.bounds.size.height)];
        _commentTextView.backgroundColor = [UIColor yellowColor];
    }
    return _commentTextView;
}

- (UILabel *)moreTextView {
    if (!_moreTextView) {
        _moreTextView = [[UILabel alloc] initWithFrame:CGRectMake(_detailView.bounds.size.width * 2, 0, _detailView.bounds.size.width, _detailView.bounds.size.height)];
        _moreTextView.backgroundColor = [UIColor grayColor];
    }
    return _moreTextView;
}

@end
