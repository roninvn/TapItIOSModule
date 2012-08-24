//
//  TapItAdDelegates.h
//  TapIt iOS SDK
//
//  Copyright 2012 TapIt! All rights reserved.
//
//

@class TapItBannerAdView;

@protocol TapItBannerAdViewDelegate <NSObject>
@optional

/**
 Called before a new banner advertisement is loaded.
 
 @param bannerView The banner view that is about to a new advertisement.
 */
- (void)tapitBannerAdViewWillLoadAd:(TapItBannerAdView *)bannerView;

/**
 Called when a new banner advertisement is loaded.
 
 @param bannerView The banner view that loaded a new advertisement.
 */
- (void)tapitBannerAdViewDidLoadAd:(TapItBannerAdView *)bannerView;

/**
 Called when a banner view fils to load a new advertisement.
 
 @param bannerView The banner view that failed to load an advertisement.
 @param error The error object that describes the problem.
 */
- (void)tapitBannerAdView:(TapItBannerAdView *)bannerView didFailToReceiveAdWithError:(NSError *)error;

/**
 Called before a banner view executes an action.
 
 @param bannerView The banner view that the user tapped.
 @param willLeave YES if another application will be launched to execute the action; NO if the action is going to be executed inside your appliaction.
 
 @return Your delegate returns YES if the banner action should execute; NO to prevent the banner action from executing.
 
 This method is called when the user taps the banner view. Your application controls whether the action is triggered. To allow the action to be triggered, 
 return YES. To suppress the action, return NO. Your application should almost always allow actions to be triggered; preventing actions may alter the 
 advertisements your application sees and reduce the revenue your application earns through TapIt.
 
 If the willLeave parameter is YES, then your application is moved to the background shortly after this method returns. In this situation, your method 
 implementation does not need to perform additional work. If willLeave is set to NO, then the triggered action will cover your application’s user 
 interface to show the advertising action. Although your application continues to run normally, your implementation of this method should disable 
 activities that require user interaction while the action is executing. For example, a game might pause its game play until the user finishes 
 watching the advertisement.
 */
- (BOOL)tapitBannerAdViewActionShouldBegin:(TapItBannerAdView *)bannerView willLeaveApplication:(BOOL)willLeave;

/**
 Called after a banner view finishes executing an action that covered your application's user interface.

 @param bannerView The banner view that finished executing an action.
 */
- (void)tapitBannerAdViewActionDidFinish:(TapItBannerAdView *)bannerView;

@end




@class TapItInterstitialAd;

@protocol TapItInterstitialAdDelegate <NSObject>
@required

/**
 Called when an full-screen ad fails to load a new advertisement. (required)
 
 @param interstitialAd The full-screen ad that received the error.
 @param error The error object that describes the problem.
 
 Although the error message informs your application about why the error occurred, normally your application does not need to display the error to the user.
 
 When an error occurs, your delegate should release the ad object.
 */
- (void)tapitInterstitialAd:(TapItInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;

/**
 Called after a full-screen ad disposes of its content. (required)
 
 @param interstitialAd The interstitial ad that disposed of its content.
 
 An ad object may unload its content for a number of reasons, including such cases as when an error occurs, after a user dismisses 
 an advertisement that was presented modally, or after an advertisement’s contents have been loaded for a long period of time. 
 The ad object automatically removes its contents from the screen if it was already presented to the user. 
 Your implementation of this method should release the ad object.
 */
- (void)tapitInterstitialAdDidUnload:(TapItInterstitialAd *)interstitialAd;


@optional

/**
 Called before the advertisement loads its content.
 
 @param interstitialAd The ad object that is about to load a new advertisement.
 */
- (void)tapitInterstitialAdWillLoad:(TapItInterstitialAd *)interstitialAd;

/**
 Called after the advertisement loads its content.
 
 @param interstitialAd The ad object that loaded a new advertisement.
 */
- (void)tapitInterstitialAdDidLoad:(TapItInterstitialAd *)interstitialAd;

/**
 Called before a banner view executes an action.
 
 @param interstitialAd The full-screen ad that the user tapped.
 @param willLeave YES if another application will be launched to execute the action; NO if the action is going to be executed inside your appliaction.
 
 @return Your delegate returns YES if the banner action should execute; NO to prevent the banner action from executing.
 
 When the user taps a presented advertisement, the ad’s delegate is called to inform your application that the user wants to interact with the ad. 
 To allow the action to be triggered, your method should return YES; to suppress the action, your method returns NO. Your application should almost 
 always allow actions to be triggered; preventing actions may alter the advertisements your application sees and reduce the revenue your application earns through TapIt.
 
 If the value of the willLeave parameter is YES and your delegate allows the advertisement to execute its action, then your application is moved to 
 the background shortly after the call to this method completes.
 
 If the value of the willLeave parameter is NO, the advertisement’s interactive experience will run inside your application. To accomodate the advertisement, 
 your application should disable activities that require user interaction as well as disabling any tasks or behaviors that may interfere with the advertisement. 
 For example, a game might pause its game play and turn off sound effects until the user finishes interacting with the advertisement. Further, while the 
 action is running, your application should also be prepared to respond to low-memory warnings by disposing of objects it can easily recreate after the 
 advertisement completes its action.
 */
- (BOOL)tapitInterstitialAdActionShouldBegin:(TapItInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave;

/**
 Called after a banner view finishes executing an action that covered your application's user interface.
 
 @param interstitialAd The full-screen ad that finished executing an action.
 */
- (void)tapitInterstitialAdActionDidFinish:(TapItInterstitialAd *)interstitialAd;

@end


@class TapItAlertAd;

@protocol TapItAlertAdDelegate <NSObject>
@optional

/**
 Called when an alert ad fails to load a new advertisement. (required)
 
 @param alertAd The alert ad that received the error.
 @param error The error object that describes the problem.
 
 Although the error message informs your application about why the error occurred, normally your application does not need to display the error to the user.
 
 When an error occurs, your delegate should release the ad object.
 */
- (void)tapitAlertAd:(TapItAlertAd *)alertAd didFailWithError:(NSError *)error;

/**
 Called after a alert ad is declined
 
 @param alertAd The alert ad that was declined.
 */
- (void)tapitAlertAdWasDeclined:(TapItAlertAd *)alertAd;

/**
 Called after the alert ad is displayed
 
 @param alertAd The ad object that loaded a new advertisement.
 */
- (void)tapitAlertAdDidLoad:(TapItAlertAd *)alertAd;

/**
 Called before a alert ad executes an action.
 
 @param alertAd The alert ad that the user tapped.
 @param willLeave YES if another application will be launched to execute the action; NO if the action is going to be executed inside your appliaction.
 
 @return Your delegate returns YES if the action should execute; NO to prevent the banner action from executing.
 
 When the user taps a presented advertisement, the ad’s delegate is called to inform your application that the user wants to interact with the ad. 
 To allow the action to be triggered, your method should return YES; to suppress the action, your method returns NO. Your application should almost 
 always allow actions to be triggered; preventing actions may alter the advertisements your application sees and reduce the revenue your application earns through TapIt.
 
 If the value of the willLeave parameter is YES and your delegate allows the advertisement to execute its action, then your application is moved to 
 the background shortly after the call to this method completes.
 
 If the value of the willLeave parameter is NO, the advertisement’s interactive experience will run inside your application. To accomodate the advertisement, 
 your application should disable activities that require user interaction as well as disabling any tasks or behaviors that may interfere with the advertisement. 
 For example, a game might pause its game play and turn off sound effects until the user finishes interacting with the advertisement. Further, while the 
 action is running, your application should also be prepared to respond to low-memory warnings by disposing of objects it can easily recreate after the 
 advertisement completes its action.
 */
- (BOOL)tapitAlertAdActionShouldBegin:(TapItAlertAd *)alertAd willLeaveApplication:(BOOL)willLeave;

/**
 Called after a alert ad finishes executing an action that covered your application's user interface.
 
 @param alertAd The alert ad that finished executing an action.
 */
- (void)tapitAlertAdActionDidFinish:(TapItAlertAd *)alertAd;

@end




@class TapItBrowserController;

@protocol TapItBrowserControllerDelegate <NSObject>
@required
- (void)browserControllerFailedToLoad:(TapItBrowserController *)browserController withError:(NSError *)error;
- (BOOL)browserControllerShouldLoad:(TapItBrowserController *)browserController willLeaveApp:(BOOL)willLeaveApp;
- (void)browserControllerLoaded:(TapItBrowserController *)browserController willLeaveApp:(BOOL)willLeaveApp;
- (void)browserControllerDismissed:(TapItBrowserController *)browserController;
@end