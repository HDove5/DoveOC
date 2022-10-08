//
//  NSString+HDContent.m
//  DoveOC
//
//  Created by DOVE on 2022/10/8.
//

#import "NSString+HDContent.h"

@implementation NSString (HDContent)

/*
 处理中文链接
 [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 */

+ (BOOL)hasChinese:(NSString *)string {
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) { return YES; }
    }
    return NO;
}

- (BOOL)hasChinese {
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) { return YES; }
    }
    return NO;
}

@end
