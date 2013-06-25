//
//  PageTableItem.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface PageTableItem : TTTableImageItem
{
    NSString *strProductCompany;
    NSString *strProductCurrentPrice;
    NSString *strProductCount;
    NSString *strProductTime;
    NSString *strProductArea;
    NSInteger intItemType;
}

@property(nonatomic,copy) NSString* strProductCompany;  
@property(nonatomic,copy) NSString* strProductCurrentPrice;  
@property(nonatomic,copy) NSString* strProductCount; 
@property(nonatomic,copy) NSString* strProductTime; 
@property(nonatomic,copy) NSString* strProductArea; 
@property(nonatomic,readwrite) NSInteger intItemType; 
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductCount time:(NSString*)strProductTime URL:(NSString*)URL;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductCount area:(NSString*)strProductArea itemType:(int)intType URL:(NSString*)URL;
@end
