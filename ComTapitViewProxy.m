/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTapitViewProxy.h"
#import "TiUtils.h"

@implementation ComTapitViewProxy

-(void)showAlertAd:(id)args
{
    [[self view] performSelectorOnMainThread:@selector(showAlertAd:) withObject:args waitUntilDone:NO];
}

-(void)showInterstitialAd:(id)args
{
    [[self view] performSelectorOnMainThread:@selector(showInterstitialAds:) withObject:args waitUntilDone:NO];
}

-(void)loadBannerAd:(id)args
{
    [[self view] performSelectorOnMainThread:@selector(loadBannerAds:) withObject:args waitUntilDone:NO];
}


@end
