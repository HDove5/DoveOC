//
//  GCDAPI.m
//  DoveOC
//
//  Created by DOVE on 2022/1/5.
//

#import "GCDAPI.h"

@implementation GCDAPI

/*
 问题：
 （数据竞争）多个线程更新相同的资源导致数据的不一致
 （死锁）停止等待的线程会导致多个线程相互持续等待
 使用太多线程会消耗大量内存
 
 几个概念：
 Runloop主循环/主线程
 
 定义想要执行的任务并追加到适当的Queue中
 Dispatch Queue : 执行处理的等待队列
 
 dispatch_async : block中放的是想要处理的任务，将其追加到queue中
 FIFO
 
 /// -------
 
 Serial Dispatch Queue : 等待现在执行中的处理结束
 Concurrent Dispatch Queue: 不等待吸纳在执行中的处理结束
 
 Main Dispatch Queue :(Serial)
 Global Didpatch Queue :(Concurrent)
 
 Serial Dispatch Queue:
    多个serial能并行执行，一个serial只能追加一个处理
    一旦生成serial并追加处理，系统对于一个serial就只能生成一个线程
 
 解决数据竞争的方法：使用serial
 
 serial 生成的个数应当仅限必需的数量
 
 Global  有四个优先级：Hight、Default、Low、Background
 
 获取Queue的方法
 见：- (void)getQueue
 
 
 /// 变更优先级
 
 ///
 dispatch_after
 
 ///
 Dispatch Grounp
 
 ///
 dispatch_barrier_async
 写入处理不可和其他的写入处理或者包含读取处理的其他某些处理并行执行，但是如果读取处理只是与读取处理并行执行，那么多个并行执行就不会发生问题
 
 为了高效的进行访问，读取处理追加到Concurrent中，写入处理在任意一个读取处理没有执行的状态下，追加到serial中（在写入处理没有结束之前，读取处理不可执行）
 
 使用Concurrent Dispatch Queue和dispatch_barrier_async函数可实现高效率的数据库访问和文件访问
 
 ///
 dispatch_sync 还有serial  小心死锁问题
 
 ///
 dispatch_apply
 dispatch_sync函数和Diaptch Group的关联API
 按照指定的次数将指定的Block追加到指定的Dispatch Queue中，并等待全部处理执行结束
 
 ps: 由于dispatch_apply函数和dispatch_sync函数相同，会等待处理执行结束，因此推荐dispatch_async函数中非同步的执行dispatch_apply函数
 
 ///
 dispatch_suspend  挂起指定的queue
 dispatch_resume   恢复指定的queue
 
 ///
 dispacth semaphore
 
 
 
 ///
 dispatch_once
 应用程序中只执行一次
 
 ///
 dispatch I/O
 dispatch Data
 通过dispatch I/O读写文件的时候，在读取较文件时，使用Global将较大的文件按照大小read/write
 分割读取的数据通过使用Dispatch Data可更为加单的进行结合和分割
 
 
 
 
 */



- (void)dispatch_apply
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, concurrentQueue, ^(size_t index) {
        NSLog(@"%zu", index);
    });
    
    NSLog(@"done");
}

- (void)dispatch_sync
{
    
}

- (void)dispatch_barrier_async
{
    dispatch_queue_t concurrentDispatchQueue = dispatch_queue_create("FQDN", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentDispatchQueue, ^{
        
    });
    dispatch_async(concurrentDispatchQueue, ^{
        
    });
    
    dispatch_barrier_async(concurrentDispatchQueue, ^{
        
    });
    
    dispatch_async(concurrentDispatchQueue, ^{
        
    });
}


- (void)dispatch_Grounp
{
    
    dispatch_queue_t myGlobalDispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, myGlobalDispatchQueue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, myGlobalDispatchQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_async(group, myGlobalDispatchQueue, ^{
        NSLog(@"3");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"done");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    /*
     DISPATCH_TIME_FOREVER: group没有执行完，则一直等待
     DISPATCH_TIME_NOW: 不用任何等待即可判定数据group的处理是否执行结束
     */
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull *NSEC_PER_SEC);
    long result = dispatch_group_wait(group, time);
    if (result == 0) {
        // group 全部处理结束
    } else {
        // 还在处理某个环节
    }
}

- (void)dispatch_After
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull* NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
       // do something...
    });
    
    // 在指定的时间追加到queue中 实际时间 3ull + 1/60
}


/// 变成任务优先级
- (void)changePriority
{
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("FQDN", NULL);
    dispatch_queue_t myGlobalDispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_set_target_queue(mySerialDispatchQueue, myGlobalDispatchQueue);
    
    // 第一个参数放要变更的queue，第二个参数放要使用的执行优先级相同优先级的Global
    // 第一参数别放main 和 global。这俩玩意不能变更优先级，改了也白改，效果随机
    
    // 在必须将不可并行执行的处理追加到多个Serial Dispatch Queue上时，使用dispatch_set_target_queue函数，可将目标指定为某一个serial，可防止处理并行执行
}



/// 创建任务
- (void)getQueue
{
    /// 方法一：
    //  mySerialDispatchQueue 指定为NULL
    //  myConcurrentDispatchQueue  指定为DISPATCH_QUEUE_CONCURRENT
    
     
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("FQDN", NULL);
    
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("FQDN", DISPATCH_QUEUE_CONCURRENT);
    
    // 这玩意也有内存管理
//    dispatch_release(mySerialDispatchQueue);
//    dispatch_retain(myConcurrentDispatchQueue);

    
    
    
    /// 方法二：使用系统标准的Queue
    dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
    dispatch_queue_t HightGlobalDisPatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
}



/// 异步处理，处理完后使用异步处理的结果回到主线程中做事
- (void)xiancheng
{
    
    dispatch_async(@"queue", ^{
        // 这里异步的东西叮咣一顿处理完，处理完之后，使用处理结果，回到主线程中调用必须再主线程中做的事
        dispatch_async(dispatch_get_main_queue(), ^{
            // 只能再主线程中做的事
        });
    });
}


@end
