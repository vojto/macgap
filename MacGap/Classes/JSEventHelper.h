//
//  Helper.h
//  MacGap
//
//  Created by Liam Kaufman Simpkins on 12-01-22.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface JSEventHelper : NSObject

+ (void) triggerEvent:(NSString *) event forWebView: (WebView *) webView;

@end
