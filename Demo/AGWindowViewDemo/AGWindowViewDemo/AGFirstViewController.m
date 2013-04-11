//
//  AGFirstViewController.m
//  AGWindowViewDemo
//
//  Created by Håvard Fossli on 11.04.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import "AGFirstViewController.h"
#import "AGWindowView.h"

@interface AGFirstViewController ()

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIView *containerView;

@end

@implementation AGFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"First"];
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
            
            windowView.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscapeLeft;
            
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

- (void)cleanUpDemo
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayInLandscapeLeft:(id)sender
{
    
}

@end
