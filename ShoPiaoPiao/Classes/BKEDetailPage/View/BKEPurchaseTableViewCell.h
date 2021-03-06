//
//  BKEPurchaseTableViewCell.h
//  ShoPiaoPiao
//
//  Created by εδΈε on 2021/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BKEPurchaseTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickPuchaseButton:(UIButton *)purchaseButton;

@end

@interface BKEPurchaseTableViewCell : UITableViewCell

@property(nonatomic, weak) id<BKEPurchaseTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
