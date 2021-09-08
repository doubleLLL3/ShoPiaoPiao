//
//  BKEInfoTableViewCell.h
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/2.
//

#import <UIKit/UIKit.h>
#import "BKEMovieModel.h"
#import "BKEMovieDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BKEInfoTableViewCell : UITableViewCell

- (void) setMovieData:(BKEMovieModel *)movieData setMovieDetail:(BKEMovieDetailModel *)movieDetail;

@end

NS_ASSUME_NONNULL_END
