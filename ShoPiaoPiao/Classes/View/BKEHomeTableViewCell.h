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
@property(nonatomic, strong, readwrite) UIImageView *leftImageView;
@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *ratingLabel;
@property(nonatomic, strong, readwrite) UILabel *directorLabel;
@property(nonatomic, strong, readwrite) UILabel *actorLabel;
@property(nonatomic, strong, readwrite) UIButton *purchaseButton;

@property(nonatomic, weak, readwrite) id<BKEHomeTableViewCellDelegate> delegate;  // weak?

- (void) setMovieData:(BKEMovieModel *)movieData;

//- (void) layoutTableViewCell;

@end

NS_ASSUME_NONNULL_END
