//
//  AGAppDelegate.m
//  AGWindowViewDemo
//
//  Created by Håvard Fossli on 11.04.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import "AGAppDelegate.h"
#import "AGFirstViewController.h"
#import "AGSecondViewController.h"

@interface AGAppDelegate () <UITabBarControllerDelegate>

@end

@implementation AGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[AGFirstViewController alloc] initWithNibName:@"AGFirstViewController_iPhone" bundle:nil];
        viewController2 = [[AGSecondViewController alloc] initWithNibName:@"AGSecondViewController_iPhone" bundle:nil];
    } else {
        viewController1 = [[AGFirstViewController alloc] initWithNibName:@"AGFirstViewController_iPad" bundle:nil];
        viewController2 = [[AGSecondViewController alloc] initWithNibName:@"AGSecondViewController_iPad" bundle:nil];
    }
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2];
    self.tabBarController.delegate = self;
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSUInteger)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController
{
    return [self.tabBarController.selectedViewController supportedInterfaceOrientations];
}

@end
