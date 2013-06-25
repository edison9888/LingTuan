//
//  PageTableItem.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WallTableItem.h"

@implementation WallTableItem
@synthesize mStrProductIDLeft,mStrProductIDRight,mStrProductImageLeft,mStrProductImageRight,mStrLatLeft,mStrLngLeft,mStrLatRight,mStrLngRight;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle productIDLeft:(NSString*)strProductIDLeft productIDRight:(NSString*)strProductIDRight productImageLeft:(NSString*)strProductImageLeft productImageRight:(NSString*)strProductImageRight latLeft:(NSString*)strLatLeft lngLeft:(NSString*)strLngLeft
{
    WallTableItem* item = [[[self alloc] init] autorelease];
    item.text = text;
    item.imageURL = imageURL;
    item.defaultImage = defaultImage;
    item.imageStyle = imageStyle;
    item.mStrProductIDLeft = strProductIDLeft;    
    item.mStrProductIDRight = strProductIDRight; 
    item.mStrProductImageLeft = strProductImageLeft;
    item.mStrProductImageRight = strProductImageRight;
    item.mStrLatLeft = strLatLeft;
    item.mStrLngLeft = strLngLeft;
    return item;
}


+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductCount area:(NSString*)strProductArea URL:(NSString*)URL
{
    WallTableItem* item = [[[self alloc] init] autorelease];
    item.text = text;
    item.imageURL = imageURL;
    item.defaultImage = defaultImage;
    item.imageStyle = imageStyle;
    item.URL = URL;
    return item; 
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {  
    TT_RELEASE_SAFELY(mStrProductIDLeft);  
    TT_RELEASE_SAFELY(mStrProductIDRight);  
    TT_RELEASE_SAFELY(mStrProductImageLeft);
    TT_RELEASE_SAFELY(mStrProductImageRight); 
    [super dealloc];  
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// NSCoding  

- (id)initWithCoder:(NSCoder*)decoder {  
    if (self = [super initWithCoder:decoder]) {  
        self.mStrProductIDLeft = [decoder decodeObjectForKey:@"mStrProductIDLeft"];    
        self.mStrProductIDRight = [decoder decodeObjectForKey:@"mStrProductIDRight"]; 
        self.mStrProductImageLeft = [decoder decodeObjectForKey:@"mStrProductImageLeft"];
        self.mStrProductImageRight = [decoder decodeObjectForKey:@"mStrProductImageRight"];
    }  
    return self;  
}  

- (void)encodeWithCoder:(NSCoder*)encoder {  
    [super encodeWithCoder:encoder];  
    if (self.mStrProductIDLeft) {  
        [encoder encodeObject:self.mStrProductIDLeft forKey:@"mStrProductIDLeft"];  
    }  
    if (self.mStrProductIDRight) {  
        [encoder encodeObject:self.mStrProductIDRight forKey:@"mStrProductIDRight"];  
    }  
    if (self.mStrProductImageLeft) {  
        [encoder encodeObject:self.mStrProductImageLeft forKey:@"mStrProductImageLeft"];  
    } 
    if (self.mStrProductImageRight) {  
        [encoder encodeObject:self.mStrProductImageRight forKey:@"mStrProductImageRight"];  
    }
}  

@end
