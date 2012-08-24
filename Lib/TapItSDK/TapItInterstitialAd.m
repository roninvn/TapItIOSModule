//
//  TapItInterstitialAd.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

/**
 Responsible for loading up the appropriate type of interstitial controller...
 */

#import "TapItInterstitialAd.h"
#import "TapIt.h"
#import "TapItAdManager.h"
#import "TapItBannerAdView.h"
#import "TapItInterstitialAdViewController.h"
//#import "TapItActionSheetAdViewController.h"
#import "TapItLightboxAdViewController.h"
#import "TapItBrowserController.h"

@interface TapItInterstitialAd() <TapItAdManagerDelegate> 

@property (retain, nonatomic) TapItRequest *adRequest;
@property (retain, nonatomic) TapItAdView *adView;
@property (retain, nonatomic) TapItAdManager *adManager;
@property (retain, nonatomic) TapItBannerAdView *bannerView;
@property (retain, nonatomic) UIView *presentingView;
@property (retain, nonatomic) TapItLightboxAdViewController *adController;
@property (retain, nonatomic) TapItBrowserController *browserController;

@end

@implementation TapItInterstitialAd {
    BOOL isLoaded;
    BOOL prevStatusBarHiddenState;
}

@synthesize delegate, adRequest, adView, adManager, allowedAdTypes, bannerView, presentingView, animated, adController, browserController;
//@synthesize controlType;

- (id)init {
    self = [super init];
    if (self) {
        self.adManager = [[[TapItAdManager alloc] init] autorelease];
        self.adManager.delegate = self;
//        self.controlType = TapItLightboxControlType;
        self.allowedAdTypes = TapItFullscreenAdType|TapItOfferWallType|TapItVideoAdType;
        self.animated = YES;
        isLoaded = NO;
    }
    return self;
}

- (BOOL)loaded {
    return isLoaded;
}

- (BOOL)loadInterstitialForRequest:(TapItRequest *)request {
    self.adRequest = request;
    [self.adRequest setCustomParameter:TAPIT_AD_TYPE_INTERSTITIAL forKey:@"adtype"];
    [self.adManager fireAdRequest:self.adRequest];
    return YES;
}

- (void)presentFromViewController:(UIViewController *)controller {
    UIApplication *app = [UIApplication sharedApplication];
    prevStatusBarHiddenState = app.statusBarHidden;
    [app setStatusBarHidden:YES];

//    if (self.controlType == TapItActionSheetControlType) {
//        adController = (TapItInterstitialAdViewController *)[[TapItActionSheetAdViewController alloc] init];
//    }
//    else {
        self.adController = [[TapItLightboxAdViewController alloc] init];
//    }
    self.adController.adView = self.adView;
    self.adController.animated = self.animated;
//    adController.tapitDelegate = self.delegate;
    self.adController.tapitDelegate = self;
//    self.adView.delegate = adController; //TODO Why did I do this?
    
    [controller presentModalViewController:self.adController animated:YES];
    [self.adController release];
}

#pragma mark -
#pragma mark TapItAdManagerDelegate methods

- (void)willLoadAdWithRequest:(TapItRequest *)request {
    if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdWillLoad:)]) {
        [self.delegate tapitInterstitialAdWillLoad:self];
    }
}

- (void)didLoadAdView:(TapItAdView *)theAdView {
    self.adView = theAdView;
    isLoaded = YES;
    if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdDidLoad:)]) {
        [self.delegate tapitInterstitialAdDidLoad:self];
    }
}

- (void)adView:(TapItAdView *)adView didFailToReceiveAdWithError:(NSError*)error {
    [self tapitInterstitialAd:self didFailWithError:error];
}

- (BOOL)adActionShouldBegin:(NSURL *)actionUrl willLeaveApplication:(BOOL)willLeave {
    if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdActionShouldBegin:willLeaveApplication:)]) {
        BOOL shouldLoad = [self.delegate tapitInterstitialAdActionShouldBegin:self willLeaveApplication:willLeave];
        if (shouldLoad) {
            [self openURLInFullscreenBrowser:actionUrl];
            return NO; // pass off control to the full screen browser
        }
        return shouldLoad;
    }
    else {
        return YES;
    }
}

- (void)tapitInterstitialAdDidUnload:(TapItInterstitialAd *)interstitialAd {
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:prevStatusBarHiddenState];

    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdDidUnload:)]) {
            [self.delegate tapitInterstitialAdDidUnload:self];
        }
    }
}

- (void)adViewActionDidFinish:(TapItAdView *)adView {
    // This method should always be overridden by child class
}








- (void)tapitInterstitialAd:(TapItInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    isLoaded = NO;
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tapitInterstitialAd:didFailWithError:)]) {
            [self.delegate tapitInterstitialAd:self didFailWithError:error];
        }
    }
}

//- (void)tapitInterstitialAdWillLoad:(TapItInterstitialAd *)interstitialAd {
//    //TODO do we need this?  dev will know when an interstitial is loaded because they fired a load event!
//    if (self.delegate) {
//        if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdWillLoad:)]) {
//            [self.delegate tapitInterstitialAdWillLoad:self];
//        }
//    }
//}
//
//- (void)tapitInterstitialAdDidLoad:(TapItInterstitialAd *)interstitialAd {
//    //TODO not needed, covered by - (void)didLoadAdView:(TapItAdView *)theAdView above...
//    if (self.delegate) {
//        if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdDidLoad:)]) {
//            [self.delegate tapitInterstitialAdDidLoad:self];
//        }
//    }
//}
//
- (BOOL)tapitInterstitialAdActionShouldBegin:(TapItInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdActionShouldBegin:willLeaveApplication:)]) {
            return [self.delegate tapitInterstitialAdActionShouldBegin:self willLeaveApplication:willLeave];
        }
    }
    return YES;
}

- (void)tapitInterstitialAdActionDidFinish:(TapItInterstitialAd *)interstitialAd {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tapitInterstitialAdActionDidFinish:)]) {
            [self.delegate tapitInterstitialAdActionDidFinish:self];
        }
    }
}






#pragma mark -
#pragma mark TapItBrowserController methods

//- (void)openURLInFullscreenBrowser:(NSURL *)url {
//    BOOL shouldLoad = [self.tapitDelegate tapitInterstitialAdActionShouldBegin:nil willLeaveApplication:NO];
//    if (!shouldLoad) {
//        id<TapItInterstitialAdDelegate> tDel = [self.tapitDelegate retain];
//        [self dismissViewControllerAnimated:self.animated completion:^{
//            [tDel tapitInterstitialAdDidUnload:nil];
//            [tDel release];
//        }];
//        return;
//    }
//    
//    // Present ad browser.
//    self.browserController = [[[TapItBrowserController alloc] init] autorelease];
////    [self presentModalViewController:browserController animated:self.animated];
////    [self presentModalViewController:browserController animated:NO];
////    [browserController release];
//}

#pragma mark -
#pragma mark TapItBrowserController methods

- (void)openURLInFullscreenBrowser:(NSURL *)url {
//    NSLog(@"Banner->openURLInFullscreenBrowser: %@", url);
    self.browserController = [[[TapItBrowserController alloc] init] autorelease];
    self.browserController.delegate = self;
    [self.browserController loadUrl:url];
    [self.adController showLoading];

    self.adController.closeButton.hidden = YES;
}

- (BOOL)browserControllerShouldLoad:(TapItBrowserController *)theBrowserController willLeaveApp:(BOOL)willLeaveApp {
//    NSLog(@"************* browserControllerShouldLoad:willLeaveApp:%d, (%@)", willLeaveApp, theBrowserController.url);
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapitInterstitialAdActionShouldBegin:willLeaveApplication:)]) {
        [self.delegate tapitInterstitialAdActionShouldBegin:self willLeaveApplication:willLeaveApp];
    }
    return YES;
}

- (void)browserControllerLoaded:(TapItBrowserController *)theBrowserController willLeaveApp:(BOOL)willLeaveApp {
//    NSLog(@"************* browserControllerLoaded:willLeaveApp:");
    [self.adController dismissViewControllerAnimated:NO completion:^{
        if (!willLeaveApp) {
            [self.browserController showFullscreenBrowserAnimated:NO];
        }
    }];
    self.adController = nil;
}

- (void)browserControllerDismissed:(TapItBrowserController *)theBrowserController {
//    NSLog(@"************* browserControllerDismissed:");
    [self tapitInterstitialAdDidUnload:self];
}

- (void)browserControllerFailedToLoad:(TapItBrowserController *)theBrowserController withError:(NSError *)error {
//    NSLog(@"************* browserControllerFailedToLoad:withError: %@", error);
    [self.adController hideLoading];
}

#pragma mark -


- (void)timerElapsed {
    // This method should be overridden by child class
}

- (UIViewController *)getDelegate {
    return (UIViewController *)self.delegate;
}

- (void)dealloc {
    self.adRequest = nil;
    self.adView = nil;
    self.adManager = nil;
    self.bannerView = nil;
    self.presentingView = nil;
    
    [super dealloc];
}

@end
