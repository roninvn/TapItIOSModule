//
//  TapItBrowserController.m
//  TapIt-iOS-Sample
//
//  Created by Nick Penteado on 7/26/12.
//  Copyright (c) 2012 TapIt!. All rights reserved.
//

#import "TapItBrowserController.h"

@implementation TapItBrowserController {
	UIWebView *_webView;
	UIBarButtonItem *_backButton;
	UIBarButtonItem *_forwardButton;
	UIBarButtonItem *_refreshButton;
	UIBarButtonItem *_safariButton;
	UIBarButtonItem *_doneButton;
	UIActivityIndicatorView *_spinner;
	UIBarButtonItem *_spinnerItem;
	UIActionSheet *_actionSheet;
    
    UIViewController *presentingController;
    BOOL _isShowing;
    NSURL *url;
    BOOL prevStatusBarHiddenState;
}

@synthesize delegate, url;

static NSArray *BROWSER_SCHEMES, *SPECIAL_HOSTS;
+ (void)initialize 
{
	// Schemes that should be handled by the in-app browser.
	BROWSER_SCHEMES = [[NSArray arrayWithObjects:
						@"http",
						@"https",
						nil] retain];
	
	// Hosts that should be handled by the OS.
	SPECIAL_HOSTS = [[NSArray arrayWithObjects:
					  @"phobos.apple.com",
					  @"maps.google.com",
                      @"itunes.apple.com",
					  nil] retain];
}

- (id)init {
	if (self = [super init])
	{
        _isShowing = NO;
        [self buildUI];
	}
	return self;
}


- (void)loadUrl:(NSURL *)theUrl {
    // test urls...
//    theUrl = [NSURL URLWithString:@"http://www.tapit.com/"]; 
//    theUrl = [NSURL URLWithString:@"http://itunes.apple.com/us/app/tiny-village/id453126021?mt=8#"];
    [_webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
}

- (void)showFullscreenBrowser {
    [self showFullscreenBrowserAnimated:YES];
}

- (void)showFullscreenBrowserAnimated:(BOOL)animated {
    if (!_isShowing) {
        UIApplication *app = [UIApplication sharedApplication];
        prevStatusBarHiddenState = app.statusBarHidden;
        [app setStatusBarHidden:YES];

        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        presentingController = [window.rootViewController retain];
        [presentingController presentViewController:self animated:animated completion:nil];
        _isShowing = YES;
    }
}

- (void)closeFullscreenBrowserAnimated:(BOOL)animated {
    [self closeFullscreenBrowserAnimated:animated completion:nil];
}

- (void)closeFullscreenBrowserAnimated:(BOOL)animated completion:(void (^)(void))completion {
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:prevStatusBarHiddenState];

    [presentingController dismissViewControllerAnimated:animated completion:completion];
    [presentingController release]; presentingController = nil;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserControllerDismissed:)]) {
        [self.delegate browserControllerDismissed:self];
    }
}

- (void)buildUI {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.view.frame = screenRect;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.width, screenRect.size.height-44)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    _spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    [_spinner sizeToFit];
    _spinner.hidesWhenStopped = YES;
    
    _backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back)];
    _backButton.enabled = YES;
    _backButton.imageInsets = UIEdgeInsetsZero;
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forward)];
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    UIBarButtonItem *spacer3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _safariButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(safari)];
    UIBarButtonItem *spacer4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _spinnerItem = [[UIBarButtonItem alloc] initWithCustomView:_spinner];
    UIBarButtonItem *spacer5 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:@selector(done)];
    _doneButton.style = UIBarButtonItemStyleDone;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolbar.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:_backButton];
    [items addObject:[spacer1 autorelease]];
    [items addObject:_forwardButton];
    [items addObject:[spacer2 autorelease]];
    [items addObject:_refreshButton];
    [items addObject:[spacer3 autorelease]];
    [items addObject:_safariButton];
    [items addObject:[spacer4 autorelease]];
    [items addObject:_spinnerItem];
    [items addObject:[spacer5 autorelease]];
    [items addObject:_doneButton];
    toolbar.items = items;
    [items release];
    [self.view addSubview:toolbar];
    [toolbar release];
    
    [self.view addSubview:_webView];
}

#pragma mark -
#pragma mark Navigation actions

- (void)done 
{
    [self closeFullscreenBrowserAnimated:YES];
}

- (void)refresh 
{
	[_webView reload];
}

- (void)back 
{
	[_webView goBack];
	_backButton.enabled = _webView.canGoBack;
	_forwardButton.enabled = _webView.canGoForward;
}

- (void)forward 
{
	[_webView goForward];
	_backButton.enabled = _webView.canGoBack;
	_forwardButton.enabled = _webView.canGoForward;
}

- (void)safari
{
    _actionSheet = [[[UIActionSheet alloc] initWithTitle:nil
                                                delegate:self 
                                       cancelButtonTitle:@"Cancel" 
                                  destructiveButtonTitle:nil 
                                       otherButtonTitles:@"Open in Safari", nil] 
                    autorelease];
    [_actionSheet showFromBarButtonItem:_safariButton animated:YES];
}	

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{	
	if (buttonIndex == 0) 
	{
		// Open in Safari.
        [self closeFullscreenBrowserAnimated:NO completion:^{
            [[UIApplication sharedApplication] openURL:_webView.request.URL];
        }];
	}
    _actionSheet = nil;
}


#pragma mark -

- (BOOL)shouldLeaveAppToServeRequest:(NSURLRequest *)request {
    /*
     Should leave app if:
      - url is not http or https
      - hostname is in list of external apps
     */
    NSURL *theUrl = request.URL;
    if (![BROWSER_SCHEMES containsObject:theUrl.scheme] || [SPECIAL_HOSTS containsObject:theUrl.host]) {
        return YES;
    }
    
    return NO;
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType 
{
    url = [request.URL retain];
    BOOL shouldProceed = YES;
    BOOL shouldLeave = [self shouldLeaveAppToServeRequest:request];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserControllerShouldLoad:willLeaveApp:)]) {
        // Give the app the choice to proceed to load this url or not...
        shouldProceed = [self.delegate browserControllerShouldLoad:self willLeaveApp:shouldLeave];
    }
    
    if (shouldProceed) {
        if (shouldLeave) {
            if ([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(browserControllerLoaded:willLeaveApp:)]) {
                    [self.delegate browserControllerLoaded:self willLeaveApp:YES];
                }
                [self closeFullscreenBrowserAnimated:NO];
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                if (self.delegate && [self.delegate respondsToSelector:@selector(browserControllerFailedToLoad:withError:)]) {
                    NSString *errStr = [NSString stringWithFormat:@"Couldn't open URL: %@", request.URL.absoluteString];
                    NSDictionary *details = [NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey];
                    NSError *err = [NSError errorWithDomain:NSPOSIXErrorDomain code:500 userInfo:details];

                    [self.delegate browserControllerFailedToLoad:self withError:err];
                }
            }
            shouldProceed = NO; // url handled by system, nothing more to do here...
        }
    }
    
    return shouldProceed;
}

- (void)webViewDidStartLoad:(UIWebView *)webView 
{
	_refreshButton.enabled = YES;
	_safariButton.enabled = YES;
	[_spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView 
{
//    NSLog(@"Finished loading %@", webView.request);
	_refreshButton.enabled = YES;
	_safariButton.enabled = YES;	
	_backButton.enabled = _webView.canGoBack;
	_forwardButton.enabled = _webView.canGoForward;
	[_spinner stopAnimating];
    
    BOOL willLeaveApp = NO;
    //TODO this fires for each redirect... we only want to fire on the final page
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserControllerLoaded:willLeaveApp:)]) {
        [self.delegate browserControllerLoaded:(TapItBrowserController *)self willLeaveApp:(BOOL)willLeaveApp];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error 
{
    // Ignore NSURLErrorDomain error -999.
    if (error.code == NSURLErrorCancelled) {
        return;        
    }
    
    // Ignore "Fame Load Interrupted" errors. Seen after app store links.
    if (error.code == 102 && [error.domain isEqual:@"WebKitErrorDomain"]) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserControllerFailedToLoad:withError:)]) {
        [self.delegate browserControllerFailedToLoad:self withError:error];
    }
}

- (void)dealloc {
    [_webView release]; _webView = nil;
	[_backButton release]; _backButton = nil;
	[_forwardButton release]; _forwardButton = nil;
	[_refreshButton release]; _refreshButton = nil;
	[_safariButton release]; _safariButton = nil;
	[_doneButton release]; _doneButton = nil;
	[_spinner release]; _spinner = nil;
	[_spinnerItem release]; _spinnerItem = nil;
	[_actionSheet release]; _actionSheet = nil;
    [presentingController release]; presentingController = nil;
    [url release]; url = nil;
    
    [super dealloc];
}
@end
