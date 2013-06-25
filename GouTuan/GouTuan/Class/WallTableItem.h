//
//  PageTableItem.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface WallTableItem : TTTableImageItem
{
    NSString *mStrProductIDLeft;
    NSString *mStrProductIDRight;
    NSString *mStrProductImageLeft;
    NSString *mStrProductImageRight;
    NSString *mStrLatLeft;
    NSString *mStrLngLeft;
    NSString *mStrLatRight;
    NSString *mStrLngRight;
}

@property(nonatomic,copy) NSString* mStrProductIDLeft;  
@property(nonatomic,copy) NSString* mStrProductIDRight;  
@property(nonatomic,copy) NSString* mStrProductImageLeft; 
@property(nonatomic,copy) NSString* mStrProductImageRight; 
@property(nonatomic,copy) NSString* mStrLatLeft; 
@property(nonatomic,copy) NSString* mStrLngLeft; 
@property(nonatomic,copy) NSString* mStrLatRight; 
@property(nonatomic,copy) NSString* mStrLngRight; 
+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle productIDLeft:(NSString*)strProductIDLeft productIDRight:(NSString*)strProductIDRight productImageLeft:(NSString*)strProductImageLeft productImageRight:(NSString*)strProductImageRight latLeft:(NSString*)strLatLeft lngLeft:(NSString*)strLngLeft;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductCount area:(NSString*)strProductArea URL:(NSString*)URL;
@end
