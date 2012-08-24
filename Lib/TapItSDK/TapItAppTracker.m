//
//  TapItAppTracker.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import "TapItPrivateConstants.h"
#import "TapItAppTracker.h"
#import "OpenUDID.h"
//#import "Reachability.h"

@interface TapItAppTracker ()
    - (void)reportApplicationOpenInBackground;
@end

@implementation TapItAppTracker

+ (TapItAppTracker *)sharedAppTracker {
	static TapItAppTracker *sharedAppTracker;
	
	@synchronized(self)
	{
		if (!sharedAppTracker)
			sharedAppTracker = [[TapItAppTracker alloc] init];
		return sharedAppTracker;
	}
}

- (NSString *)deviceUDID {
    return [OpenUDID value];
}

- (NSString *)userAgent {
	static NSString *userAgent = nil;
	
    if (!userAgent) {
		if(![NSThread isMainThread]){
			dispatch_sync(dispatch_get_main_queue(), ^{
				UIWebView *webview = [[UIWebView alloc] init];
				userAgent = [[webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"] copy];
				[webview release];
			});
		}else{
			UIWebView *webview = [[UIWebView alloc] init];
			userAgent = [[webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"] copy];
			[webview release];
		}
    }
    return userAgent;
}

- (void)reportApplicationOpen {
    [self performSelectorInBackground:@selector(reportApplicationOpenInBackground) withObject:nil];
    
}

- (NSString *)carrier {
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *c = [netinfo subscriberCellularProvider];
    NSString *cName = c.carrierName;
    if (!cName) {
        cName = @"unkown";
    }
    [netinfo release];
    return cName;
}

- (CLLocation *)location {
    return nil;
}

/**
 0 - low speed network
 1 - Wifi network
 */
- (NSInteger)networkConnectionType {
    //Reachability *reachability = [Reachability reachabilityForInternetConnection];
    //return reachability.isReachableViaWiFi;
    return 1;
}

- (void)reportApplicationOpenInBackground {
    @autoreleasepool {
        NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *appInstalledLogPath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-installed.log",[[NSBundle mainBundle] bundleIdentifier]]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        BOOL isNewInstall = ![fileManager fileExistsAtPath:appInstalledLogPath];

        if (isNewInstall){
            NSString *appId = [[NSBundle mainBundle] bundleIdentifier];
            NSString *udid = [self deviceUDID];
            NSString *ua = [self userAgent];
            
            NSMutableString *reportUrlString = [NSMutableString stringWithFormat:@"%@/adconvert.php?appid=%@&udid=%@",
                                                TAPIT_REPORTING_SERVER_URL,
                                                appId,
                                                udid
                                                ];
            if (ua && [ua length] > 0) {
                [reportUrlString appendFormat:@"&ua=%@",ua];
            }
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[reportUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

            unsigned int tries = 0;
            while (tries < 5) {
                NSURLResponse *response;
                NSError *error = nil;

                [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                if ((!error) && ([(NSHTTPURLResponse *)response statusCode] == 200)) {
                    [fileManager createFileAtPath:appInstalledLogPath contents:nil attributes:nil];
                    
                    break;
                }
                
                sleep(10);
                tries++;
            }
        }
    } // end @autoreleasepool
}



@end
