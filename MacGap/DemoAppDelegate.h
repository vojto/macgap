//
//  DemoAppDelegate.h
//  MacGap
//
//  Created by Vojto Rinik on 8/3/12.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "MGMacGap.h"

@interface DemoAppDelegate : NSObject <NSApplicationDelegate>

@property (unsafe_unretained) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet WebView *webView;
@property (strong) MGMacGap *gap;

- (void)hello;

@end
