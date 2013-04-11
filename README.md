AGWindowView
============

AGWindowView is a UIView which can be added directly to UIWindow. It handles rotation and frame changes of statusbar for you.

You can have as many AGWindowView's you want. We're using it in Agens for custom alerts, but it can be used for anything. 

Usage
------

It can be used in a number of different situations.

- display something fullscreen
- your app is in portrait and you want to play video in fullscreen landscape
- show custom modals in specific orientations
- display custom alerts on top of UI

Code examples
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

Debug - Notes
-----

Please note that we are using `UIInterfaceOrientationMask` and not `UIInterfaceOrientation` for the property `supportedInterfaceOrientations`.

I highly encourage either to set `supportedInterfaceOrientations = UIInterfaceOrientationMaskAll` or only use one of the orientations e.g. `supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait`. Mixing will be supported, but currently undergoes unexpected results.

Cocoa pods
-------
    
It is added to the public cocoa pods spec repository under the name `AGWindowView`.
    
[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
