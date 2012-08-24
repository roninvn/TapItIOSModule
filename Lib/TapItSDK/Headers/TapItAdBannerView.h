//
//  TapItBannerAd.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapItAdDelegate.h"
#import "TapItAdBase.h"


@interface TapItAdBannerView : TapItAdBase

@property (assign, nonatomic) id<TapItAdDelegate> delegate;
@property (assign, nonatomic) BOOL animated;

- (BOOL)startServingAdsForZone:(NSString *)zone;

@end
