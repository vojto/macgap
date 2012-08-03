//
//  MGMacGap.h
//  MacGap
//
//  Created by Vojto Rinik on 8/3/12.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "MGWebViewDelegate.h"

// This class manages a single "MacGap", a WebView that can execute
// its commands in Cocoa and the other way.
@interface MGMacGap : NSObject

@property (strong) WebView *webView;
@property (strong) NSURL *url;
@property (strong) MGWebViewDelegate *webViewDelegate;

- (id)initWithWebView:(WebView *)webView andURL:(NSString *)url;
- (void)setupWebView;

- (void)load;
- (void)addNamespace:(NSString *)namespace delegate:(id)namespaceDelegate;

@end
