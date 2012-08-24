/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTapitView.h"
#import "TapIt.h"
#import "TiApp.h"

//#import "Reachability.h"

//#define ZONE_ID @"3644"

@implementation ComTapitView

-(void)dealloc{
    RELEASE_TO_NIL(myView);
    RELEASE_TO_NIL(mz);
    RELEASE_TO_NIL(type);
    [super dealloc];
}


-(TapItRequest*) createAdRequest:(NSString*)zoneID{
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"test",@"mode", nil];
    
    TapItRequest *request = [TapItRequest requestWithAdZone:zoneID andCustomParameters:param];
    
    return  request;

}

-(TapItBannerAdView*) myView{
    
    return  myView;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds{
    if(nil != myView){
        [TiUtils setView:myView positionRect:bounds];
    }
}

-(void)setAdzone_:(id)zone{
    mz = [TiUtils stringValue:zone];
    //NSLog(@"zone");
    //[self myView];
}

-(void)setType_:(id)tp{
    type = [TiUtils stringValue:tp];
    //NSLog(@"type");
}

-(void)loadBannerAds:(id)args{
    
    ENSURE_UI_THREAD_1_ARG(args);
    
    if(nil == myView){
        
        myView = [[TapItBannerAdView alloc] initWithFrame:self.frame];
        myView.delegate = self;
        
        [myView startServingAdsForRequest:[self createAdRequest:mz]];
        
        [self addSubview: myView];
    }
    
    
}


-(void)showAlertAd :(id)args{
    
    ENSURE_UI_THREAD_1_ARG(args);
    
    
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    
    NSString *zone = [args objectForKey:@"adzone"];
    NSString *showAs = [args objectForKey:@"showas"];
    
    
    TapItAlertAd *tapitAlertAd = [[TapItAlertAd alloc] initWithRequest:[self createAdRequest:zone]];
    
    
    if ([showAs isEqualToString:@"Alert"]) {
        [tapitAlertAd showAsAlert];
    }
    else if ([showAs isEqualToString:@"ActionSheet"]) {
        [tapitAlertAd showAsActionSheet];
    }
    
}

-(void)showInterstitialAds:(id)args{
    
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    NSString *zone = [args objectForKey:@"adzone"];
    
    //NSLog(zone);
    
    TapItInterstitialAd *interstitialAd = [[TapItInterstitialAd alloc] init] ;
    interstitialAd.delegate = self;
    interstitialAd.animated = YES;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            //                            @"test", @"mode", // enable test mode to test banner ads in your app
                            nil];
    TapItRequest *request = [TapItRequest requestWithAdZone:zone andCustomParameters:params];
    [interstitialAd loadInterstitialForRequest:[self createAdRequest:zone]];
    
}

-(void)tapitInterstitialAdDidLoad:(TapItInterstitialAd *)interstitialAd{
    //UIViewController *ct = [[UIViewController alloc]init];
    [interstitialAd presentFromViewController:[TiApp controller]];
    //NSLog(TiApp);
    
}

-(void)tapitInterstitialAdDidUnload:(TapItInterstitialAd *)interstitialAd{
    [interstitialAd release];
}


@end
