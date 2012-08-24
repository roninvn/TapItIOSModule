////
////  TapItFullScreenAdViewController.m
////  TapIt-iOS-Sample
////
////  Created by Nick Penteado on 6/11/12.
////  Copyright (c) 2012 TapIt!. All rights reserved.
////
//
//#import "TapItBrowserController.h"
//#import "TapItActionSheetAdViewController.h"
//#import "TapItAdView.h"
//
//@interface TapItActionSheetAdViewController () <TapItBrowserControllerDelegate>
//
//@end
//
//@implementation TapItActionSheetAdViewController
//@synthesize adView, actionSheet, glassView, tappedURL, tapitDelegate, animated;
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex) {
//        case 0:
//            // call to action tapped
//            ; // complier dies if this isn't here for some reason...
//            BOOL shouldLoad = self.tappedURL ? YES : NO;
//            if (shouldLoad && self.tapitDelegate) {
//                if ([self.tapitDelegate respondsToSelector:@selector(tapitInterstitialAdActionDidFinish:)]) {
//                    shouldLoad = [self.tapitDelegate tapitInterstitialAdActionShouldBegin:nil willLeaveApplication:NO];
//                }
//            }
//            if (shouldLoad) {
//                [self openURLInFullscreenBrowser:self.tappedURL];
//            }
//            else {
//                [self dismissModalViewControllerAnimated:self.animated];
//            }
//            break;
//        
//        case 1:
//        default:
//            // skip tapped
//            [self dismissModalViewControllerAnimated:self.animated];
//            [self.tapitDelegate tapitInterstitialAdDidUnload:nil];
//            break;
//    }
//}
//
//#pragma mark -
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.glassView = [[[UIView alloc] initWithFrame:self.view.frame] autorelease];
//    [self.view addSubview:self.glassView];
//
//    
//    [self.adView setCenter:self.view.center];
//    [self.view addSubview:(UIView *)self.adView];
//    self.view.backgroundColor = [UIColor blackColor];
//    
//    UITapGestureRecognizer *singleFingerTap = 
//    [[UITapGestureRecognizer alloc] initWithTarget:self 
//                                            action:@selector(glassTapped:)];
//    [self.glassView addGestureRecognizer:singleFingerTap];
//    [singleFingerTap release];
//
//    self.navigationBarHidden = YES;
//    NSString *callToAction = (NSString *)[self.adView.data objectForKey:@"calltoaction"];
//    if(callToAction == nil) {
//        callToAction = @"Get More Info";
//    }
//    self.actionSheet = [[[UIActionSheet alloc] initWithTitle:nil
//                                              delegate:self 
//                                     cancelButtonTitle:nil 
//                                destructiveButtonTitle:nil 
//                                     otherButtonTitles:callToAction, @"Skip", nil] autorelease];
//    self.actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
//}
//
//- (void)glassTapped:(UITapGestureRecognizer *)recognizer
//{
//    // user can tap anywhere
//    self.tappedURL = [self.adView.data objectForKey:@"clickurl"];
//    [self.actionSheet showInView:self.view];
//}
//
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    self.glassView = nil;
//    self.actionSheet = nil;
//    // Release any retained subviews of the main view.
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    self.tappedURL = request.URL;
//    [self.actionSheet showInView:self.view];
//    return NO;
//}
//
//- (void)dealloc
//{
//    self.adView = nil;
//    self.actionSheet = nil;
//    self.glassView = nil;
//    self.tappedURL = nil;
//    self.tapitDelegate = nil;
//    [super dealloc];
//}
//@end
