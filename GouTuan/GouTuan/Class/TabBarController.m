#import "TabBarController.h"

@implementation TabBarController

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)viewDidLoad {
  [self setTabURLs:[NSArray arrayWithObjects:@"tt://today/(init)",
                                             @"tt://page/nearby",
                                             @"tt://wall/(init)",
                                             @"tt://mine/(init)",
                                             @"tt://more/(init)",
                                             nil]];
    
    self.customizableViewControllers = nil;
    // Due to a bug in iOS 4.0, we need to manually hide the edit button when the edit controller
    // appears.
    
    NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion versionStringCompare:@"4.0"] >= 0
        && [systemVersion versionStringCompare:@"4.1"] < 0) {
        self.moreNavigationController.delegate = self;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)navigationController: (UINavigationController *)navigationController
      willShowViewController: (UIViewController *)viewController
                    animated: (BOOL)animated {
    
    UINavigationBar* morenavbar = navigationController.navigationBar;
    UINavigationItem* morenavitem = morenavbar.topItem;
    morenavitem.rightBarButtonItem = nil;
}

@end
