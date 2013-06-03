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

#import "AGWindowView.h"
#import <QuartzCore/QuartzCore.h>

static NSMutableArray *_activeWindowViews;

@interface AGWindowView ()

@end

@implementation AGWindowView

#if __has_feature(objc_arc)
# define AGWV_RETAIN(xx) do { \
    _Pragma("clang diagnostic push")\
    _Pragma("clang diagnostic ignored \"-Wunused-value\"")\
    xx;\
    _Pragma("clang diagnostic pop")\
    } while(0)
# define AGWV_RELEASE(xx) do { \
    _Pragma("clang diagnostic push")\
    _Pragma("clang diagnostic ignored \"-Wunused-value\"")\
    xx;\
    _Pragma("clang diagnostic pop")\
    } while(0)
# define AGWV_AUTORELEASE(xx) do { \
    _Pragma("clang diagnostic push")\
    _Pragma("clang diagnostic ignored \"-Wunused-value\"")\
    xx;\
    _Pragma("clang diagnostic pop")\
    } while(0)
#else
# define AGWV_RETAIN(xx)            [xx retain]
# define AGWV_RELEASE(xx)           [xx release]
# define AGWV_AUTORELEASE(xx)       [xx autorelease]
#endif

#pragma mark - Construct, destruct and setup

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _activeWindowViews = [NSMutableArray array];
    });
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setup];
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;    
}

- (id)initAndAddToWindow:(UIWindow *)window
{
    self = [self initWithFrame:CGRectZero];
    if(self)
    {
        [window addSubview:self];
    }
    return self;
}

- (id)initAndAddToKeyWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self = [self initAndAddToWindow:window];
    if(self)
    {
    }
    return self;
}

- (void)setup
{    
    _supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameOrOrientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameOrOrientationChanged:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)setSupportedInterfaceOrientations:(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    _supportedInterfaceOrientations = supportedInterfaceOrientations;
    
    if(self.window != nil)
    {
        [self rotateAccordingToStatusBarOrientationAndSupportedOrientations];
    }
}

- (void)statusBarFrameOrOrientationChanged:(NSNotification *)notification
{
    /*
     This notification is most likely triggered inside an animation block,
     therefore no animation is needed to perform this nice transition.
     */
    [self rotateAccordingToStatusBarOrientationAndSupportedOrientations];
}

- (void)rotateAccordingToStatusBarOrientationAndSupportedOrientations
{
    UIInterfaceOrientation orientation = [self desiredOrientation];
    CGFloat angle = UIInterfaceOrientationAngleOfOrientation(orientation);
    CGFloat statusBarHeight = [[self class] getStatusBarHeight];
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    CGRect frame = [[self class] rectInWindowBounds:self.window.bounds statusBarOrientation:statusBarOrientation statusBarHeight:statusBarHeight];
    
    [self setIfNotEqualTransform:transform frame:frame];
}

- (void)setIfNotEqualTransform:(CGAffineTransform)transform frame:(CGRect)frame
{
    if(!CGAffineTransformEqualToTransform(self.transform, transform))
    {
        self.transform = transform;
    }
    if(!CGRectEqualToRect(self.frame, frame))
    {
        self.frame = frame;
    }
}

+ (CGFloat)getStatusBarHeight
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        return [UIApplication sharedApplication].statusBarFrame.size.width;
    }
    else
    {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

+ (CGRect)rectInWindowBounds:(CGRect)windowBounds statusBarOrientation:(UIInterfaceOrientation)statusBarOrientation statusBarHeight:(CGFloat)statusBarHeight
{    
    CGRect frame = windowBounds;
    frame.origin.x += statusBarOrientation == UIInterfaceOrientationLandscapeLeft ? statusBarHeight : 0;
    frame.origin.y += statusBarOrientation == UIInterfaceOrientationPortrait ? statusBarHeight : 0;
    frame.size.width -= UIInterfaceOrientationIsLandscape(statusBarOrientation) ? statusBarHeight : 0;
    frame.size.height -= UIInterfaceOrientationIsPortrait(statusBarOrientation) ? statusBarHeight : 0;
    return frame;
}

- (UIInterfaceOrientation)desiredOrientation
{
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIInterfaceOrientationMask statusBarOrientationAsMask = UIInterfaceOrientationMaskFromOrientation(statusBarOrientation);
    if(self.supportedInterfaceOrientations & statusBarOrientationAsMask)
    {
        return statusBarOrientation;
    }
    else
    {
        if(self.supportedInterfaceOrientations & UIInterfaceOrientationMaskPortrait)
        {
            return UIInterfaceOrientationPortrait;
        }
        else if(self.supportedInterfaceOrientations & UIInterfaceOrientationMaskLandscapeLeft)
        {
            return UIInterfaceOrientationLandscapeLeft;
        }
        else if(self.supportedInterfaceOrientations & UIInterfaceOrientationMaskLandscapeRight)
        {
            return UIInterfaceOrientationLandscapeRight;
        }
        else
        {
            return UIInterfaceOrientationPortraitUpsideDown;
        }
    }
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
        
    if(self.window == nil)
    {
        self.onDidMoveOutOfWindow ? self.onDidMoveOutOfWindow() : nil;
        AGWV_RETAIN(self);
        AGWV_AUTORELEASE(self);
        [_activeWindowViews removeObject:self];
    }
    else
    {
        [self assertCorrectHirearchy];
        self.onDidMoveToWindow ? self.onDidMoveToWindow() : nil;
        [_activeWindowViews addObject:self];
        [self rotateAccordingToStatusBarOrientationAndSupportedOrientations];
    }
}


- (void)assertCorrectHirearchy
{
    if(self.window != nil)
    {
        if(self.superview != self.window)
        {
            [NSException raise:NSInternalInconsistencyException format:@"AGWindowView should only be added directly on UIWindow"];
        }
        if([self.window.subviews indexOfObject:self] == 0)
        {
            [NSException raise:NSInternalInconsistencyException format:@"AGWindowView is not meant to be first subview on window since UIWindow automatically rotates the first view for you."];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Presentation

- (void)addSubViewAndKeepSamePosition:(UIView *)view
{
    if(view.superview == nil)
    {
        [NSException raise:NSInternalInconsistencyException format:@"When calling %s we are expecting the view to be moved is already in a view hierarchy.", __PRETTY_FUNCTION__];
    }
    
    view.frame = [view convertRect:view.bounds toView:self];
    [self addSubview:view];
}

- (void)addSubviewAndFillBounds:(UIView *)view
{
    view.frame = [self bounds];
    [self addSubview:view];
}

- (void)addSubviewAndFillBounds:(UIView *)view withSlideUpAnimationOnDone:(void(^)(void))onDone
{
    CGRect endFrame = [self bounds];
    CGRect startFrame = endFrame;
    startFrame.origin.y += startFrame.size.height;
    
    view.frame = startFrame;
    [self addSubview:view];
    
    [UIView animateWithDuration:0.4 animations:^{
        view.frame = endFrame;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        self.opaque = YES;
    } completion:^(BOOL finished) {
        if(onDone)
        {
            onDone();
        }
    }];
}

- (void)fadeOutAndRemoveFromSuperview:(void(^)(void))onDone
{
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(onDone)
        {
            onDone();
        }
    }];
}

- (void)slideDownSubviewsAndRemoveFromSuperview:(void(^)(void))onDone
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    self.opaque = YES;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        for(UIView *subview in [self subviews])
        {
            CGRect frame = subview.frame;
            frame.origin.y += self.bounds.size.height;
            subview.frame = frame;
        }
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        self.opaque = NO;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(onDone)
        {
            onDone();
        }
    }];
}

- (void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}

- (BOOL)isInFront
{
    NSArray *subviewsOnSuperview = [self.superview subviews];
    NSUInteger index = [subviewsOnSuperview indexOfObject:self];
    return index == subviewsOnSuperview.count - 1;
}

#pragma mark - Convinience methods

+ (NSArray *)allActiveWindowViews
{
    return _activeWindowViews;
}

+ (AGWindowView *)firstActiveWindowViewPassingTest:(BOOL (^)(AGWindowView *windowView, BOOL *stop))test
{
    __block AGWindowView *hit = nil;
    [_activeWindowViews enumerateObjectsUsingBlock:^(AGWindowView *windowView, NSUInteger idx, BOOL *stop) {
        if(test(windowView, stop))
        {
            hit = windowView;
        }
    }];
    return hit;
}

+ (AGWindowView *)activeWindowViewForController:(UIViewController *)controller
{
    return [self firstActiveWindowViewPassingTest:^BOOL(AGWindowView *windowView, BOOL *stop) {
        if(windowView.controller == controller)
        {
            return YES;
        }
        return [[controller view] isDescendantOfView:windowView];
    }];
}

+ (AGWindowView *)activeWindowViewContainingView:(UIView *)view
{
    return [self firstActiveWindowViewPassingTest:^BOOL(AGWindowView *windowView, BOOL *stop) {
        return [view isDescendantOfView:windowView];
    }];
}

@end


@implementation AGWindowViewHelper

BOOL UIInterfaceOrientationsIsForSameAxis(UIInterfaceOrientation o1, UIInterfaceOrientation o2)
{
    if(UIInterfaceOrientationIsLandscape(o1) && UIInterfaceOrientationIsLandscape(o2))
    {
        return YES;
    }
    else if(UIInterfaceOrientationIsPortrait(o1) && UIInterfaceOrientationIsPortrait(o2))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

CGFloat UIInterfaceOrientationAngleBetween(UIInterfaceOrientation o1, UIInterfaceOrientation o2)
{
    CGFloat angle1 = UIInterfaceOrientationAngleOfOrientation(o1);
    CGFloat angle2 = UIInterfaceOrientationAngleOfOrientation(o2);
    
    return angle1 - angle2;
}

CGFloat UIInterfaceOrientationAngleOfOrientation(UIInterfaceOrientation orientation)
{
    CGFloat angle;
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    
    return angle;
}

UIInterfaceOrientationMask UIInterfaceOrientationMaskFromOrientation(UIInterfaceOrientation orientation)
{
    return 1 << orientation;
}

@end
