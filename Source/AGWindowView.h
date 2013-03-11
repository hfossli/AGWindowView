//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @class AGWindowView
 * @description A view which is added to a UIWindow. It will automatically fill window and rotate along with statusbar rotations.
 */

@interface AGWindowView : UIView

@property (nonatomic, assign) UIInterfaceOrientationMask supportedInterfaceOrientations;

/**
 * @property UIViewController *controller. Convinience for having a strong reference to your controller.
 */
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, copy) void (^onDidMoveToWindow)(void);
@property (nonatomic, copy) void (^onDidMoveOutOfWindow)(void);

- (id)initAndAddToWindow:(UIWindow *)window;
- (id)initAndAddToKeyWindow;

- (void)addSubViewAndKeepSamePosition:(UIView *)view;
- (void)addSubviewAndFillBounds:(UIView *)view;
- (void)addSubviewAndFillBounds:(UIView *)view withSlideUpAnimationOnDone:(void(^)(void))onDone;
- (void)fadeOutAndRemoveFromSuperview:(void(^)(void))onDone;
- (void)slideDownSubviewsAndRemoveFromSuperview:(void(^)(void))onDone;

- (void)bringToFront;
- (BOOL)isInFront;

+ (NSArray *)allActiveWindowViews;
+ (AGWindowView *)firstActiveWindowViewPassingTest:(BOOL (^)(AGWindowView *windowView, BOOL *stop))test;
+ (AGWindowView *)activeWindowViewForController:(UIViewController *)controller;
+ (AGWindowView *)activeWindowViewContainingView:(UIView *)view;

@end

@interface AGWindowViewHelper : NSObject

BOOL UIInterfaceOrientationsIsForSameAxis(UIInterfaceOrientation o1, UIInterfaceOrientation o2);
CGFloat UIInterfaceOrientationAngleBetween(UIInterfaceOrientation o1, UIInterfaceOrientation o2);
CGFloat UIInterfaceOrientationAngleOfOrientation(UIInterfaceOrientation orientation);
UIInterfaceOrientationMask UIInterfaceOrientationMaskFromOrientation(UIInterfaceOrientation orientation);

@end