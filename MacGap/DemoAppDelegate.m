//
//  DemoAppDelegate.m
//  MacGap
//
//  Created by Vojto Rinik on 8/3/12.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "DemoAppDelegate.h"

@implementation DemoAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    self.gap = [[MGMacGap alloc] initWithWebView:self.webView andURL:@"public/index.html"];
    [self.gap addNamespace:@"app" delegate:self];
    [self.gap load];
}

- (void)hello {
    NSLog(@"JavaScript says hello!");
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
    return NO;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)name {
	return YES;
}

@end
