//
//  PageListModel.m
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "DetailListModel.h"
#import "ShareData.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation DetailListModel
@synthesize pageList;

-(id)initWithDetail{
	if(self=[self init]) {
        page=1;
        intUrl = 0;
    }
    return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(pageList);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    
    if (more)
        page++;
    NSString *strUrl;
    if (intUrl==0) {
        strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=productInfo&pid=%@",[ShareData sharedInstance].sStrProductID];
    }
    TTURLRequest* request = [TTURLRequest requestWithURL:strUrl delegate: self];
    
    // TTURLJSONResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse，TTURLImageResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    //[request setCachePolicy:cachePolicy];
    request.cachePolicy = TTURLRequestCachePolicyNetwork;
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
        //[ShareData sharedInstance].sNearbyArray = rootObject;
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
    TTAlert([[error userInfo] valueForKey:@"fault"]);
    [super request:request didFailLoadWithError:error];
}


@end
