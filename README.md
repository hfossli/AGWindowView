AGWindowView 
============

Add as many UIView's to UIWindow as you want. Specify the orientation or just follow the status bar. Status bar height is taken into account and you don't have to worry about a thing. 

We're using it in Agens for custom alerts, but it can be used for anything. Should not be used as the first view on window.

iOS 5 ~ iOS 8 and SDK's
-----------------------
AGWindowView is compatible with modern combinations of build SDK's and iOS system versions (iOS 5 ~ iOS 8). Make sure you use the latest tag/version.


Usage
------

It can be used in a number of different situations.

- display something fullscreen
- your app is in portrait and you want to play video in fullscreen landscape
- show custom modals in specific orientations
- display custom alerts on top of UI
- should not be used as the first view on window.

Code examples
-------

Support the current orientation the status bar might have

    AGWindowView *windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskAll;
    [windowView addSubview:view];
    
Slide up say a video player in landscape even though your app is in portrait

    AGWindowView *windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskLandscapeLeft;
    [windowView addSubviewAndFillBounds:player.view withSlideUpAnimationOnDone:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

Note: this won't actually rotate the statusbar, just the AGWindow. 

Debug - Notes
-----

Please note that we are using `AGInterfaceOrientationMask` and not `UIInterfaceOrientation` for the property `supportedInterfaceOrientations`.

I highly encourage either to set `supportedInterfaceOrientations = AGInterfaceOrientationMaskAll` or only use one of the orientations e.g. `supportedInterfaceOrientations = AGInterfaceOrientationMaskPortrait`. Mixing will be supported, but currently undergoes unexpected results.

Cocoa pods
-------
    
It is added to the public cocoa pods spec repository under the name `AGWindowView`.
    
[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
