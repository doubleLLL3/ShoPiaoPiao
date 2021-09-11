//
//  BKEMovieDetailModel.h
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKEMovieDetailModel : NSObject

@property(nonatomic, copy) NSString *card_subtitle;
@property(nonatomic, copy) NSString *intro;
@property(nonatomic, strong) NSMutableArray *durations;
@property(nonatomic, strong) NSMutableArray *actors;
@property(nonatomic, strong) NSMutableArray *aka;
@property(nonatomic, assign) BOOL isPurchased;  // 暂时没用到

@end

NS_ASSUME_NONNULL_END
