//
//  PageTableItem.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailProTableItem : TTTableImageItem
{
    NSString *strProductCompany;
    NSString *strProductCurrentPrice;
    NSString *strProductOriginPrice;
    NSString *strProductDiscount;
    NSString *strProductSoldcount;
    NSString *strProductTime;
    NSString *strProductArea;
}

@property(nonatomic,copy) NSString* strProductCompany;  
@property(nonatomic,copy) NSString* strProductCurrentPrice;
@property(nonatomic,copy) NSString* strProductOriginPrice; 
@property(nonatomic,copy) NSString* strProductDiscount;
@property(nonatomic,copy) NSString* strProductSoldcount; 
@property(nonatomic,copy) NSString* strProductTime; 
@property(nonatomic,copy) NSString* strProductArea; 

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductCount time:(NSString*)strProductTime URL:(NSString*)URL;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductDiscount soldCount:(NSString*)strProductSoldcount URL:(NSString*)URL;
@end
