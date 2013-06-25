//
//  PageTableItem.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailProTableItem.h"

@implementation DetailProTableItem
@synthesize strProductCompany,strProductCurrentPrice,strProductOriginPrice,strProductDiscount,strProductSoldcount,strProductTime,strProductArea;

+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductDiscount time:(NSString*)strProductTime URL:(NSString*)URL
{
    DetailProTableItem* item = [[[self alloc] init] autorelease];
    item.text = strProductCurrentPrice;
    item.imageURL = imageURL;
    item.defaultImage = defaultImage;
    item.imageStyle = imageStyle;
    //item.URL = URL;
    item.strProductCompany = strProductCompany;
    item.strProductCurrentPrice = strProductCurrentPrice;
    item.strProductDiscount = strProductDiscount;
    item.strProductTime = strProductTime;
    return item;
}


+ (id)itemWithText:(NSString*)text imageURL:(NSString*)imageURL
      defaultImage:(UIImage*)defaultImage imageStyle:(TTStyle*)imageStyle company:(NSString*)strProductCompany price:(NSString*)strProductCurrentPrice discount:(NSString*)strProductDiscount soldCount:(NSString*)strProductSoldcount URL:(NSString*)URL
{
    DetailProTableItem* item = [[[self alloc] init] autorelease];
    item.text = nil;
    item.imageURL = imageURL;
    item.defaultImage = defaultImage;
    item.imageStyle = imageStyle;
    //item.URL = URL;
    item.strProductCompany = strProductCompany;
    item.strProductCurrentPrice = strProductCurrentPrice;
    float fDiscount = [strProductDiscount floatValue];
    if (fDiscount<1) {
        fDiscount = fDiscount*10;
    }
    float fOriginPrice = [strProductCurrentPrice floatValue]*10/fDiscount;
    item.strProductOriginPrice = [NSString stringWithFormat:@"%.0f",fOriginPrice];
    item.strProductDiscount = strProductDiscount;
    item.strProductSoldcount = strProductSoldcount;
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
    TT_RELEASE_SAFELY(strProductOriginPrice);
    TT_RELEASE_SAFELY(strProductDiscount);
    TT_RELEASE_SAFELY(strProductSoldcount);
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
        self.strProductOriginPrice = [decoder decodeObjectForKey:@"strProductOriginPrice"];
        self.strProductDiscount = [decoder decodeObjectForKey:@"strProductDiscount"];
        self.strProductSoldcount = [decoder decodeObjectForKey:@"strProductSoldcount"];
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
    if (self.strProductOriginPrice) {  
        [encoder encodeObject:self.strProductOriginPrice forKey:@"strProductOriginPrice"];  
    }
    if (self.strProductDiscount) {  
        [encoder encodeObject:self.strProductDiscount forKey:@"strProductDiscount"];  
    }
    if (self.strProductSoldcount) {  
        [encoder encodeObject:self.strProductSoldcount forKey:@"strProductSoldcount"];  
    } 
    if (self.strProductTime) {  
        [encoder encodeObject:self.strProductTime forKey:@"strProductTime"];  
    }
    if (self.strProductArea) {  
        [encoder encodeObject:self.strProductArea forKey:@"strProductArea"];  
    } 
}  

@end
