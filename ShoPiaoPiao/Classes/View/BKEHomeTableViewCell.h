//
//  BKEHomeTableViewCell.h
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BKEHomeTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickPuchaseButton:(UIButton *)purchaseButton;

@end

@interface BKEHomeTableViewCell : UITableViewCell

@property(nonatomic, weak, readwrite) id<BKEHomeTableViewCellDelegate> delegate;  // weak?

//- (void) layoutTableViewCell;

@end

NS_ASSUME_NONNULL_END
