//
//  AGSecondViewController.m
//  AGWindowViewDemo
//
//  Created by Håvard Fossli on 11.04.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import "AGSecondViewController.h"
#import "AGWindowView.h"

@interface AGSecondViewController ()

@property (nonatomic, strong) IBOutlet UIView *landscapeView;

@end

@implementation AGSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)startDemo:(id)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    AGWindowView *windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskLandscapeLeft;
    [windowView addSubviewAndFillBounds:self.landscapeView withSlideUpAnimationOnDone:^{
        
    }];
}

- (IBAction)endDemo:(id)sender
{
    AGWindowView *windowView = [AGWindowView activeWindowViewContainingView:self.landscapeView];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [windowView slideDownSubviewsAndRemoveFromSuperview:^{
        
    }];
}

@end
