//
//  ShareData.h
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://blog.mugunthkumar.com)
//  More information about this template on the post http://mk.sg/89
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import <Foundation/Foundation.h>

@interface ShareData : NSObject {
    NSInteger sIntCategoryID;
    NSInteger sIntCategoryCount;
    NSString *sStrCategoryID;
    NSString *sStrProductID;
    NSInteger sIntPage;
    NSInteger sIntCity;
    NSInteger sIntCityInit;
    NSArray *sCategoryArray;
    NSArray *sNearbyArray;
    NSMutableArray *sHistoryArray;
    NSMutableArray *sCityArray;
    NSString *sStrCity;
    NSString *sStrReverseGeoCity;
    double dbLng;
    double dbLat;
    double dbCityCenterLng;
    double dbCityCenterLat;
    NSInteger sIntLoginSuccess;
    NSString *sStrLoginName;
    NSString *sStrLoginPassword;
    NSString *sStrLoginSession;
    NSInteger sIntLoginAuto;

}
@property(nonatomic,readwrite)NSInteger sIntPage;
@property(nonatomic,readwrite)NSInteger sIntCategoryID;
@property(nonatomic,readwrite)NSInteger sIntCategoryCount;
@property(nonatomic,readwrite)NSInteger sIntCity;
@property(nonatomic,readwrite)NSInteger sIntCityInit;
@property(nonatomic,assign)NSArray *sCategoryArray;
@property(nonatomic,assign)NSArray *sNearbyArray;
@property(nonatomic,assign)NSMutableArray *sHistoryArray;
@property(nonatomic,assign)NSMutableArray *sCityArray;
@property(nonatomic,assign)NSString *sStrCity;
@property(nonatomic,assign)NSString *sStrReverseGeoCity;
@property(nonatomic,assign)NSString *sStrCategoryID;
@property(nonatomic,assign)NSString *sStrProductID;
@property(nonatomic,readwrite)double dbLng;
@property(nonatomic,readwrite)double dbLat;
@property(nonatomic,readwrite)double dbCityCenterLng;
@property(nonatomic,readwrite)double dbCityCenterLat;
@property(nonatomic,readwrite)NSInteger sIntLoginSuccess;
@property(nonatomic,retain)NSString *sStrLoginName;
@property(nonatomic,retain)NSString *sStrLoginPassword;
@property(nonatomic,retain)NSString *sStrLoginSession;
@property(nonatomic,readwrite)NSInteger sIntLoginAuto;
+ (ShareData*) sharedInstance;

-(NSString*)formatTime:(NSString*)strTime;

@end
