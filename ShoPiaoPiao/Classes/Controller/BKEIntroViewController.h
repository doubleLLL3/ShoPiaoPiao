//
//  BKEIntroViewController.h
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import <UIKit/UIKit.h>
#import "BKEMovieModel.h"
#import "BKEMovieDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BKEIntroViewController : UIViewController

- (void) setupMovieData:(BKEMovieModel *)movieData setupMovieDetail:(BKEMovieDetailModel *)movieDetail;

@end

NS_ASSUME_NONNULL_END
