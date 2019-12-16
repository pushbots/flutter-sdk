#import "PushbotsPlugin.h"
#if __has_include(<pushbots/pushbots-Swift.h>)
#import <pushbots/pushbots-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pushbots-Swift.h"
#endif

@implementation PushbotsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPushbotsPlugin registerWithRegistrar:registrar];
}
@end
