//
//  ShareData.m
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://blog.mugunthkumar.com)
//  More information about this template on the post http://mk.sg/89	
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import "ShareData.h"

static ShareData *_instance;
@implementation ShareData
@synthesize sIntPage,sIntCategoryID,sIntCategoryCount,sIntCity,sIntCityInit,sCategoryArray,sNearbyArray,sHistoryArray,sCityArray,sStrCity,sStrReverseGeoCity,sStrCategoryID,sStrProductID,dbLng,dbLat,dbCityCenterLng,dbCityCenterLat,sIntLoginSuccess,sStrLoginName,sStrLoginPassword,sStrLoginSession,sIntLoginAuto;
#pragma mark -
#pragma mark Singleton Methods

+ (ShareData*)sharedInstance
{
	@synchronized(self) {
		
        if (_instance == nil) {
			
            _instance = [[self alloc] init];
            // Allocate/initialize any member variables of the singleton class here
            // example
			//_instance.member = @"";
        }
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone

{	
    @synchronized(self) {
		
        if (_instance == nil) {
			
            _instance = [super allocWithZone:zone];			
            return _instance;  // assignment and return on first allocation
        }
    }
	
    return nil; //on subsequent allocation attempts return nil	
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

- (id)retain
{	
    return self;	
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
    return;
}

- (id)autorelease
{
    return self;	
}

#pragma mark -
#pragma mark Custom Methods

// Add your custom methods here
-(NSString*)formatTime:(NSString*)strTime
{
    int intAllTimess = [strTime intValue];
    intAllTimess = intAllTimess-4*60;
    int intLeftHour = 0;
    int intLeftHour1= 0;
    int intDay = intAllTimess/(24*60*60);
    NSString *strDay = [NSString stringWithFormat:@"%d",intDay];
    if (intDay>0) {
        intLeftHour = (intAllTimess%(24*60*60));
        intLeftHour1 = intAllTimess- intDay*24*60*60;
    }
    else
    {
        intLeftHour = intAllTimess;
    }
    int intHour = (intLeftHour/(60*60));
    int intLeftMinutes = 0;
    NSString *strHours = [NSString stringWithFormat:@"%d",(intLeftHour/(60*60))];
    if (intHour>0) {
        intLeftMinutes = (intLeftHour%(60*60));
    }
    else
    {
        intLeftMinutes = intLeftHour;
    }
    int intMinutes = (intLeftMinutes/(60));
    NSString *strMinutes = [NSString stringWithFormat:@"%d",intMinutes];
    if (intDay>0) {
        return [NSString stringWithFormat:@"%@%@%@%@%@%@",strDay,NSLocalizedString(@"day",nil),strHours,NSLocalizedString(@"hours",nil),strMinutes,NSLocalizedString(@"minutes",nil)];
    }
    else
    {
        if (intHour>0) {
            return [NSString stringWithFormat:@"%@%@%@%@",strHours,NSLocalizedString(@"hours",nil),strMinutes,NSLocalizedString(@"minutes",nil)];
        }
        else
        {
            return [NSString stringWithFormat:@"%@%@",strMinutes,NSLocalizedString(@"minutes",nil)];
        }
    }

}

@end
