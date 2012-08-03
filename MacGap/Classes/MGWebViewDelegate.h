#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class Sound;
@class Dock;
@class Growl;
@class Notice;
@class Path;
@class App;
@class Window;

@interface MGWebViewDelegate : NSObject {
	Sound* sound;
    Dock* dock;
    Growl* growl;
    Notice* notice;
    Path* path;
    App* app;
    Window* window;
}

@property (strong) NSMutableDictionary *namespaces;

@property (nonatomic, retain) Sound* sound;
@property (nonatomic, retain) Dock* dock;
@property (nonatomic, retain) Growl* growl;
@property (nonatomic, retain) Notice* notice;
@property (nonatomic, retain) Path* path;
@property (nonatomic, retain) App* app;
@property (nonatomic, retain) Window* window;

- (void)addNamespace:(NSString *)namespace delegate:(id)namespaceDelegate;

@end
