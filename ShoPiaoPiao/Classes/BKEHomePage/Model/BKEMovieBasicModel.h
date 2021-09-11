//
//  BKEMovieBasicModel.h
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKEMovieBasicModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSNumber *rating;
@property(nonatomic, copy) NSString *director;
@property(nonatomic, copy) NSString *starring;
@property(nonatomic, copy) NSString *imageURL;
@property(nonatomic, copy) NSString *movieId;

@end

NS_ASSUME_NONNULL_END
