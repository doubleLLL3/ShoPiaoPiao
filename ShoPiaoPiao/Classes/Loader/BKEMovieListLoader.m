//
//  BKEMovieListLoader.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/6.
//

#import "BKEMovieListLoader.h"
#import <AFNetworking/AFNetworking.h>

@implementation BKEMovieListLoader

- (void)requestMovieListData {
    [[AFHTTPSessionManager manager] GET:@"http://0.0.0.0:8888/data1.json" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"1");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"0");
    }];
}

@end
