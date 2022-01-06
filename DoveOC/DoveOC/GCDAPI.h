//
//  GCDAPI.h
//  DoveOC
//
//  Created by DOVE on 2022/1/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDAPI : NSObject

// 返回为void 和 参数是void时，可以使用dispatch_block_t
@property (nonatomic,copy) dispatch_block_t block;

@end

NS_ASSUME_NONNULL_END
