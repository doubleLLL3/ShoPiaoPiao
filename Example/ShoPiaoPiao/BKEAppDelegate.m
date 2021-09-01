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
    self.homeViewController = [[BKEHomeViewController alloc] init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = self.homeViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
