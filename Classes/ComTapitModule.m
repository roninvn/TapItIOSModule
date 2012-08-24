/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComTapitModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"


@implementation ComTapitModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"9e130a2b-47c5-4524-b93f-11c471a7dc59";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.tapit";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

/*-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}*/


-(id)showAlertAds:(id)args
{
    NSLog(@"a");
    
    
    
    //ENSURE_UI_THREAD_1_ARG(args);
    
    NSLog(@"b");
    
    //ENSURE_SINGLE_ARG(args,NSDictionary);
    
    NSLog(@"c");
    
    NSString *zone = @"7527";
    //[args objectForKey:@"adzone"];
    NSString *showAs = @"Alert";
    //[args objectForKey:@"showas"];
    
    NSLog(@"1");
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            //                            @"test", @"mode", // enable test mode to test alert ads in your app
                            nil];
    NSLog(@"2");
    TapItRequest *request = [TapItRequest requestWithAdZone:zone andCustomParameters:params];
    
    NSLog(@"3");
    
    TapItAlertAd *tapitAlertAd = [[TapItAlertAd alloc] initWithRequest:request];
    
    NSLog(@"4");
    
    if ([showAs isEqualToString:@"Alert"]) {
        [tapitAlertAd showAsAlert];
    }
    else if ([showAs isEqualToString:@"ActionSheet"]) {
        [tapitAlertAd showAsActionSheet];
    }
    
    NSLog(@"5");
}

-(id)showInterstitialAds:(id)args
{
    
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
    //AppDelegate *myAppDelegate = (AppDelegate *)([[UIApplication sharedApplication] delegate]);
    //[request updateLocation:myAppDelegate.locationManager.location];
    [interstitialAd loadInterstitialForRequest:request];
    //UIViewController *ct = [[UIViewController alloc]init];
    //[interstitialAd presentFromViewController:ct];
   
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
