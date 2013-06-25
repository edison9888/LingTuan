#import "MapController.h"
#import "ShareData.h"

@implementation MapController
@synthesize mapView;
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (id)init {
  if (self = [super init]) {
      NSLog(@"MapController init Enter");
      self.title = NSLocalizedString(@"nearby",nil);
      blRoute = FALSE;
      blSingleAnnotation = FALSE;
      intMapModel=0;
      self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem 
                                                  alloc] 
                                                 initWithTitle:NSLocalizedString(@"direction",nil) style:UIBarButtonItemStylePlain 
                                                 target:self 
                                                 action:@selector(openDirection)] autorelease];
      
      self.mapView = [[MKMapView alloc] initWithFrame:TTNavigationFrame()];
      [self.view addSubview:self.mapView];
      
      double latitude = [ShareData sharedInstance].dbLat;
      double longitude = [ShareData sharedInstance].dbLng;
      
      CLLocationCoordinate2D coordinate;
      
      coordinate.latitude = latitude;
      coordinate.longitude = longitude;
      
      [self setMapLocation:coordinate distance:1000 animated:NO];
      
      [self.mapView setShowsUserLocation:YES];
      [self.mapView setMapType:MKMapTypeStandard];
      [self.mapView setDelegate:self];

      NSLog(@"MapController init Exit");
      
  }
  return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (intMapModel==0) {
        NSLog(@"MapController viewWillAppear Enter");
        NSArray *nearbyArray = [ShareData sharedInstance].sNearbyArray;
        int intNearCount = [nearbyArray count];
        if (intNearCount>=60) {
            intNearCount=60;
        }
        for (int i=0;i<intNearCount;i++) {
            id object = [nearbyArray objectAtIndex:i];
            CLLocationCoordinate2D coordinate;
            NSDictionary *shopDic = [object objectForKey:@"ProductShopInfo"];
            NSString * longtitude = [shopDic objectForKey:@"lng"];
            NSString * lattitude = [shopDic objectForKey:@"lat"];
            NSString * shopname = [shopDic objectForKey:@"name"];
            NSString * shopAddress = [shopDic objectForKey:@"addr"];
            coordinate.longitude = [longtitude doubleValue];
            coordinate.latitude = [lattitude doubleValue];
            MapAnnotation *pMapAnnotation=[[[MapAnnotation alloc] initWithCoordinate:coordinate] autorelease];
            pMapAnnotation.title = shopname;
            pMapAnnotation.subtitle = shopAddress;
            pMapAnnotation.productID = [object objectForKey:@"ProductID"];
            [mapView addAnnotation:pMapAnnotation];
        }
        NSLog(@"MapController viewWillAppear Exit");
        intMapModel = 2;
    }
    else if(intMapModel==1)
    {
        
    }

    [super viewWillAppear:animated];
}

- (id)initWithLongtitude:(NSString*)strLongtitude latitude:(NSString*)strLatitude{
    if (self = [super init]) {
        NSLog(@"MapController initWithLongtitude Enter");
        self.title = NSLocalizedString(@"tuanMap",nil);
        blRoute = FALSE;
        blSingleAnnotation = TRUE;
        intMapModel=1;
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem 
                                                    alloc] 
                                                   initWithTitle:NSLocalizedString(@"direction",nil) style:UIBarButtonItemStylePlain 
                                                   target:self 
                                                   action:@selector(openDirection)] autorelease];
        
        self.mapView = [[MKMapView alloc] initWithFrame:TTNavigationFrame()];
        [self.view addSubview:self.mapView];
        
        double latitude = [[[NSUserDefaults standardUserDefaults] valueForKey:kShopLocationLatitude] doubleValue];
        double longitude = [[[NSUserDefaults standardUserDefaults] valueForKey:kShopLocationLongitude] doubleValue];
        

        CLLocationCoordinate2D coordinate;
        
        coordinate.latitude = latitude;
        coordinate.longitude = longitude;
        
        [self setMapLocation:coordinate distance:1000 animated:NO];
        
        [self.mapView setShowsUserLocation:YES];
        [self.mapView setMapType:MKMapTypeStandard];
        [self.mapView setDelegate:self];
        

        desCoordinate.longitude = [strLongtitude doubleValue];
        desCoordinate.latitude = [strLatitude doubleValue];
        MapAnnotation *pMapAnnotation=[[[MapAnnotation alloc] initWithCoordinate:desCoordinate] autorelease];
        NSString *strShopName = [[NSUserDefaults standardUserDefaults] objectForKey:kShopName];
        NSString *strShopAddr = [[NSUserDefaults standardUserDefaults] objectForKey:kShopAddr];
        pMapAnnotation.title = strShopName;
        pMapAnnotation.subtitle = strShopAddr;
        [mapView addAnnotation:pMapAnnotation];
        NSLog(@"MapController initWithLongtitude Exit");
    }
    return self;
}


- (void)dealloc {
    [self.mapView release];
  [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setMapLocation:(CLLocationCoordinate2D)coordinate distance:(double)distance animated:(BOOL)animated{
    NSLog(@"MapController setMapLocation Enter");
	MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, distance, distance); 
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    NSLog(@"setMapLocation  distance");
	[self.mapView setRegion:adjustedRegion animated:animated];
    NSLog(@"“MapController setMapLocation Exit");
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

//delegate   MKMapViewDelegate
/*
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    NSLog(@"mapView didUpdateUserLocation");
    //[self setMapLocation:coordinate distance:1000 animated:NO];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    int k = 0;
}
*/

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    if ([annotation isKindOfClass:[MapAnnotation class]]==YES)  
    {
         NSLog(@"mapView viewForAnnotation");
        MKPinAnnotationView *annView=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];
        
        if (!blSingleAnnotation) 
        {
            UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [advertButton addTarget:self action:@selector(showLinks) forControlEvents:UIControlEventTouchUpInside];
            
            annView.rightCalloutAccessoryView = advertButton; 
        }

        
        annView.animatesDrop=TRUE;
        annView.canShowCallout = YES;
        annView.calloutOffset = CGPointMake(-5, 5);
        return annView;
        


    }
    else
    {
         NSLog(@"mapView viewForAnnotation else");
        MapAnnotation * Mapannotation=annotation;  
        Mapannotation.title=@"当前位置";  
        
        return  nil; 
    }
}

-(void)showLinks
{
    //[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://detail/%@",productID]]];
    TTOpenURL([NSString stringWithFormat:@"tt://detail/%@",productID]);

}

-(void)openDirection
{
//    NSString* addr = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=Current Location&saddr=%@",startAddr]; 
//    NSURL* url = [[NSURL alloc] initWithString:[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
//    [[UIApplication sharedApplication] openURL:url]; 
//    [url release];
    
    
    CLLocationCoordinate2D currentLocation = self.mapView.userLocation.coordinate;
    NSString* url;
    if (blSingleAnnotation) {
        url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f", currentLocation.latitude, currentLocation.longitude,desCoordinate.latitude,desCoordinate.longitude];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
    else
    {
        if (blRoute) {
            url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f", currentLocation.latitude, currentLocation.longitude,annotationLatitude,annotationLongtitude]; 
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
       
    }
    
    
}

/*
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation  
{  
    //判断是否是自己  
    if ([annotation isKindOfClass:[MapAnnotation class]]==YES)  
    {  
        MKAnnotationView *  view;  
        view=(MKAnnotationView *) [mapView  dequeueReusableAnnotationViewWithIdentifier:annotation.title];  
        
        
        if (view==nil)  
        {  
            view=[[[MKAnnotationView  alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title]  autorelease];  
        }  
        else   
        {  
            view.annotation=annotation;  
        }  
        
        
        //设置图标  
        MapAnnotation * Mapannotation=annotation;  
        [view   setImage:[UIImage  imageNamed:@"cat_2.png"] ];  
        
        view.canShowCallout=TRUE;  
        return   view;  
    }  
    else   
    {  
        MapAnnotation * Mapannotation=annotation;  
        Mapannotation.title=@"当前位置";  
        
        return  nil;  
    }  
}  

- (void) mapView:(MKMapView *)mapView   didAddAnnotationViews:(NSArray*) views  
{  
    int   i=0;  
    for (MKPinAnnotationView     *mkview   in   views     )   
    {  
        //判断是否是自己  
        if ([mkview.annotation isKindOfClass:[MapAnnotation class]]==NO)  
        {  
            continue;     
        }  
        else  
        {  
            UIImageView   *  headImageView=[[UIImageView  alloc] initWithImage:[UIImage   imageNamed:@"cat_1.png"] ];  
            [headImageView  setFrame:CGRectMake(1, 1, 30, 32)];  
            [headImageView  autorelease];  
            mkview.leftCalloutAccessoryView=headImageView;      
            
            
            UIButton  *  rightbutton=[UIButton  buttonWithType:UIButtonTypeDetailDisclosure];  
            mkview.rightCalloutAccessoryView=rightbutton;  
        }  
        i++;  
    }  
    
    
}
*/

//当用户点击小人图标的时候，就进入这里，即将显示 AnnotationView  
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view  
{  
    NSLog(@"MapController didSelectAnnotationView Enter");
    if ([view.annotation isKindOfClass:[MapAnnotation class]]==NO)  
    {  
        NSLog(@"MapController didSelectAnnotationView return");
        return  ;  
    }  
    
    //设置显示的视图的内容  
    MapAnnotation *  annotation=(MapAnnotation *) view.annotation;  
    //通过MapAnnotation就可以获得自己设置的一些个性化信息
    productID = annotation.productID;
    annotationLatitude = annotation.coordinate.latitude;
    annotationLongtitude = annotation.coordinate.longitude;
    blRoute = TRUE;
    NSLog(@"MapController didSelectAnnotationView Exit");
    
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"MapController didDeselectAnnotationView Enter");
    blRoute = FALSE;
    NSLog(@"MapController didDeselectAnnotationView Exit");
}

@end
