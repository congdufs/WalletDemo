//
//  ReactNativeBridge.m
//  WalletDemo
//
//  Created by congdufs on 2025/3/3.
//


#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ReactNativeBridgeModule, NSObject)

RCT_EXTERN_METHOD(handleEventFromRN:(NSString*)event message:(NSDictionary *)message)

@end
