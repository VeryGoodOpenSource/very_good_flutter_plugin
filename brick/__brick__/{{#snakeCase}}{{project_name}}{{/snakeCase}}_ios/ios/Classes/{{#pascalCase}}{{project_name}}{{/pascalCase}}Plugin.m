#import "{{#pascalCase}}{{project_name}}{{/pascalCase}}Plugin.h"

@implementation {{#pascalCase}}{{project_name}}{{/pascalCase}}Plugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"{{#snakeCase}}{{project_name}}{{/snakeCase}}_ios"
                                  binaryMessenger:registrar.messenger];
  [channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
    if ([@"getPlatformName" isEqualToString:call.method]) {
      result(@"iOS");
    } else {
      result(FlutterMethodNotImplemented);
    }
  }];
}

@end