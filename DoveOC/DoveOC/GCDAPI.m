//
//  GCDAPI.m
//  DoveOC
//
//  Created by DOVE on 2022/1/5.
//

#import "GCDAPI.h"

@implementation GCDAPI

/*
 
 GCD优点

 GCD 可用于多核的并行运算；
 GCD 会自动利用更多的 CPU 内核（比如双核、四核）；
 GCD 会自动管理线程的生命周期（创建线程、调度任务、销毁线程）；
 程序员只需要告诉 GCD 想要执行什么任务，不需要编写任何线程管理代码。
 
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
    // 可以认为是并发方式的 for 循环语句
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
    
    //任务会等待它之前的所有其他任务完成，才开始执行！而它之后的任务会暂停
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




/*
 
 概念词 ：
 
 串行、并行任务
 Serial
 Concurrent
 
 同步、异步队列
 Synchronous
 Asynchronous
 
 临界区
 Critical Section
 概念：通过对多线程的串行化来访问公共资源或一段代码，速度快，适合控制数据访问。在任意时刻只允许一个线程对共享资源进行访问，如果有多个线程试图访问公共资源，那么在有一个线程进入后，其他试图访问公共资源的线程将被挂起，并一直等到进入临界区的线程离开，临界区在被释放后，其他线程才可以抢占。
 
 竞态条件
 Race Condition
 从多进程间通信的角度来讲，是指两个或多个进程对共享的数据进行读或写的操作时，最终的结果取决于这些进程的执行顺序
 多描述基于特定序列或事件执行时机的软件系统以不受控制的方式运行的行为 ，例如程序的并发任务执行的确切顺序。竞态条件可导致无法预测的行为，而不能通过代码检查立即发现
 
 死锁
 Deadlock
 
 线程安全
 Thread Safe
 
 上下文切换
 Context Switch
 概念：一个上下文切换指当你在单个进程里切换执行不同的线程时存储与恢复执行状态的过程。这个过程在编写多任务应用时很普遍，但会带来一些额外的开销。
 
 
 并发 并行
 Concurrency Parallelism
 概念：并发和并行从宏观角度来看都是同时处理多个任务。但并发和并行又有区别，如果你理解的同时是指同一个时刻发生，那么称之为两个或多个任务并行执行；若你理解的同时是指同一时间间隔（0.01秒内）发生，那么称之为多个任务并发执行。

 队列
 Queue
 
 调度队列
 dispatch Queue
 调度队列自身是线程安全的
 
 串行队列
 Serial Queue
 
 并发队列
 Concurrent Queue
 
 任务派发
 Grand Central Dispatch
 我们使用 GCD 接口仅涉及 Queue & Task，正确地把 Task 加入到 Queue，然后什么都不用管
 根据任务性质，所处环境以及机器配置来决定是否使用现有线程，哪个线程，或是创建一个新的线程，然后把任务派发出去
 
 
 */



/*
 信号量临时专栏
 
 日常开发中，我们对串行执行方式“愈加不满”，不断开辟线程来处理事务，要知道线程达到一定数量会导致应用崩溃！因此一方面我们希望并发处理，一方面又不想过多的创建线程（可能是无心之失，执行任务过于耗时，不断累积导致最后线程数量爆炸）。

 因此我们需要信号量来控制并发操作。dispatch_semaphore_create(count) 创建一个初始值为 count 的信号量，允许访问资源的总量（这里的资源就是线程数量），使用 dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) 查询是否有足够的资源供当前使用，当信号总量小于等于0的时候会一直等待，否则表示有足够的资源（起码有一个），允许执行你要的操作，并让信号总量减 1 ——因为此刻你占有了它。当然使用完这个资源时，你需要使用 dispatch_semaphore_signal(semaphore) 来通知信号量加 1来 来释放资源使用权。其他等待信号量大于 0 的地方，此刻由于资源的占有权空出，允许开始执行他们的任务了。
 
 */
- (void)semaphore
{
    dispatch_group_t group = dispatch_group_create();   // 1
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);   // 2
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // 3
    for (int i = 0; i < 100; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);   // 4
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);    // 5
            sleep(2);
            dispatch_semaphore_signal(semaphore);   // 6
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);// 7
    NSLog(@"所有任务完成");
}


@end
