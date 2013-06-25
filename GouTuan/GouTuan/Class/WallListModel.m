//
//  WallListModel.m
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "WallListModel.h"
#import "ShareData.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation WallListModel
@synthesize pageList,intMore,intWallFirstRun,page;

-(id)initWithWall{
	if(self=[self init]) {
        page=1;
        intWallFirstRun = [[NSUserDefaults standardUserDefaults] integerForKey:@"intwallfirstrun"];;
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
    [ShareData sharedInstance].sStrReverseGeoCity =[[NSUserDefaults standardUserDefaults] objectForKey:kCurrentGeoCity];

    if (intWallFirstRun==0) {
        NSLog(@"WallListModel FirstRun");
        [ShareData sharedInstance].dbLat =[[NSUserDefaults standardUserDefaults] doubleForKey:kLastLocationLatitude];
        [ShareData sharedInstance].dbLng =[[NSUserDefaults standardUserDefaults] doubleForKey:kLastLocationLongitude];
        
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=nearProduct&cityid=%d&lng=%.6f&lat=%.6f&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].dbLng,[ShareData sharedInstance].dbLat,page];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"intwallfirstrun"];
		[[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        
        if ([[ShareData sharedInstance].sStrCity isEqualToString:[ShareData sharedInstance].sStrReverseGeoCity]) {
            NSLog(@"WallListModel isEqualToString");
            [ShareData sharedInstance].dbLat =[[NSUserDefaults standardUserDefaults] doubleForKey:kLastLocationLatitude];
            [ShareData sharedInstance].dbLng =[[NSUserDefaults standardUserDefaults] doubleForKey:kLastLocationLongitude];
            
            strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=nearProduct&cityid=%d&lng=%.6f&lat=%.6f&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].dbLng,[ShareData sharedInstance].dbLat,page];
        }
        else
        {
            NSLog(@"WallListModel not EqualToString");
            [ShareData sharedInstance].dbCityCenterLat =[[NSUserDefaults standardUserDefaults] doubleForKey:kCityCenterLocationLatitude];
            [ShareData sharedInstance].dbCityCenterLng =[[NSUserDefaults standardUserDefaults] doubleForKey:kCityCenterLocationLongitude];
            strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=nearProduct&cityid=%d&lng=%.6f&lat=%.6f&pageid=%d",[ShareData sharedInstance].sIntCity,[ShareData sharedInstance].dbCityCenterLng,[ShareData sharedInstance].dbCityCenterLat,page];
        }
        NSLog(@"WallList Model strUrl %@",strUrl);
    }

    TTURLRequest* request = [TTURLRequest requestWithURL:strUrl delegate: self];
    
    // TTURLJSONResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse，TTURLImageResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    [request setCachePolicy:cachePolicy];
    [request setCacheExpirationAge:TT_CACHE_EXPIRATION_AGE_NEVER];
    //[request send];
    if(![request send]) [self didStartLoad];
}


- (void)requestDidFinishLoad:(TTURLRequest *)request {
    TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;

    TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
    if ([response.rootObject isKindOfClass:[NSArray class]]) {
        NSArray * rootObject = response.rootObject;
        self.pageList = rootObject;
        [ShareData sharedInstance].sNearbyArray = rootObject;
        [self invalidate:YES];
    }
    else if([response.rootObject isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *errDic = response.rootObject;
        NSString *strError = [errDic objectForKey:@"msg"];
        TTAlert(strError);
    }

    [super requestDidFinishLoad:request];
}

- (void)request:(TTURLRequest *)request didFailLoadWithError:(NSError *)error {
	NSLog(@"Fail: %@",error);

    TTAlert(@"本地穿越，网络数据获取错误");
    [super request:request didFailLoadWithError:error];
}


@end
