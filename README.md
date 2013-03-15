AGWindowView
============

AGWindowView is a UIView which can be added directly to UIWindow. It handles rotation and frame changes of statusbar for you.

You can have as many AGWindowView's you want. We're using it in Agens for custom alerts, but it can be used for anything. 

Example of usage
-------

Support the current orientation the status bar might have

    AGWindowView *windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    windowView.supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    [windowView addSubview:view];
    
Slide up say a video player in landscape even though your app is in portrait

    AGWindowView *windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    windowView.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscapeLeft;
    [windowView addSubviewAndFillBounds:player.view withSlideUpAnimationOnDone:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

Note: this won't actually rotate the statusbar, just the AGWindow. 

Cocoa pods
-------
    
It is added to the public cocoa pods spec repository under the name `AGWindowView`.
    
[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
