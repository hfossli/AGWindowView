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

#import "AGTransitionDemoController.h"
#import "AGWindowView.h"

@interface AGTransitionDemoController ()

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIView *containerView;

@end

@implementation AGTransitionDemoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Transition demo";
        self.tabBarItem.image = [UIImage imageNamed:@"Box_Closed.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startDemo:(id)sender
{
    AGWindowView *windowView =[[AGWindowView alloc] initAndAddToKeyWindow];
    [windowView addSubViewAndKeepSamePosition:self.contentView];
    
    [UIView animateWithDuration:0.8 animations:^{
        
        self.contentView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskLandscapeLeft;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.8 delay:0.4 options:0 animations:^{
                
                windowView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
                
            } completion:^(BOOL finished) {
                
                [windowView slideDownSubviewsAndRemoveFromSuperview:^{
                    self.contentView.center = CGPointMake(CGRectGetMidX(self.containerView.bounds), CGRectGetMidY(self.containerView.bounds));
                    [self.containerView addSubview:self.contentView];
                    self.contentView.alpha = 0.0;
                    [UIView animateWithDuration:0.5 delay:0.4 options:0 animations:^{
                        self.contentView.alpha = 1.0;
                    } completion:^(BOOL finished) {
                    }];
                }];
                
            }];
        }];
    }];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
