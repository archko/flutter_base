#import "FlutterBasePlugin.h"
#import <flutter_base/flutter_base-Swift.h>

@implementation FlutterBasePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBasePlugin registerWithRegistrar:registrar];
}
@end
