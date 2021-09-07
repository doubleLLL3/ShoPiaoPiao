//
//  BKEMovieModel.h
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKEMovieModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSNumber *rating;
//@property(nonatomic, copy) NSString *rating;
@property(nonatomic, copy) NSString *director;
@property(nonatomic, copy) NSString *starring;
@property(nonatomic, copy) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
