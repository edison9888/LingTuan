#import "WallViewController.h"
#import "WallTableItem.h"
#import "WallTableItemCell.h"
#import "ShareData.h"
#include <math.h>

@implementation WallViewController
@synthesize distanceTextLabel,distanceImageView;
- (id)init {
    if (self = [super init]) {
        self.title = NSLocalizedString(@"wall",nil);
        UIImage* image = [UIImage imageNamed:@"menu_wall.png"];
        self.variableHeightRows = YES;
        
        //self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]] autorelease];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSLog(@"WallViewController Init");
        self.dataSource = [WallDataSource wallDataSource];
        //[self layout];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:2] autorelease];
        
        UIImageView *distancebgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timer_item_bg.png"]] autorelease];
        distancebgView.frame = CGRectMake(0,0, 320, 32);
        self.distanceImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"walk.png"]] autorelease];
        self.distanceImageView.frame = CGRectMake(290,0, 31, 31);
        
        self.distanceTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 85, 32)];
        
        self.distanceTextLabel.text = @"公里远";
        self.distanceTextLabel.backgroundColor = [UIColor clearColor];
        self.distanceTextLabel.textColor = [UIColor whiteColor];
        self.distanceTextLabel.font = [UIFont boldSystemFontOfSize:14];


        [distancebgView addSubview:self.distanceImageView];
        [distancebgView addSubview:self.distanceTextLabel];
        [self.view addSubview:distancebgView];
        self.tableView.frame = CGRectMake(0,32,320,400);
        
        TTURLMap *map = [TTNavigator navigator].URLMap;
        [map from:@"tt://wall/refreshCity" toViewController:self selector:@selector(refreshCityCallBack)];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dealloc {

    TTURLMap *map = [TTNavigator navigator].URLMap;
    [map from:@"tt://wall/refreshCity" toViewController:self selector:@selector(refreshCityCallBack)];
    [super dealloc];
}

-(void)refreshCityCallBack
{
    WallListModel *pWallListModel = (WallListModel *)self.model;
    pWallListModel.page = 1;
    [self.model load:TTURLRequestCachePolicyDefault more:NO];
    [self.tableView reloadData];
}

- (void)layout {
    TTGridLayout *gridLayout = [[[TTGridLayout alloc] init] autorelease];
    [gridLayout setColumnCount: 1];
    [gridLayout setSpacing: 20.0f];
    [gridLayout setPadding: 10.0f];
    
    CGSize size = [gridLayout layoutSubviews:self.view.subviews forView:self.view];
    
    UIScrollView *scrollView = (UIScrollView*)self.view;
    scrollView.contentSize = CGSizeMake(scrollView.width, size.height);
}

const double EARTH_RADIUS = 6378.137;
static double rad(double d)
{
    return d * 3.1415926 / 180.0;
}

static double GetDistance(double lat1, double lng1, double lat2, double lng2)
{
    double radLat1 = rad(lat1);
    double radLat2 = rad(lat2);
    double a = radLat1 - radLat2;
    double b = rad(lng1) - rad(lng2);
    double s = 2 * sin(sqrt(pow(sin(a/2),2) + 
                                       cos(radLat1)*cos(radLat2)*pow(sin(b/2),2)));
    s = s * EARTH_RADIUS;
    s = round(s * 10000) / 10000;
    return s;
}

- (void)calDistance
{
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    startDeceleratingPosition = scrollView.contentOffset.y;
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    BOOL isPositionUp = startDeceleratingPosition < scrollView.contentOffset.y;     
    
    NSArray *paths = [self.tableView indexPathsForVisibleRows];
    UITableViewCell *cell;
    if(isPositionUp){
        cell = [self.tableView cellForRowAtIndexPath:[paths objectAtIndex:0]];
    } else {
        cell = [self.tableView cellForRowAtIndexPath:[paths lastObject]];
    }
    WallTableItemCell *wallCell = (WallTableItemCell *)cell;
    double dbWallLat = [wallCell.mStrLat doubleValue];
    double dbWallLng = [wallCell.mStrLng doubleValue];
    double dbDistance;
    if ([[ShareData sharedInstance].sStrCity isEqualToString:[ShareData sharedInstance].sStrReverseGeoCity]) {
        double dbLat = [ShareData sharedInstance].dbLat;
        double dbLng = [ShareData sharedInstance].dbLng;
        dbDistance = GetDistance(dbWallLat,dbWallLng,dbLat,dbLng);
    }
    else
    {
        double dbLat = [ShareData sharedInstance].dbLat;
        double dbLng = [ShareData sharedInstance].dbLng;
        dbDistance = GetDistance(dbWallLat,dbWallLng,dbLat,dbLng);
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didBeginDecelerating:(UIScrollView *)scrollView {
    startDeceleratingPosition = scrollView.contentOffset.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didEndDecelerating:(UIScrollView *)scrollView {
    BOOL isPositionUp = startDeceleratingPosition < scrollView.contentOffset.y;     
    
    NSArray *paths = [self.tableView indexPathsForVisibleRows];
    UITableViewCell *cell;
    if(isPositionUp){
        cell = [self.tableView cellForRowAtIndexPath:[paths objectAtIndex:0]];
    } else {
        cell = [self.tableView cellForRowAtIndexPath:[paths lastObject]];
    }
    if ([cell isKindOfClass:[WallTableItemCell class]]) {
        WallTableItemCell *wallCell = (WallTableItemCell *)cell;
        
        double dbWallLat;
        double dbWallLng;
        double dbDistance;
        if (wallCell.mStrLat) {
            dbWallLat = [wallCell.mStrLat doubleValue];
        }
        else
        {
            dbDistance=0;
            return;
        }
        if (wallCell.mStrLng) {
            dbWallLng = [wallCell.mStrLng doubleValue];
        }
        else
        {
            dbDistance=0;
            return;
        }
        
        
        if ([[ShareData sharedInstance].sStrCity isEqualToString:[ShareData sharedInstance].sStrReverseGeoCity]) {
            double dbLat = [ShareData sharedInstance].dbLat;
            double dbLng = [ShareData sharedInstance].dbLng;
            dbDistance = GetDistance(dbWallLat,dbWallLng,dbLat,dbLng);
        }
        else
        {
            double dbLat = [ShareData sharedInstance].dbCityCenterLat;
            double dbLng = [ShareData sharedInstance].dbCityCenterLng;
            dbDistance = GetDistance(dbWallLat,dbWallLng,dbLat,dbLng);
        }
        NSString *strDistane = [NSString stringWithFormat:@"%.2f 公里远",dbDistance];
        self.distanceTextLabel.text = strDistane;
        if (dbDistance<1) {
            [self.distanceImageView setImage:[UIImage imageNamed:@"walk.png"]];
        }
        else if(dbDistance>=1&&dbDistance<3)
        {
            [self.distanceImageView setImage:[UIImage imageNamed:@"skateboard.png"]];
        }
        else if(dbDistance>=3&&dbDistance<5)
        {
            [self.distanceImageView setImage:[UIImage imageNamed:@"bicycle.png"]];
        }
        else if(dbDistance>=5&&dbDistance<10)
        {
            [self.distanceImageView setImage:[UIImage imageNamed:@"car.png"]];
        }
        else
        {
            [self.distanceImageView setImage:[UIImage imageNamed:@"superman.png"]];
        }
    }
   
}

- (void)downloadButtonAction:(TTButton*)button {
//    if ([[button titleForState:UIControlStateNormal] isEqualToString: [k1MBDownloadTitle copy]]) {
//        [self loadWithUrl: [k1MBDownloadUrl copy]];
//    }
//    else if ([[button titleForState:UIControlStateNormal] isEqualToString: [k5MBDownloadTitle copy]]) {
//        [self loadWithUrl: [k5MBDownloadUrl copy]];
//    }
//    else if ([[button titleForState:UIControlStateNormal] isEqualToString: [k10MBDownloadTitle copy]]) {
//        [self loadWithUrl: [k10MBDownloadUrl copy]];
//    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) requestAction {
    NSString *strUrl;
    if ([[ShareData sharedInstance].sStrCity isEqualToString:[ShareData sharedInstance].sStrReverseGeoCity]) {
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=nearProduct&cityid=%d&lng=%.6f&lat=%.6f&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].dbLng,[ShareData sharedInstance].dbLat,1];
    }
    else
    {
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=nearProduct&cityid=%d&lng=%.6f&lat=%.6f&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].dbCityCenterLng,[ShareData sharedInstance].dbCityCenterLat,1];
    }
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
    
    //NSMutableArray *photArray = [NSMutableArray arrayWithCapacity:[rootObject count]];
    for(id  product in rootObject) {
        NSDictionary *productDic = product;
        NSString *productID = [productDic objectForKey:@"ProductID"];
        NSString *productImage = [productDic objectForKey:@"ProductImage"];
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
        //        [self.items addObject:[DetailProTableItem itemWithText:productDescription imageURL:productImage
        //                                                  defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount soldCount:productSoldCount URL:nil]];
    }
    
    /*
    CGFloat padding = 10;
    CGFloat viewWidth = scrollView.width/2 - padding*2;
    CGFloat viewHeight = TT_ROW_HEIGHT;
    
    CGFloat x = padding;
    CGFloat y = padding;
    for (id product in rootObject) {
        if (x + viewWidth >= scrollView.width) {
            x = padding;
            y += viewHeight + padding;
        }
        
        CGRect frame = CGRectMake(x, y, viewWidth, viewHeight);
        
        TTButton *button = [TTButton buttonWithStyle:@"toolbarRoundButton:" title:@"Wall"];
        [button setFont: [UIFont systemFontOfSize: 16.0f]];
        [button sizeToFit];
        [button addTarget:self action:@selector(downloadButtonAction:) forControlEvents: UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        
        x += frame.size.width + padding;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, y + viewHeight + padding);
     */
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    
}


@end
