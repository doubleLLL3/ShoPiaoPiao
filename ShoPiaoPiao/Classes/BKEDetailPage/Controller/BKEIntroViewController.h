//
//  BKEIntroViewController.h
//  ShoPiaoPiao
//
//  Created by εδΈε on 2021/9/1.
//

#import <UIKit/UIKit.h>
#import "BKEMovieBasicModel.h"
#import "BKEMovieDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BKEIntroViewController : UIViewController

- (void) receiveMovieBasic:(BKEMovieBasicModel *)movieBasic;

@end

NS_ASSUME_NONNULL_END
