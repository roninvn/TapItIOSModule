//
//  TapItInterstitialAdViewController.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 7/3/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import "TapItInterstitialAdViewController.h"
#import "TapItBrowserController.h"
#import "TapItAdView.h"

@interface TapItInterstitialAdViewController ()
@end

@implementation TapItInterstitialAdViewController {
    UIActivityIndicatorView *loadingSpinner;
}

@synthesize animated, adView, tapitDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        loadingSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [loadingSpinner sizeToFit];
        loadingSpinner.hidesWhenStopped = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)showLoading {
    loadingSpinner.center = self.view.center;
    [self.view addSubview:loadingSpinner];
    [loadingSpinner startAnimating];
}

- (void)hideLoading {
    [loadingSpinner stopAnimating];
    [loadingSpinner removeFromSuperview];
}



#pragma mark -
#pragma mark Orientation code

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self repositionToInterfaceOrientation:toInterfaceOrientation];
}

- (void)repositionToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        // swap width <--> height
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO)
    {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    
    CGFloat x = 0, y = 0;
    CGFloat w = self.adView.frame.size.width, h = self.adView.frame.size.height;
    
    x = size.width/2 - self.adView.frame.size.width/2;
    y = size.height/2 - self.adView.frame.size.height/2;
    
    self.adView.center = self.view.center;
    
    if(self.animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.adView setFrame:CGRectMake(x, y, w, h)];
        }
                         completion:^(BOOL finished){}
         ];
    }
    else {
        [self.adView setFrame:CGRectMake(x, y, w, h)];
    }
}

@end
