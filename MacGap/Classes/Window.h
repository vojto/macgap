#import <WebKit/WebKit.h>

@interface Window : NSObject{
    
}

@property (nonatomic, retain) WebView *webView;

- (id) initWithWebView:(WebView *)view;
- (void) open:(NSDictionary *)properties;
- (void) move:(NSDictionary *)properties;
- (void) resize:(NSDictionary *) properties;

@end
