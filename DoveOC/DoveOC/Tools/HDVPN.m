//
//  HDVPN.m
//  DoveOC
//
//  Created by DOVE on 2022/10/8.
//

#import "HDVPN.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

NSString *const kVPNStatusChangedNotification = @"kVPNStatusChangedNotification";

@interface HDVPN ()

@end

@implementation HDVPN
{
    BOOL _vpnFlag;
}

+ (BOOL)isVPNOn {
    return [[self alloc] isVPNOn];
}

- (BOOL)isVPNOn
{
    BOOL flag = NO;
    // [UIDevice currentDevice] systemVersion 9.0 之后使用
    NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *keys = [dict[@"__SCOPED__"] allKeys];
    for (NSString *key in keys) {
        if ([key rangeOfString:@"tap"].location != NSNotFound ||
            [key rangeOfString:@"tun"].location != NSNotFound ||
            [key rangeOfString:@"ipsec"].location != NSNotFound ||
            [key rangeOfString:@"ppp"].location != NSNotFound){
            flag = YES;
            break;
        }
    }
    
    if (_vpnFlag != flag){
        // reset flag
        _vpnFlag = flag;
        __weak __typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [[NSNotificationCenter defaultCenter] postNotificationName:kVPNStatusChangedNotification
                                                                object:strongSelf];
        });
    }
    return flag;
}

@end
