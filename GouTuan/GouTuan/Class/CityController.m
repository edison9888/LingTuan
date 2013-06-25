#import "CityController.h"
#import "ShareData.h"
#import "MockDataSource.h"

@implementation CityController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
      self.title = NSLocalizedString(@"city",nil);
      UIImage* image = [UIImage imageNamed:@"gt_images19.png"];
      self.tableViewStyle = UITableViewStyleGrouped;
      //self.variableHeightRows = YES;
      //self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
      cityDataSource = [TTSectionedDataSource dataSourceWithObjects:nil];
      [self requestAction];
      self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:4] autorelease];
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
-(void)handleBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:175.0/255.0 green:191.0/255.0 blue:236.0/255.0 alpha:1.0]; 
        
    //Create the custom back button
    TTButton *backButtonView = [TTButton buttonWithStyle:@"toolbarBackButton:" title:NSLocalizedString(@"back",nil)];
    [backButtonView addTarget:self action:@selector(handleBack) forControlEvents:UIControlEventTouchUpInside];
    [backButtonView sizeToFit];
    backButtonView.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release]; 
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) requestAction {
    TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=cityList"]
                                                delegate: self];
    
    // TTURLImageResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    
    [request send];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTURLRequestDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
    TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
    NSArray * rootObject = response.rootObject;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToUserCopyOfPlist;
    
    pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"City.plist"];
    NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
    BOOL blWrite=[rootObject writeToFile:pathToUserCopyOfPlist atomically:YES];
    
    /*
    NSMutableArray *cityArray = [NSMutableArray arrayWithCapacity:[rootObject count]];
    for (id city in rootObject) {
        NSDictionary *cityDic = city;
        NSString *cityPY = [cityDic objectForKey:@"py"];
        NSString *cityName = [cityDic objectForKey:@"name"];
        NSString *cityID = [cityDic objectForKey:@"id"];
        [cityArray addObject:cityPY];
    }
    */
    
    MockDataSource *ds = [[MockDataSource alloc] init:rootObject];
    //ds.addressBook.fakeLoadingDuration = 1.0;
    self.dataSource = ds;
    [ds release];
    
    
    //self.dataSource = cityDataSource;
    
    //[self invalidateModel];
    //[self reload];
    //[self invalidateView];
    [self.tableView reloadData];
    //[self invalidateView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    cityIndex = indexPath;
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:nil
                                                     message:NSLocalizedString(@"changecity",nil)
                                                    delegate:self
                                           cancelButtonTitle:TTLocalizedString(@"OK", @"")
                                           otherButtonTitles:TTLocalizedString(@"Cancel", @""),nil] autorelease];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self selectCity:cityIndex];
    }
}

-(void)selectCity:(NSIndexPath*)indexPath
{
    id newobject = [self.dataSource tableView:self.tableView objectForRowAtIndexPath:indexPath];
    
    TTTableTextItemCell *cell = [self.dataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
    TTTableTextItem *item = newobject;
    NSString *strCityId = item.mStrId;
    int intCityId = [strCityId intValue];
    NSString *strCityName = cell.textLabel.text;
    
    double dbLat = [item.mStrLatitude doubleValue];
    double dbLng = [item.mStrLongtitude doubleValue];
    
    [[NSUserDefaults standardUserDefaults] setDouble:dbLat forKey:kCityCenterLocationLatitude];
    [[NSUserDefaults standardUserDefaults] setDouble:dbLng forKey:kCityCenterLocationLongitude];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [ShareData sharedInstance].dbLng = dbLng;
    [ShareData sharedInstance].dbLat = dbLat;
    [ShareData sharedInstance].dbCityCenterLng = dbLng;
    [ShareData sharedInstance].dbCityCenterLat = dbLat;
    
    [ShareData sharedInstance].sStrCity = strCityName;
    [ShareData sharedInstance].sIntCity = intCityId;
    [[NSUserDefaults standardUserDefaults] setValue:strCityName forKey:@"strcity"];
    [[NSUserDefaults standardUserDefaults] setInteger:intCityId forKey:@"intcity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self.tableView reloadData];
    TTOpenURL(@"tt://today/refreshCity");
    TTOpenURL(@"tt://page/refreshCity");
    TTOpenURL(@"tt://wall/refreshCity");
    TTOpenURL(@"tt://today/(init)");
}
@end
