#import "PageController.h"
#import "ShareData.h"
#import "PageListDataSource.h"
#import "PageTableItem.h"

@implementation PageController
@synthesize intPage,mBkUIImageView,reverseGeocoder;
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
-(id)initPageCaterogyID:(NSString*)strCategoryID CategoryName:(NSString*)strCategoryName CategoryCount:(NSString*)strCategoryCount
{
    if (self = [super init]) {
        self.intPage = 0;
        self.title = [NSString stringWithFormat:@"%@-%@",strCategoryName,[ShareData sharedInstance].sStrCity];
        //self.navigationItem.backButtonTitle = @"Back";
        [ShareData sharedInstance].sStrCategoryID = strCategoryID;
        [ShareData sharedInstance].sIntCategoryID = [strCategoryID intValue];
        [ShareData sharedInstance].sIntCategoryCount = [strCategoryCount intValue];
        //UIImage* image = [UIImage imageNamed:@"gt_images21.png"];
        //self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
        //self.tableViewStyle = UITableViewStyleGrouped;
        self.variableHeightRows = YES;
        self.dataSource = [PageDataSource pageDataSource];
        //self.tableView.backgroundColor = [UIColor colorWithRed:(191)/255.0f green:(191)/255.0f blue:(191)/255.0f alpha:1];
        //listDataSource = [TTListDataSource dataSourceWithObjects:nil];
        self.mBkUIImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
        mIntType = 1;
        
    }
    return self;
}

-(void)handleBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ((mIntType==1)||(mIntType==3)||(mIntType==4)) {
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
    self.tableView.backgroundView = self.mBkUIImageView;
}

-(id)initType:(NSString*)strType
{
    if (self = [super init]) {
        self.mBkUIImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
        if ([strType isEqualToString:@"nearby"]) {
            self.title = NSLocalizedString(@"nearby",nil);
            UIImage* image = [UIImage imageNamed:@"menu_nearby.png"];
            self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:1] autorelease];
            //self.tableViewStyle = UITableViewStyleGrouped;
            self.variableHeightRows = YES;
            
            self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem 
                                                        alloc] 
                                                       initWithTitle:NSLocalizedString(@"map",nil) style:UIBarButtonItemStylePlain 
                                                       target:self 
                                                       action:@selector(openMapModel)] autorelease];
            //self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]] autorelease];
            //self.tableView.backgroundColor = [UIColor colorWithRed:(191)/255.0f green:(191)/255.0f blue:(191)/255.0f alpha:1];
            self.dataSource = [PageDataSource pageDataSourceWithLocation];
            
            mLocationManager = [[CLLocationManager alloc] init];
            [mLocationManager setDelegate:self];
            mLocationManager.desiredAccuracy = kCLLocationAccuracyBest;//设定为最佳精度  
            mLocationManager.distanceFilter = 5.0f;//响应位置变化的最小距离(m) 
            [mLocationManager startUpdatingLocation];
            mIntType = 2;
            TTURLMap *map = [TTNavigator navigator].URLMap;
            [map from:@"tt://page/refreshCity" toViewController:self selector:@selector(refreshCityCallBack)];
        }
        else if([strType isEqualToString:@"myfav"])
        {
            self.title = NSLocalizedString(@"myfavorite",nil);
            //UIImage* image = [UIImage imageNamed:@"gt_images27.png"];
            //self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:1] autorelease];
            //self.tableViewStyle = UITableViewStyleGrouped;
            self.variableHeightRows = YES;
            //self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]] autorelease];
            self.dataSource = [PageDataSource pageDataSourceWithMyFav];
            mIntType = 3;
        }
        else if([strType isEqualToString:@"mypur"])
        {
            self.title = NSLocalizedString(@"mypurchase",nil);
            //UIImage* image = [UIImage imageNamed:@"gt_images27.png"];
            //self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:1] autorelease];
            //self.tableViewStyle = UITableViewStyleGrouped;
            self.variableHeightRows = YES;
            //self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]] autorelease];
            self.dataSource = [PageDataSource pageDataSourceWithMyPurchase];
            mIntType = 4;
        }
        else if([strType isEqualToString:@"myhistory"])
        {
            self.title = NSLocalizedString(@"history",nil);
            UIImage* image = [UIImage imageNamed:@"menu_history.png"];
            self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:3] autorelease];
            //self.tableViewStyle = UITableViewStyleGrouped;
            self.variableHeightRows = YES;
            //self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]] autorelease];
            self.dataSource = [PageDataSource pageDataSourceWithHistory];
            //[self initHistoryItem];
            mIntType = 5;
            //self.emptyView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
            /*
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *pathToUserCopyOfPlist;
            
            pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
            NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
            
            TTSearchlightLabel* label = [[[TTSearchlightLabel alloc] init] autorelease];
            label.text = @"Empty";
            label.font = [UIFont systemFontOfSize:25];
            label.textAlignment = UITextAlignmentCenter;
            label.contentMode = UIViewContentModeCenter;
            label.backgroundColor = [UIColor whiteColor];
            [label sizeToFit];
            label.frame = CGRectMake(0, 0, self.view.width, label.height + 80);
            self.emptyView = label;
            */
            //TTURLMap *map = [TTNavigator navigator].URLMap;
            //[map from:@"tt://page/pageaddNewItem" toSharedViewController:self selector:@selector(addNewItem)];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify:) name:@"historyAddNewItem" object:nil];
        }
        else if([strType isEqualToString:@"search"])
        {
            self.title = [NSString stringWithFormat:NSLocalizedString(@"searchresult",nil),strType];
            self.tableViewStyle = UITableViewStyleGrouped;
            self.variableHeightRows = YES;
            //self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]] autorelease];
            NSString *strSearchKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"strSearch"];
            self.dataSource = [PageDataSource pageDataSourceWithSearch:strSearchKey];
            mIntType = 6;
        }

    }
    return self;
}

- (void)dealloc {
    [mLocationManager release];
    [self.reverseGeocoder release];
    if (mIntType==2) {
        TTURLMap *map = [TTNavigator navigator].URLMap;
        [map from:@"tt://page/refreshCity" toViewController:self selector:@selector(refreshCityCallBack)];
    }
    else if (mIntType == 5) {
        //TTURLMap *map = [TTNavigator navigator].URLMap;
        //[map removeURL:@"tt://page//pageaddNewItem"];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"historyAddNewItem" object:nil];
    }
    [self.mBkUIImageView release];
    //TT_RELEASE_SAFELY(listDataSource);
    [super dealloc];
}

-(void)notify:(id)sender
{
    if ( mIntType == 5 ) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *pathToUserCopyOfPlist;
        
        pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
        
        NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
        NSDictionary *productDic = [historyArray objectAtIndex:0];
        
        NSString *productID = [productDic objectForKey:@"ProductID"];
        NSString *productImage = [productDic objectForKey:@"ProductImage"];
        NSString *productSmallImage = [productDic objectForKey:@"ProductSmallImage"];
        NSString *productArea = [productDic objectForKey:@"ProductArea"];
        NSString *productCompany = [productDic objectForKey:@"ProductCompanyName"];
        NSString *productPrice = [productDic objectForKey:@"ProductCurrentPrice"];
        NSString *productDiscount = [productDic objectForKey:@"ProductDiscount"];
        NSString *productDescription = [productDic objectForKey:@"ProductDescription"];
        NSString *productEffectivePeriod = [productDic objectForKey:@"ProductEffectivePeriod"];
        NSString *productNotes = [productDic objectForKey:@"ProductNotes"];
        NSString *productDetail = [productDic objectForKey:@"ProductDetail"];
        NSString *productSoldCount = [productDic objectForKey:@"ProductSoldCount"];
        NSString *strTime = [[ShareData sharedInstance] formatTime:productEffectivePeriod];
        //        [self.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount time:strTime URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                                         ]];
        PageDataSource *selfDataSource = (PageDataSource *)self.dataSource;
        //    [selfDataSource.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                         defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                           ]];
        [selfDataSource.items insertObject:[PageTableItem itemWithText:productDescription imageURL:(productSmallImage?productSmallImage:productImage)
                                                          defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea itemType:mIntType URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
                                            ] atIndex:0];
        //        [selfDataSource.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                                         ]];
        //[self.dataSource invalidate:YES];
        [self invalidateView];
        [self.tableView reloadData];
    }
}

-(void)refreshCityCallBack
{
    PageListModel *pListModel = (PageListModel *)self.model;
    pListModel.page = 1;
    [self.model load:TTURLRequestCachePolicyDefault more:NO];
    [self.tableView reloadData];
}

-(void)initHistoryItem
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToUserCopyOfPlist;
    
    pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
    
    NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
    
    for (int i =0; i<[historyArray count];i++) {
        NSDictionary *productDic = [historyArray objectAtIndex:0];
        
        NSString *productID = [productDic objectForKey:@"ProductID"];
        NSString *productImage = [productDic objectForKey:@"ProductImage"];
        NSString *productSmallImage = [productDic objectForKey:@"ProductSmallImage"];
        NSString *productArea = [productDic objectForKey:@"ProductArea"];
        NSString *productCompany = [productDic objectForKey:@"ProductCompanyName"];
        NSString *productPrice = [productDic objectForKey:@"ProductCurrentPrice"];
        NSString *productDiscount = [productDic objectForKey:@"ProductDiscount"];
        NSString *productDescription = [productDic objectForKey:@"ProductDescription"];
        NSString *productEffectivePeriod = [productDic objectForKey:@"ProductEffectivePeriod"];
        NSString *productNotes = [productDic objectForKey:@"ProductNotes"];
        NSString *productDetail = [productDic objectForKey:@"ProductDetail"];
        NSString *productSoldCount = [productDic objectForKey:@"ProductSoldCount"];
        NSString *strTime = [[ShareData sharedInstance] formatTime:productEffectivePeriod];
        //        [self.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount time:strTime URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                                         ]];
        PageDataSource *selfDataSource = (PageDataSource *)self.dataSource;
        //    [selfDataSource.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                         defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                           ]];
        //        [selfDataSource.items insertObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                                          defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                                            ] atIndex:0];
        [selfDataSource.items addObject:[PageTableItem itemWithText:productDescription imageURL:(productSmallImage?productSmallImage:productImage)
                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea itemType:mIntType URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
                                         ]];
    }
    [self invalidateView];
    [self.tableView reloadData];


}

-(void)addNewItem
{
    if ( mIntType == 5 ) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *pathToUserCopyOfPlist;
        
        pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
        
        NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
        NSDictionary *productDic = [historyArray objectAtIndex:0];
        
        NSString *productID = [productDic objectForKey:@"ProductID"];
        NSString *productImage = [productDic objectForKey:@"ProductImage"];
        NSString *productSmallImage = [productDic objectForKey:@"ProductSmallImage"];
        NSString *productArea = [productDic objectForKey:@"ProductArea"];
        NSString *productCompany = [productDic objectForKey:@"ProductCompanyName"];
        NSString *productPrice = [productDic objectForKey:@"ProductCurrentPrice"];
        NSString *productDiscount = [productDic objectForKey:@"ProductDiscount"];
        NSString *productDescription = [productDic objectForKey:@"ProductDescription"];
        NSString *productEffectivePeriod = [productDic objectForKey:@"ProductEffectivePeriod"];
        NSString *productNotes = [productDic objectForKey:@"ProductNotes"];
        NSString *productDetail = [productDic objectForKey:@"ProductDetail"];
        NSString *productSoldCount = [productDic objectForKey:@"ProductSoldCount"];
        NSString *strTime = [[ShareData sharedInstance] formatTime:productEffectivePeriod];
        //        [self.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount time:strTime URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                                         ]];
        PageDataSource *selfDataSource = (PageDataSource *)self.dataSource;
        //    [selfDataSource.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
        //                                         defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
        //                           ]];
        [selfDataSource.items insertObject:[PageTableItem itemWithText:productDescription imageURL:(productSmallImage?productSmallImage:productImage)
                                                          defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea itemType:mIntType URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
                                            ] atIndex:0];
//        [selfDataSource.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
//                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
//                                         ]];
        //[self.dataSource invalidate:YES];
        [self invalidateView];
        [self.tableView reloadData];
    }

}

- (void)viewDidAppear:(BOOL)animated
{

    //[self.tableView reloadData];
    //[self.dataSource invalidate:YES];
    //[self.model load:TTURLRequestCachePolicyDefault more:NO];
    [super viewDidAppear:animated];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    if ([object isKindOfClass:[PageTableItem class]]) {
        
        if (mIntType == 1 || mIntType == 2 ||mIntType == 6) {
            PageDataSource *pageDataSource = (PageDataSource *)self.dataSource;
            int intIndex = [indexPath row];
            NSDictionary *selectDic;
            if (mIntType == 1) {
               selectDic = [pageDataSource.dataSourceTodayPageList objectAtIndex:[indexPath row]];
            }
            else if(mIntType == 2)
            {
                selectDic = [pageDataSource.dataSourceNearbyPageList objectAtIndex:[indexPath row]];
            }
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *pathToUserCopyOfPlist;
            
            pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
            NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
            //[ShareData sharedInstance].sHistoryArray = historyArray;
            [historyArray insertObject:selectDic atIndex:0];
            BOOL blWrite=[historyArray writeToFile:pathToUserCopyOfPlist atomically:YES];
            
            //[self addNewItem];
            /*
            TTURLAction *action = [TTURLAction actionWithURLPath:@"tt://page/pageaddNewItem"];
            [action setAnimated:NO];
            [action setTransition:UIViewAnimationTransitionNone];
            [action setWithDelay:NO];
            [[TTNavigator navigator] openURLAction:action];
             */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"historyAddNewItem" object:nil];
        }
         

    }

    
}

-(id)initMyFav:(NSString*)myfav query:(NSDictionary*)query
{
    if (self = [super init]) {

    }
    return self;
}

-(id)initMyPurchase:(NSString*)mypur query:(NSDictionary*)query
{
    if (self = [super init]) {

    }
    return self;
}
- (void)openMapModel { 
//    if ([mLocationManager locationServicesEnabled]) {
//        
//        mLocationManager.desiredAccuracy = kCLLocationAccuracyBest;//设定为最佳精度  
//        mLocationManager.distanceFilter = 5.0f;//响应位置变化的最小距离(m) 
//        [mLocationManager startUpdatingLocation];
//    }
    //[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:@"tt://map/initMap"]];
    TTOpenURL([NSString stringWithFormat:@"tt://map/(initMap)"]);
    
} 

- (id)init {
  if (self = [super init]) {

  }
  return self;
}


#pragma mark CLLocationManagerDelegate
- (void)reverseCityLatitude:(double)latitude Longitude:(double)longitude
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    self.reverseGeocoder =
    [[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
    self.reverseGeocoder.delegate = self;
    [self.reverseGeocoder start];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"MKReverseGeocoder has failed.");
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    NSLog(@"MKReverseGeocoder reverseGeocoder has success.");
    NSString *strReverseGeoCity = [placemark.locality substringToIndex:[placemark.locality length]-1];
    NSLog(@"%@",strReverseGeoCity);
    [ShareData sharedInstance].sStrReverseGeoCity = strReverseGeoCity;
    [[NSUserDefaults standardUserDefaults] setValue:strReverseGeoCity forKey:kCurrentGeoCity];
    
    if ([ShareData sharedInstance].sIntCityInit==0) {
        [ShareData sharedInstance].sStrCity = strReverseGeoCity;
        [[NSUserDefaults standardUserDefaults] setValue:strReverseGeoCity forKey:@"strcity"];
        [ShareData sharedInstance].sIntCityInit=1;
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"intcityinit"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    //[self reload];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathOfCityPlist;
    
    pathOfCityPlist = [documentsDirectory stringByAppendingPathComponent:@"City.plist"];
    NSMutableArray *cityArray = [NSMutableArray arrayWithContentsOfFile:pathOfCityPlist];
    
    for (id idCity in cityArray) {
        NSDictionary * cityDic = idCity;
        NSString *strCity = [cityDic objectForKey:@"name"];
        if ([strCity isEqualToString:strReverseGeoCity]) {
            NSString *strCityID = [cityDic objectForKey:@"id"];
            [ShareData sharedInstance].sStrCity = strCity;
            [ShareData sharedInstance].sIntCity = [strCityID intValue];
            [[NSUserDefaults standardUserDefaults] setInteger:[strCityID intValue] forKey:@"intcity"];
            [[NSUserDefaults standardUserDefaults] setValue:strCity forKey:@"strcity"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            break;
        }
    }

    TTOpenURL(@"tt://today/refreshCity");
    TTOpenURL(@"tt://page/refreshCity");
    TTOpenURL(@"tt://wall/refreshCity");
}

- (void)saveLocationLatitude:(double)latitude Longitude:(double)longitude{
	//NSNumber *locationLatitude = [NSNumber numberWithDouble:latitude];
	//NSNumber *locationLongitude = [NSNumber numberWithDouble:longitude];
	[[NSUserDefaults standardUserDefaults] setDouble:latitude forKey:kLastLocationLatitude];
	[[NSUserDefaults standardUserDefaults] setDouble:longitude forKey:kLastLocationLongitude];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"PageController savelocation successfully");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [mLocationManager stopUpdatingLocation];
    [ShareData sharedInstance].dbLng = newLocation.coordinate.longitude;
    [ShareData sharedInstance].dbLat = newLocation.coordinate.latitude;
    [self reverseCityLatitude:newLocation.coordinate.latitude Longitude:newLocation.coordinate.longitude];
    [self saveLocationLatitude:newLocation.coordinate.latitude Longitude:newLocation.coordinate.longitude];
    NSLog(@"PageController location successfully");
    //[self invalidateModel];
    //[self invalidateView];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	[mLocationManager stopUpdatingLocation];
    TTAlert([error localizedDescription]);
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

@end
