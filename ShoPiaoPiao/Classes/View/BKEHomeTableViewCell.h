//
//  BKEHomeTableViewCell.h
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import <UIKit/UIKit.h>
#import "BKEMovieModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BKEHomeTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickPuchaseButton:(UIButton *)purchaseButton;

@end

@interface BKEHomeTableViewCell : UITableViewCell

// 电影封面、标题、评分、导演、演员表、购票按钮
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *ratingLabel;
@property(nonatomic, strong) UILabel *directorLabel;
@property(nonatomic, strong) UILabel *actorLabel;
@property(nonatomic, strong) UIButton *purchaseButton;

@property(nonatomic, weak) id<BKEHomeTableViewCellDelegate> delegate;

- (void) setMovieData:(BKEMovieModel *)movieData;

//- (void) layoutTableViewCell;

@end

NS_ASSUME_NONNULL_END
