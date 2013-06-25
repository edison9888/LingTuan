//
//  PageTableItem.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageTableItem.h"

@implementation PageTableItem
@synthesize strProductCompany,strProductCurrentPrice,strProductCount,strProductTime,strProductArea,intItemType;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductCount time:(NSString*)strProductTime URL:(NSString*)URL
{
    PageTableItem* item = [[[self alloc] init] autorelease];
    item.text = text;
    item.imageURL = imageURL;
    item.defaultImage = defaultImage;
    item.imageStyle = imageStyle;
    item.URL = URL;
    item.strProductCompany = strProductCompany;
    item.strProductCurrentPrice = strProductCurrentPrice;
    item.strProductCount = strProductCount;
    item.strProductTime = strProductTime;
    return item;
}


+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductCount area:(NSString*)strProductArea itemType:(int)intType URL:(NSString*)URL
{
    PageTableItem* item = [[[self alloc] init] autorelease];
    item.text = text;
    item.imageURL = imageURL;
    item.defaultImage = defaultImage;
    item.imageStyle = imageStyle;
    item.URL = URL;
    item.strProductCompany = strProductCompany;
    item.strProductCurrentPrice = strProductCurrentPrice;
    item.strProductCount = strProductCount;
    item.strProductArea = strProductArea;
    item.intItemType = intType;
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
    TT_RELEASE_SAFELY(strProductCompany);  
    TT_RELEASE_SAFELY(strProductCurrentPrice);  
    TT_RELEASE_SAFELY(strProductCount);
    TT_RELEASE_SAFELY(strProductTime); 
    TT_RELEASE_SAFELY(strProductArea);
    [super dealloc];  
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// NSCoding  

- (id)initWithCoder:(NSCoder*)decoder {  
    if (self = [super initWithCoder:decoder]) {  
        self.strProductCompany = [decoder decodeObjectForKey:@"strProductCompany"];  
        self.strProductCurrentPrice = [decoder decodeObjectForKey:@"strProductCurrentPrice"];  
        self.strProductCount = [decoder decodeObjectForKey:@"strProductCount"]; 
        self.strProductTime = [decoder decodeObjectForKey:@"strProductTime"];
        self.strProductArea = [decoder decodeObjectForKey:@"strProductArea"];
    }  
    return self;  
}  

- (void)encodeWithCoder:(NSCoder*)encoder {  
    [super encodeWithCoder:encoder];  
    if (self.strProductCompany) {  
        [encoder encodeObject:self.strProductCompany forKey:@"strProductCompany"];  
    }  
    if (self.strProductCurrentPrice) {  
        [encoder encodeObject:self.strProductCurrentPrice forKey:@"strProductCurrentPrice"];  
    }  
    if (self.strProductCount) {  
        [encoder encodeObject:self.strProductCount forKey:@"strProductCount"];  
    } 
    if (self.strProductTime) {  
        [encoder encodeObject:self.strProductTime forKey:@"strProductTime"];  
    }
    if (self.strProductArea) {  
        [encoder encodeObject:self.strProductArea forKey:@"strProductArea"];  
    } 
}  

@end
