#if (defined(USE_UIKIT_PUBLIC_HEADERS) && USE_UIKIT_PUBLIC_HEADERS) || !__has_include(<UIKitCore/UIRefreshControl.h>)


#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>

NS_HEADER_AUDIT_BEGIN(nullability, sendability)
    


UIKIT_EXTERN API_AVAILABLE(ios(6.0)) API_UNAVAILABLE(tvos) NS_SWIFT_UI_ACTOR



@interface UIRefreshControl : UIControl

/* The designated initializer
 * This initializes a UIRefreshControl with a default height and width.
 * Once assigned to a UITableViewController, the frame of the control is managed automatically.
 * When a user has pulled-to-refresh, the UIRefreshControl fires its UIControlEventValueChanged event.
 *
*/
- (instancetype)init;

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

@property (null_resettable, nonatomic, strong) UIColor *tintColor;
@property (nullable, nonatomic, strong) NSAttributedString *attributedTitle UI_APPEARANCE_SELECTOR;

// May be used to indicate to the refreshControl that an external event has initiated the refresh action
- (void)beginRefreshing API_AVAILABLE(ios(6.0));
// Must be explicitly called when the refreshing has completed
- (void)endRefreshing API_AVAILABLE(ios(6.0));

@end

NS_HEADER_AUDIT_END(nullability, sendability)

#else
#import <UIKitCore/UIRefreshControl.h>
#endif



// 在 UITableView 中添加 UIRefreshControl
- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
}

- (void)refreshTableView:(UIRefreshControl *)refreshControl {
    // 从服务器获取新数据，更新数据源
    // ...

    // 结束刷新动画
    [refreshControl endRefreshing];
}

