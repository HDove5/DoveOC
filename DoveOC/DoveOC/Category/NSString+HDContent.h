//
//  NSString+HDContent.h
//  DoveOC
//
//  Created by DOVE on 2022/10/8.
//
// 处理字符串内容

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HDContent)


/// 字符串中是否有中文
/// @param string 被判断的字符串
+ (BOOL)hasChinese:(NSString *)string;

/// 字符串中是否有中文
- (BOOL)hasChinese;

@end

NS_ASSUME_NONNULL_END
