#import "TodayController.h"
#import "ShareData.h"
#import "TodayDataSource.h"
@implementation TodayController
@synthesize citName,searchBar,mBkUIImageView;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (id)init {
  if (self = [super init]) {
      self.citName = [ShareData sharedInstance].sStrCity;
      [ShareData sharedInstance].sStrCity = self.citName;
      self.title = [NSString stringWithFormat:@"%@-%@", NSLocalizedString(@"today",nil),self.citName];
      //self.navigationController.title = [NSString stringWithFormat:@"%@-%@", NSLocalizedString(@"today",nil),self.citName];
      UIImage* image = [UIImage imageNamed:@"menu_today.png"];
      self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
      self.tabBarItem.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"today",nil)];
      //self.tableViewStyle = UITableViewStyleGrouped;
      self.dataSource = [TodayDataSource todayDataSource];
      self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]] autorelease];
      //self.tableView.backgroundColor = [UIColor colorWithRed:(191)/255.0f green:(191)/255.0f blue:(191)/255.0f alpha:1];
      self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
      self.searchBar.tintColor = [UIColor blackColor];
      self.searchBar.delegate = self;
      self.searchBar.showsCancelButton = YES;
      self.tableView.tableHeaderView = self.searchBar;
      TTURLMap *map = [TTNavigator navigator].URLMap;
      [map from:@"tt://today/refreshCity" toViewController:self selector:@selector(refreshCityCallback)];
  }
  return self;
}

- (void)dealloc {
    TTURLMap *map = [TTNavigator navigator].URLMap;
    [map removeURL:@"tt://today/refreshCity"];
  [super dealloc];
}

-(void)refreshCityCallback
{
    self.citName = [ShareData sharedInstance].sStrCity;
    self.title = [NSString stringWithFormat:@"%@-%@", NSLocalizedString(@"today",nil),self.citName];
    [self.model load:TTURLRequestCachePolicyDefault more:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tableView.tableHeaderView = self.searchBar;
    self.tabBarItem.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"today",nil)];
    [super viewDidAppear:animated];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath
{
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

#pragma mark UISearchBarDelegate methods
- (void) searchBarSearchButtonClicked: (UISearchBar *)theSearchBar {
    NSString *strSearch = [theSearchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[NSUserDefaults standardUserDefaults] setValue:strSearch forKey:@"strSearch"];
    TTOpenURL([NSString stringWithFormat:@"tt://page/search"]);
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar {

}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void) searchBar: (UISearchBar *)searchBar textDidChange: (NSString *)searchText {

}
@end
