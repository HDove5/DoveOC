//
//  HDHomeViewController.m
//  DoveOC
//
//  Created by DOVE on 2022/10/13.
//

#import "HDHomeViewController.h"
#import "HDWebViewController.h"

@interface HDHomeViewController ()

@end

@implementation HDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *V = [[UIPress alloc
     ]init];
    [V endEditing:YES];
    
    
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HDWebViewController *webView = [[HDWebViewController alloc] init];
    [self.navigationController pushViewController:webView animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
