/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
//#import <CoreLocation/CoreLocation.h>
//#import "TapItAdDelegates.h"
#import "TapItBannerAdView.h"
#import "TapItInterstitialAd.h"

@interface ComTapitView : TiUIView <TapItBannerAdViewDelegate, TapItInterstitialAdDelegate> {
    
    TapItBannerAdView *myView;
    NSString *mz;
    NSString *type;

}

@end
