//
//  PageListModel.m
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "TodayListModel.h"
#import "ShareData.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation TodayListModel
@synthesize todayList;

-(id)initWithToday{
	if(self=[self init]) {
        category=1;
    }
    return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(todayList);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    NSString *strUrl = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=cateInfo2&cityid=%d",[ShareData sharedInstance].sIntCity];
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
    NSArray * rootObject = response.rootObject;
    self.todayList = rootObject;
    //[self.pageList addObjectsFromArray:rootObject];
    [self invalidate:YES];
    [super requestDidFinishLoad:request];
}

- (void)request:(TTURLRequest *)request didFailLoadWithError:(NSError *)error {
	NSLog(@"Fail: %@",error);
    TTAlert([[error userInfo] valueForKey:@"fault"]);
    [super request:request didFailLoadWithError:error];
}


@end
