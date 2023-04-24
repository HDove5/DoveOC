
 NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
NS_EXTENSION_UNAVAILABLE_IOS 是一个编译器宏，用于标记某些 API 在 iOS 应用程序扩展中不可用。当开发者在 iOS 应用程序扩展中使用了这些被标记的 API 时，编译器会给出警告信息。
这个宏是用来标记某些 API 不适用于应用程序扩展，而开发者应该使用基于视图控制器的解决方案来替代。这个宏的目的是为了提示开发者不要在应用程序扩展中使用这些 API，因为在扩展中使用这些 API 可能会导致应用程序被拒绝上架或者无法通过审核。
(在合适的地方使用基于视图控制器的解决方案)




UIKIT_EXTERN 是一个定义在 UIKit 框架中的宏，用于声明一个在 UIKit 框架外可见的符号。在 Objective-C 中，使用 extern 关键字声明的变量或函数可以被其他文件或框架访问，但是这些变量或函数的实现必须在编译期间链接到应用程序中。而使用 UIKIT_EXTERN 声明的变量或函数可以在 UIKit 框架外访问，而且不需要在编译期间链接到应用程序中，而是在运行时动态加载。
通常情况下，我们在使用 UIKit 框架提供的方法、常量、宏等时，都会用到 UIKIT_EXTERN 这个宏。举个例子，UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification 声明了一个 UIApplicationDidBecomeActiveNotification 常量，表示应用程序已经激活的通知，其他文件或框架可以通过引入 UIKit 框架头文件来访问这个常量



NS_REQUIRES_SUPER是一个宏定义，用于告知开发者在子类中覆盖（重写）父类方法时必须调用父类方法
