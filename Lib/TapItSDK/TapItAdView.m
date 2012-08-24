//
//  TapItAdView.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 4/11/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import "TapItAdView.h"
#import "TapItPrivateConstants.h"

@implementation TapItAdView

@synthesize tapitRequest, tapitDelegate, isLoaded, wasAdActionShouldBeginMessageFired, data;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setScrollable:NO];
        self.delegate = self; // UIWebViewDelegate
        self.isLoaded = NO;
    }
    return self;
}

- (void)setScrollable:(BOOL)scrollable {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 50000 // iOS 5.0+
    if ([self respondsToSelector:@selector(scrollView)]) 
    {
        UIScrollView *scrollView = self.scrollView;
        scrollView.scrollEnabled = scrollable;
        scrollView.bounces = scrollable;
    } 
    else 
#endif
    {
        UIScrollView *scrollView = nil;
        for (UIView *v in self.subviews)
        {
            if ([v isKindOfClass:[UIScrollView class]])
            {
                scrollView = (UIScrollView *)v;
                break;
            }
        }
        scrollView.scrollEnabled = scrollable;
        scrollView.bounces = scrollable;
    }
}

- (void)loadData:(NSDictionary *)adData {
    self.data = adData;
    NSString *adWidth = [self.data objectForKey:@"adWidth"];

    NSString *width = [NSString stringWithFormat:@"width:%@px; margin:0 auto; text-align:center", adWidth];
    NSString *adHtml = [self.data objectForKey:@"html"];
    NSString *htmlData = [NSString stringWithFormat:@"<html><head><style type=\"text/css\">body {margin:0; padding:0;}</style></head><body><div style=\"%@\">%@</div></body></html>", width, adHtml];
    [super loadHTMLString:htmlData baseURL:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    NSLog(@"webViewDidStartLoad: %@", webView);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.isLoaded = YES;
    [self.tapitDelegate didLoadAdView:self];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // Ignore NSURLErrorDomain error -999.
    if (error.code == NSURLErrorCancelled) {
        return;   
    }
    
    // Ignore "Fame Load Interrupted" errors. Seen after app store links.
    if (error.code == 102 && [error.domain isEqual:@"WebKitErrorDomain"]) {
        return; 
    }

    [self.tapitDelegate adView:self didFailToReceiveAdWithError:error];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSLog(@"shouldStartLoadWithRequest: %@", request.URL.absoluteURL);
    if (!self.isLoaded) {
        // first time loading, let the ad load
        return YES;
    }
    else {
        if (!([request.URL.absoluteString hasPrefix:@"http://"] || [request.URL.absoluteString hasPrefix:@"https://"])) {
            if ([[UIApplication sharedApplication] canOpenURL:request.URL])
            {
                [self.tapitDelegate adActionShouldBegin:request.URL willLeaveApplication:YES];
                [[UIApplication sharedApplication] openURL:request.URL];
                return NO;
            }
            else {
                NSLog(@"OS says it can't handle request scheme: %@", request.URL);
            }
        }
        
        BOOL shouldLeaveApp = NO; //TODO: figure how to answer this correctly, while taking into account redirects...
        //TODO figure out how to stop this from getting fired for each redirect!!!
        BOOL shouldLoad = [self.tapitDelegate adActionShouldBegin:request.URL willLeaveApplication:shouldLeaveApp];
        if(!shouldLoad) {
//            NSLog(@"Canceling");
        }
        return shouldLoad;
    }
}

- (void)dealloc {
    [tapitRequest release], tapitRequest = nil;
    
    [super dealloc];
}

@end
