AGWindowView
============

AGWindowView is a UIView which can be added directly to UIWindow. It handles rotation and frame changes of statusbar for you.


Example of usage
-------

    AGWindowView *windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    windowView.supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    [windowView addSubview:view];
    
