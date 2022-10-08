//
//  HDVPN.h
//  DoveOC
//
//  Created by DOVE on 2022/10/8.
//
// 判断是否开启VPN

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDVPN : NSObject

///判断是否开启VPN
+ (BOOL)isVPNOn;
///判断是否开启VPN
- (BOOL)isVPNOn;

@end

NS_ASSUME_NONNULL_END
