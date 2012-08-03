//
//  MGMacGap.m
//  MacGap
//
//  Created by Vojto Rinik on 8/3/12.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "MGMacGap.h"

@interface WebPreferences (WebPreferencesPrivate)
- (void)_setLocalStorageDatabasePath:(NSString *)path;
- (void) setLocalStorageEnabled: (BOOL) localStorageEnabled;
- (void) setDatabasesEnabled:(BOOL)databasesEnabled;
- (void) setDeveloperExtrasEnabled:(BOOL)developerExtrasEnabled;
- (void) setWebGLEnabled:(BOOL)webGLEnabled;
- (void) setOfflineWebApplicationCacheEnabled:(BOOL)offlineWebApplicationCacheEnabled;
@end

@implementation MGMacGap

- (id)initWithWebView:(WebView *)webView andURL:(NSString *)relativeURL {
    if ((self = [self init])) {
        self.webView = webView;
        self.url = [NSURL URLWithString:relativeURL relativeToURL:[[NSBundle mainBundle] resourceURL]];
        NSLog(@"Loading %@ into %@", [self.url absoluteString], self.webView);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(windowResized:)
                                                     name:NSWindowDidResizeNotification
                                                   object:[self.webView window]];
        
        [self setupWebView];
    }
    
    return self;
}

- (void)load {
    [self.webView setMainFrameURL:[self.url absoluteString]];
}

- (void)addNamespace:(NSString *)namespace delegate:(id)namespaceDelegate {
    [self.webViewDelegate addNamespace:namespace delegate:namespaceDelegate];
}

- (void)setupWebView {
    WebPreferences *webPrefs = [WebPreferences standardPreferences];
    
    NSString *cappBundleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    NSString *applicationSupportFile = [@"~/Library/Application Support/" stringByExpandingTildeInPath];
    NSString *savePath = [NSString pathWithComponents:[NSArray arrayWithObjects:applicationSupportFile, cappBundleName, @"LocalStorage", nil]];
    [webPrefs _setLocalStorageDatabasePath:savePath];
    [webPrefs setLocalStorageEnabled:YES];
    [webPrefs setDatabasesEnabled:YES];
    [webPrefs setDeveloperExtrasEnabled:[[NSUserDefaults standardUserDefaults] boolForKey: @"developer"]];
    [webPrefs setOfflineWebApplicationCacheEnabled:YES];
    [webPrefs setWebGLEnabled:YES];
    
    [self.webView setPreferences:webPrefs];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage
                                          sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    [self.webView setApplicationNameForUserAgent: @"MacGap"];
    
	self.webViewDelegate = [[MGWebViewDelegate alloc] init];
	[self.webView setFrameLoadDelegate:self.webViewDelegate];
	[self.webView setUIDelegate:self.webViewDelegate];
	[self.webView setResourceLoadDelegate:self.webViewDelegate];
	[self.webView setDownloadDelegate:self.webViewDelegate];
	[self.webView setPolicyDelegate:self.webViewDelegate];
    [self.webView setDrawsBackground:NO];
    [self.webView setShouldCloseWithWindow:NO];
    
    [self.webView setGroupName:@"MacGap"];
}

- (void) windowResized:(NSNotification*)notification; {
	NSWindow* window = (NSWindow*)notification.object;
	NSSize size = [window frame].size;
	
	NSLog(@"window width = %f, window height = %f", size.width, size.height);
    
    bool isFullScreen = (window.styleMask & NSFullScreenWindowMask) == NSFullScreenWindowMask;
    int titleBarHeight = isFullScreen ? 0 : [[Utils sharedInstance] titleBarHeight:window];
    
	[self.webView setFrame:NSMakeRect(0, 0, size.width, size.height - titleBarHeight)];
    [self triggerEvent:@"orientationchange"];
}

- (void) triggerEvent:(NSString*)type {
    NSString* script = [NSString stringWithFormat:@"\
                        var e = document.createEvent('Events'); \
                        e.initEvent('%@', true, false); document.dispatchEvent(e);", type];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    
}

- (id)valueForKey:(NSString *)key {
    NSLog(@"Getting value for key %@", key);
    return [super valueForKey:key];
}

@end
