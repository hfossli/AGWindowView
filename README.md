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
    
Enforce orientation no matter what the status bar orientation is

    AGWindowView *windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    windowView.supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
    [windowView addSubview:view];

Cocoa pods
-------
    
Pod spec is to be found ![here](https://github.com/CocoaPods/Specs/blob/master/AGWindowView/0.1.1/AGWindowView.podspec).
    
[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
