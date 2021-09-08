//
//  BKEAppDelegate.m
//  ShoPiaoPiao
//
//  Created by liuyibo on 09/01/2021.
//  Copyright (c) 2021 liuyibo. All rights reserved.
//

#import "BKEAppDelegate.h"
#import <ShoPiaoPiao/BKEHomeViewController.h>

// 扩展（私有）
@interface BKEAppDelegate ()

@property (nonatomic, strong) BKEHomeViewController *homeViewController;

@end


@implementation BKEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = homeNavigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Getter

- (BKEHomeViewController *)homeViewController {
    if (!_homeViewController) {
        _homeViewController = [[BKEHomeViewController alloc] init];
        _homeViewController.title = @"推荐电影";
    }
    return _homeViewController;
}

@end
