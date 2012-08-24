//
//  TapItAppTracker.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface TapItAppTracker : NSObject

+ (TapItAppTracker *)sharedAppTracker;

- (NSString *)deviceUDID;
- (NSString *)userAgent;
- (CLLocation *)location;
- (NSInteger)networkConnectionType;
- (NSString *)carrier;

- (void)reportApplicationOpen;

@end
