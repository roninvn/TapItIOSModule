//
//  TapItAdView.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapItAdManagerDelegate.h"

@class TapItRequest;

@interface TapItAdView : UIWebView <UIWebViewDelegate>

@property (retain, nonatomic) TapItRequest *tapitRequest;
@property (assign, nonatomic) id<TapItAdManagerDelegate> tapitDelegate;
@property (assign, nonatomic) BOOL isLoaded;
@property (assign, nonatomic) BOOL wasAdActionShouldBeginMessageFired;
@property (retain, nonatomic) NSDictionary *data;

- (void)setScrollable:(BOOL)scrollable;
//- (void)loadHTMLString:(NSString *)string;
- (void)loadData:(NSDictionary *)data;
@end
