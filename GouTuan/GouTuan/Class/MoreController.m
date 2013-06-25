#import "MoreController.h"

@implementation MoreController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
@synthesize mBkUIImageView;
- (id)init {
  if (self = [super init]) {
      self.title = NSLocalizedString(@"more",nil);
      UIImage* image = [UIImage imageNamed:@"menu_more.png"];
      self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:4] autorelease];
      self.tableViewStyle = UITableViewStyleGrouped;
      self.mBkUIImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
      self.tableView.backgroundView = self.mBkUIImageView;
      self.dataSource = [TTListDataSource dataSourceWithObjects:
                         [TTTableTextItem itemWithText:NSLocalizedString(@"city",nil) URL:@"tt://city/init"],
                         [TTTableTextItem itemWithText:NSLocalizedString(@"about",nil) URL:@"tt://about/init"],
                         nil];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated
{

    self.tableView.backgroundView = self.mBkUIImageView;
    [super viewDidAppear:animated];
}

- (void)dealloc {
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

@end
