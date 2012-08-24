//
//  TapItActionSheetAdViewController.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 7/2/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import "TapItLightboxAdViewController.h"
#import "TapItBrowserController.h"
#import "TapItAdView.h"

@interface TapItLightboxAdViewController ()

- (void)closeTapped:(id)sender;

@end



@implementation TapItLightboxAdViewController

@synthesize closeButton, tappedURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)getPathToModuleAsset:(NSString*) fileName
{
	// The module assets are copied to the application bundle into the folder pattern
	// "module/<moduleid>". One way to access these assets is to build a path from the
	// mainBundle of the application.
    
	NSString *pathComponent = [NSString stringWithFormat:@"modules/%@/%@", @"com.tapit", fileName];
	NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pathComponent];
    
	return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self.adView setCenter:self.view.center];
    [self.view addSubview:(UIView *)self.adView];
    self.view.backgroundColor = [UIColor blackColor];
    
    //UIImage *closeButtonBackground = [UIImage imageNamed:@"TapIt.bundle/interstitial_close_button.png"];
    
    UIImage *closeButtonBackground = [UIImage imageWithContentsOfFile: [self getPathToModuleAsset:@"interstitial_close_button.png"]];
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(0, 0, 44, 44);
    self.closeButton.imageView.contentMode = UIViewContentModeCenter;
    [self.closeButton setImage:closeButtonBackground forState:UIControlStateNormal];
    
    CGRect frame = self.closeButton.frame;
    self.closeButton.frame = frame;
    [self.closeButton addTarget:self action:@selector(closeTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
        
    self.navigationBarHidden = YES;
}

- (void)closeTapped:(id)sender {
    id<TapItInterstitialAdDelegate> tDel = [self.tapitDelegate retain];
    [self dismissViewControllerAnimated:self.animated completion:^{
        [tDel tapitInterstitialAdActionDidFinish:nil];
        [tDel tapitInterstitialAdDidUnload:nil];
        [tDel release];
    }];
}

- (void)viewDidUnload
{
    self.closeButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -

- (void)dealloc
{
    self.adView = nil;
    self.closeButton = nil;
    self.tappedURL = nil;
    self.tapitDelegate = nil;
    [super dealloc];
}

@end
