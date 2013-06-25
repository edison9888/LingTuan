//
//  GouTuanAppDelegate.m
//  GouTuan
//
//  Created by  on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GouTuanAppDelegate.h"
#import "GouTuanViewController.h"
#import "TabBarController.h"
#import "TodayController.h"
#import "MineController.h"
#import "HistoryController.h"
#import "MoreController.h"
#import "CityController.h"
#import "AboutController.h"
#import "DetailController.h"
#import "PageController.h"
#import "CommentController.h"
#import "MapController.h"
#import "LoginController.h"
#import "WallViewController.h"
#import "ShareData.h"
#import "GTDefaultStyleSheet.h"

@implementation GouTuanAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TTStyleSheet setGlobalStyleSheet:[[[GTDefaultStyleSheet alloc]  
                                        init] autorelease]];
    [self initConfigure];
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    
    NSString *strCity = [[NSUserDefaults standardUserDefaults] stringForKey:@"strcity"];
    NSInteger intCity = [[NSUserDefaults standardUserDefaults] integerForKey:@"intcity"];
    NSInteger intLoginAuto = [[NSUserDefaults standardUserDefaults] integerForKey:@"intloginauto"];
    NSInteger intCityInit = [[NSUserDefaults standardUserDefaults] integerForKey:@"intcityinit"];
    double dbCityLat = [[NSUserDefaults standardUserDefaults] doubleForKey:kCityCenterLocationLatitude];
    double dbCityLng = [[NSUserDefaults standardUserDefaults] doubleForKey:kCityCenterLocationLongitude];
    [ShareData sharedInstance].sStrCity = strCity;
    [ShareData sharedInstance].sIntCity = intCity;
    [ShareData sharedInstance].dbCityCenterLat = dbCityLat;
    [ShareData sharedInstance].dbCityCenterLng = dbCityLng;
    [ShareData sharedInstance].sIntLoginAuto = intLoginAuto;
    [ShareData sharedInstance].sIntCityInit = intCityInit;

    
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[GouTuanViewController alloc] initWithNibName:@"GouTuanViewController" bundle:nil]; 
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    */
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
    
    TTURLMap* map = navigator.URLMap;
    
    // Any URL that doesn't match will fall back on this one, and open in the web browser
    [map from:@"*" toViewController:[TTWebController class]];
    
    // The tab bar controller is shared, meaning there will only ever be one created.  Loading
    // This URL will make the existing tab bar controller appear if it was not visible.
    [map from:@"tt://tabBar" toSharedViewController:[TabBarController class]];
    
    // Menu controllers are also shared - we only create one to show in each tab, so opening
    // these URLs will switch to the tab containing the menu
    [map from:@"tt://today/(init)" toSharedViewController:[TodayController class]];
    [map from:@"tt://wall/(init)" toSharedViewController:[WallViewController class]];
    [map from:@"tt://mine/(init)" toSharedViewController:[MineController class]];
    [map from:@"tt://history/(init)" toSharedViewController:[HistoryController class]];
    [map from:@"tt://more/(init)" toSharedViewController:[MoreController class]];
    [map from:@"tt://city/(init)" toSharedViewController:[CityController class]];
    [map from:@"tt://about/(init)" toSharedViewController:[AboutController class]];
    [map from:@"tt://page/(initPageCaterogyID:)/(CategoryName:)/(CategoryCount:)" toSharedViewController:[PageController class]];
    [map from:@"tt://page/(initType:)" toSharedViewController:[PageController class]];
    [map from:@"tt://detail/(initDetail:)" toViewController:[DetailController class]];
    [map from:@"tt://detail/gotopurchase" toSharedViewController:[DetailController class] selector:@selector(gotopurchase)];
    [map from:@"tt://detail/addtomyfav" toSharedViewController:[DetailController class] selector:@selector(addtomyfav)];
    [map from:@"tt://detail/addtomypurchase" toSharedViewController:[DetailController class] selector:@selector(addtomypurchase)];
    [map from:@"tt://detail/showcomment" toViewController:[DetailController class] selector:@selector(showComment)];
    [map from:@"tt://detail/openShareAction" toViewController:[DetailController class] selector:@selector(openShareAction)];
    [map from:@"tt://map/(initMap:)" toViewController:[MapController class] transition:UIViewAnimationTransitionFlipFromLeft];
    [map from:@"tt://map/(initWithLongtitude:)/(latitude:)" toViewController:[MapController class] transition:UIViewAnimationTransitionFlipFromLeft];
    [map from:@"tt://login/(init)" toModalViewController:[LoginController class]];
    [map from:@"tt://comment/(init)" toViewController:[CommentController class]];
    // Before opening the tab bar, we see if the controller history was persisted the last time
    if (![navigator restoreViewControllers]) {
        // This is the first launch, so we just start with the tab bar
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar"]];
    }

    return YES;
}

-(void)initConfigure
{
	// Check for data in Documents directory. Copy default appData.plist to Documents if not found.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToUserCopyOfPlist;
    NSString *pathToUserCityPList;
    pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
    pathToUserCityPList = [documentsDirectory stringByAppendingPathComponent:@"City.plist"];
    
	
    if ([fileManager fileExistsAtPath:pathToUserCopyOfPlist] == NO) {
        [[NSUserDefaults standardUserDefaults] setValue:@"北京" forKey:kCurrentGeoCity];
        [[NSUserDefaults standardUserDefaults] setDouble:39.904667 forKey:kCityCenterLocationLatitude];
        [[NSUserDefaults standardUserDefaults] setDouble:116.408195 forKey:kCityCenterLocationLongitude];
		[[NSUserDefaults standardUserDefaults] setObject:@"北京" forKey:@"strcity"];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"intcity"];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"intloginauto"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"intcityinit"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"intwallfirstrun"];
		[[NSUserDefaults standardUserDefaults] synchronize];
        NSString *pathToDefaultPlist;
        NSString *pathToDefaultCityPList;
        pathToDefaultPlist = [[NSBundle mainBundle] pathForResource:@"History" ofType:@"plist"];
        pathToDefaultCityPList = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
        
        if ([fileManager copyItemAtPath:pathToDefaultPlist toPath:pathToUserCopyOfPlist error:&error] == NO) {
            NSAssert1(0, @"Failed to copy data with error message '%@'.", [error localizedDescription]);
        }

        if ([fileManager copyItemAtPath:pathToDefaultCityPList toPath:pathToUserCityPList error:&error] == NO) {
            NSAssert1(0, @"Failed to copy data with error message '%@'.", [error localizedDescription]);
        }
    }
    else
    {
        //NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
        //[ShareData sharedInstance].sHistoryArray = historyArray;
    }
	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [[NSUserDefaults standardUserDefaults] setObject:[ShareData sharedInstance].sStrCity forKey:@"strcity"];
    [[NSUserDefaults standardUserDefaults] setInteger:[ShareData sharedInstance].sIntCity forKey:@"intcity"];
    [[NSUserDefaults standardUserDefaults] setInteger:[ShareData sharedInstance].sIntLoginAuto forKey:@"intloginauto"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
    return YES;
}

@end
