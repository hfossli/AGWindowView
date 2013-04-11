//
//  AGAppDelegate.h
//  AGWindowViewDemo
//
//  Created by Håvard Fossli on 11.04.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
