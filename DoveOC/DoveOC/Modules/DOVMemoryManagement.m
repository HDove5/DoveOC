//
//  DOVMemoryManagement.m
//  DoveOC
//
//  Created by DOVE on 2022/1/6.
//

#import "DOVMemoryManagement.h"

@implementation DOVMemoryManagement


/*
 IOS开发中，内存中的对象主要有两类，一类是值类型，比如int、float、struct等基本数据类型，另一类是引用类型，也就是继承自NSObject类的所有的OC对象。前一种值类型不需要我们管理，后一种引用类型是需要我们管理内存的，一旦管理不好，就会产生非常糟糕的后果。
 为什么值类型不需要管理，而引用类型需要管理呢？那是因为他们分配内存方式不一样。
 值类型会被放入栈中，他们依次紧密排列，在内存中占有一块连续的内存空间，遵循先进后出的原则。引用类型会被放到堆中，当给对象分配内存空间时，会随机的从内存当中开辟空间，对象与对象之间可能会留有不确定大小的空白空间，因此会产生很多内存碎片，需要我们管理。
 栈内存与堆内存从性能上比较，栈内存要优于堆内存，这是因为栈遵循先进后出的原则，因此当数据量过大时，存入栈会明显的降低性能。因此，我们会把大量的数据存入堆中，然后栈中存放堆的地址，当需要调用数据时，就可以快速的通过栈内的地址找到堆中的数据。
 值类型和引用类型之间是可以相互转化的，把值类型转化为引用类型的过程叫做装箱，比如把int包装为NSNumber，这个过程会增加程序的运行时间，降低性能。而把引用类型转为值类型的过程叫做拆箱，比如把NSNumer转为float，在拆箱的过程中，我们一定要注意数据原有的类型，如果类型错误，可能导致拆箱失败，因此会存在安全性的问题。手动的拆箱和装箱，都会增加程序的运行时间，降低代码可读性，影响性能。

 
 
 程序在运行的过程中通常通过以下行为，来增加程序的的内存占用
 创建一个OC对象
 定义一个变量
 调用一个函数或者方法
 而一个移动设备的内存是有限的，每个软件所能占用的内存也是有限的
 当程序所占用的内存较多时，系统就会发出内存警告，这时就得回收一些不需要再使用的内存空间。比如回收一些不需要使用的对象、变量等
 如果程序占用内存过大，系统可能会强制关闭程序，造成程序崩溃、闪退现象，影响用户体验

 
 
 只要一个对象被释放了，我们就称这个对象为 "僵尸对象(不能再使用的对象)"
 空指针：空指针是一个特殊的指针值，也是唯一一个对任何指针类型都合法的指针值。指针变量具有空指针值，表示它当时处于闲置状态，没有指向有意义的东西。
 野指针：野指针也就是指向不可用内存区域的指针（比如：在首次使用之前没有进行必要的初始化；垂悬指针也是可以算是野指针的一种）。通常对这种指针进行操作的话，将会使程序发生不可预知的错误。
 通用指针（void 指针） ：通用指针，它可以指向任何类型的变量。通用指针的类型用（void *）表示，因此也称为 void 指针。
 悬垂指针（迷途指针） ：指向曾经存在的对象，但该对象已经不再存在了，此类指针称为悬垂指针。结果未定义，往往导致程序错误，而且难以检测。

 给空指针发消息是没有任何反应的
 
 
 */

- (int)test
{
    @autoreleasepool {
        int a = 10; // 栈
        int b = 20; // 栈
        // obj : 栈
        // NSObject对象(计数器==1) : 堆
        NSObject *obj = [[NSObject alloc] init];
        NSLog(@"%d - %d - %@, ", a, b, obj);
    }
    // 经过上面代码后, 栈里面的变量a、b、p 都会被回收
    // 但是堆里面的NSObject对象还会留在内存中,因为它是计数器依然是1
    return 0;
}


/*
 内存溢出 OOM
 OutOfMemory
 https://zhuanlan.zhihu.com/p/49829766
 https://satanwoo.github.io/2017/10/18/abort/
 
 */

@end
