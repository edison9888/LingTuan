//
//  PageListModel.m
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "PageListModel.h"
#import "ShareData.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation PageListModel
@synthesize pageList,intMore,page;

-(id)initWithPage{
	if(self=[self init]) {
        page=1;
        intUrl = 0;
        intMore = 0;
    }
    return self;
}

-(id)initWithLocation
{
    if(self=[self init]) {
        page=1;
        intUrl = 1;
        intMore = 0;
    }
    return self;
}

-(id)initWithMyFav
{
    if(self=[self init]) {
        page=1;
        intUrl = 2;
        intMore = 0;
    }
    return self; 
}

-(id)initWithMyPurchase
{
    if(self=[self init]) {
        page=1;
        intUrl = 3;
        intMore = 0;
    }
    return self;
}

-(id)initWithHistory
{
    if(self=[self init]) {
        page=1;
        intUrl = 4;
        intMore = 0;
    }
    return self;
}

-(id)initWithSearch:(NSString*)strSearch
{
    if(self=[self init]) {
        page=1;
        intUrl = 5;
        strSearchModel = strSearch;
        intMore = 0;
    }
    return self;
    
}

- (void)dealloc {
	TT_RELEASE_SAFELY(pageList);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    
    if (more)
    {
        page++;
        intMore = 1;
    }
        
    NSString *strUrl;
    if (intUrl==0) {
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=index2&cityid=%d&categoryid=%d&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].sIntCategoryID,page];
    }
    else if(intUrl==1)
    {
        [ShareData sharedInstance].sStrReverseGeoCity =[[NSUserDefaults standardUserDefaults] objectForKey:kCurrentGeoCity];
        if ([[ShareData sharedInstance].sStrCity isEqualToString:[ShareData sharedInstance].sStrReverseGeoCity]) {
            NSLog(@"PageListModel %@ equal %@",[ShareData sharedInstance].sStrCity,[ShareData sharedInstance].sStrReverseGeoCity);
            [ShareData sharedInstance].dbLat =[[NSUserDefaults standardUserDefaults] doubleForKey:kLastLocationLatitude];
            [ShareData sharedInstance].dbLng =[[NSUserDefaults standardUserDefaults] doubleForKey:kLastLocationLongitude];
            
            strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=nearProduct&cityid=%d&lng=%.6f&lat=%.6f&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].dbLng,[ShareData sharedInstance].dbLat,page];
        }
        else
        {
            NSLog(@"PageListModel %@ not equal %@",[ShareData sharedInstance].sStrCity,[ShareData sharedInstance].sStrReverseGeoCity);
            [ShareData sharedInstance].dbCityCenterLat =[[NSUserDefaults standardUserDefaults] doubleForKey:kCityCenterLocationLatitude];
            [ShareData sharedInstance].dbCityCenterLng =[[NSUserDefaults standardUserDefaults] doubleForKey:kCityCenterLocationLongitude];
            strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=nearProduct&cityid=%d&lng=%.6f&lat=%.6f&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].dbCityCenterLng,[ShareData sharedInstance].dbCityCenterLat,page];
        }
        NSLog(@"PageListModel strUrl %@",strUrl);

    }
    else if(intUrl==2)
    {
        NSString *strSessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginsession"];
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=collectList&sessionid=%@",strSessionId];
        cachePolicy = TTURLRequestCachePolicyNetwork;
    }
    else if(intUrl==3)
    {
        NSString *strSessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginsession"];
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=buyList&sessionid=%@",strSessionId];
        cachePolicy = TTURLRequestCachePolicyNetwork;
    }
    else if(intUrl==4)
    {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *pathToUserCopyOfPlist;
//        
//        pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
//        
//        NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
//        
//        self.pageList = historyArray;
//        [self didStartLoad];
//        [self invalidate:YES];
//        [self didFinishLoad];
//        
//        return;
        strUrl = @"http://www.goutuan.net/index.php?m=Iphone&";
        return;
    }
    else if(intUrl==5)
    {
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=search&keyword=%@&cityid=%d&pageid=%d",[strSearchModel stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[ShareData sharedInstance].sIntCity,page];
    }
    TTURLRequest* request = [TTURLRequest requestWithURL:strUrl delegate: self];
    
    // TTURLJSONResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse，TTURLImageResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    [request setCachePolicy:cachePolicy];
    [request setCacheExpirationAge:TT_CACHE_EXPIRATION_AGE_NEVER];
    if (intUrl==4) {
        request.userInfo = @"history";
    }
    //[request send];
    if(![request send]) [self didStartLoad];
}


- (void)requestDidFinishLoad:(TTURLRequest *)request {
    TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
    NSString *strResponseUserInfo = request.userInfo;
    if ([strResponseUserInfo isEqualToString:@"history"]) {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *pathToUserCopyOfPlist;
                
                pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
                
                NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
                //NSDictionary *selectDic = [historyArray objectAtIndex:0];
                //NSMutableArray *newArray = [NSMutableArray arrayWithObject:selectDic];
                self.pageList = historyArray;
                [self invalidate:YES];
    }
    else
    {
        TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
        if ([response.rootObject isKindOfClass:[NSArray class]]) {
            NSArray * rootObject = response.rootObject;
            self.pageList = rootObject;
            [self invalidate:YES];
        }
        else if([response.rootObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *errDic = response.rootObject;
            NSString *strError = [errDic objectForKey:@"msg"];
            TTAlert(strError);
        }
    }

    [super requestDidFinishLoad:request];
}

- (void)request:(TTURLRequest *)request didFailLoadWithError:(NSError *)error {
	NSLog(@"Fail: %@",error);

    if (intUrl == 1) {
        TTAlert(@"附近团购，网络数据获取错误");
    }
    else if(intUrl == 2)
    {
        TTAlert(@"我的收藏，网络数据获取错误");
    }
    else if(intUrl == 3)
    {
        TTAlert(@"我的购买，网络数据获取错误");
    }
    else if(intUrl == 4)
    {
        TTAlert(@"浏览历史，数据获取错误");
    }
    else if(intUrl == 5)
    {
        TTAlert(@"搜索，网络数据获取错误");
    }

    [super request:request didFailLoadWithError:error];
}


@end
