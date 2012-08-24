//
//  TapItAdManager.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/12/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapItAdView.h"
#import "tapItAdDelegates.h"
#import "TapItAdManagerDelegate.h"

@class TapItRequest;


@interface TapItAdManager : NSObject <TapItAdManagerDelegate>

@property (assign, nonatomic) id<TapItAdManagerDelegate> delegate;
@property (copy, nonatomic) NSDictionary *params;
@property (retain, nonatomic) NSURLConnection *currentConnection;
@property (retain, nonatomic) TapItRequest *currentRequest;

- (void)fireAdRequest:(TapItRequest *)request;
- (void)cancelAdRequests;

@end
