//
//  TapItConstants.h
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/13/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#ifndef TapIt_iOS_Sample_TapItConstants_h
#define TapIt_iOS_Sample_TapItConstants_h

#define TAPIT_VERSION @"2.0.1"

enum {
    TapItBannerAdType       = 0x01,
    TapItFullscreenAdType   = 0x02,
    TapItVideoAdType        = 0x04,
    TapItOfferWallType      = 0x08,
};
typedef NSUInteger TapItAdType;


enum {
    TapItNoneControlType        = 0x00,
    TapItLightboxControlType    = 0x01,
    TapItActionSheetControlType = 0x02,
};
typedef NSUInteger TapItInterstitialControlType;


enum {
    TapItBannerHideNone,
    TapItBannerHideLeft,
    TapItBannerHideRight,
    TapItBannerHideUp,
    TapItBannerHideDown,
};
typedef NSUInteger TapItBannerHideDirection;

#define TAPIT_PARAM_KEY_BANNER_ROTATE_INTERVAL @"RotateBannerInterval"
#define TAPIT_PARAM_KEY_BANNER_ERROR_TIMEOUT_INTERVAL @"ErrorRetryInterval"

#define TapItDefaultLocationPrecision 6

#endif
