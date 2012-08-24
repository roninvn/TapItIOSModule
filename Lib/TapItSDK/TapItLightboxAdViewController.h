//
//  TapItActionSheetAdViewController.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 7/2/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapItInterstitialAdViewController.h"

@interface TapItLightboxAdViewController : TapItInterstitialAdViewController {
}

@property (retain, nonatomic) UIButton *closeButton;
@property (retain, nonatomic) NSURL *tappedURL;

@end
