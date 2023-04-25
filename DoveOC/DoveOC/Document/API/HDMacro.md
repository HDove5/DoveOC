
 NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
NS_EXTENSION_UNAVAILABLE_IOS 是一个编译器宏，用于标记某些 API 在 iOS 应用程序扩展中不可用。当开发者在 iOS 应用程序扩展中使用了这些被标记的 API 时，编译器会给出警告信息。
这个宏是用来标记某些 API 不适用于应用程序扩展，而开发者应该使用基于视图控制器的解决方案来替代。这个宏的目的是为了提示开发者不要在应用程序扩展中使用这些 API，因为在扩展中使用这些 API 可能会导致应用程序被拒绝上架或者无法通过审核。
(在合适的地方使用基于视图控制器的解决方案)




UIKIT_EXTERN 是一个定义在 UIKit 框架中的宏，用于声明一个在 UIKit 框架外可见的符号。在 Objective-C 中，使用 extern 关键字声明的变量或函数可以被其他文件或框架访问，但是这些变量或函数的实现必须在编译期间链接到应用程序中。而使用 UIKIT_EXTERN 声明的变量或函数可以在 UIKit 框架外访问，而且不需要在编译期间链接到应用程序中，而是在运行时动态加载。
通常情况下，我们在使用 UIKit 框架提供的方法、常量、宏等时，都会用到 UIKIT_EXTERN 这个宏。举个例子，UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification 声明了一个 UIApplicationDidBecomeActiveNotification 常量，表示应用程序已经激活的通知，其他文件或框架可以通过引入 UIKit 框架头文件来访问这个常量



NS_REQUIRES_SUPER是一个宏定义，用于告知开发者在子类中覆盖（重写）父类方法时必须调用父类方法


UI_APPEARANCE_SELECTOR是一个宏定义，用于声明支持在外观协议中设置属性的属性。
在iOS中，外观协议提供了一种方法来定制UI控件的外观，包括导航栏，标签栏，工具栏等。通过使用UI_APPEARANCE_SELECTOR宏，您可以将属性标记为支持外观协议，并允许开发人员使用外观协议来设置这些属性的值。
例如，如果您想让导航栏的背景色在应用程序的整个生命周期中保持一致，可以使用UIAppearance协议设置该属性。在导航栏类的头文件中，您可以将背景颜色属性标记为支持UI_APPEARANCE_SELECTOR，如下所示：
@property (nonatomic, strong) UIColor *barTintColor UI_APPEARANCE_SELECTOR;
这将允许开发人员在使用外观协议时设置导航栏的barTintColor属性。例如，可以使用以下代码将应用程序的主题颜色设置为导航栏的背景色：
[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.8 alpha:1.0]];
需要注意的是，并非所有属性都支持UI_APPEARANCE_SELECTOR宏，只有由UIAppearance协议支持的属性才能使用该宏进行标记。另外，如果您在定义属性时将其标记为UI_APPEARANCE_SELECTOR，则应该确保其实现满足外观协议的要求。





