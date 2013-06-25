//
//  PageTableItem.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailShopTableItem.h"

@implementation DetailShopTableItem
@synthesize strShopName,strShopTel,strShopAddr;

+ (id)itemWithShopName:(NSString*)strShopName shopTel:(NSString*)strShopTel shopAddr:(NSString*)strShopAddr
{
    DetailShopTableItem* item = [[[self alloc] init] autorelease];
    item.imageURL = @"bundle://shop_bg.png";
    item.strShopName = strShopName;
    int index=0;
    index = [strShopTel indexOfChar:','];
    
    if ([strShopTel indexOfChar:','] != NSNotFound) {
        NSString *strTel = [strShopTel substringToIndex:index];
        item.strShopTel = strTel;
    }
    else
    {
        item.strShopTel = strShopTel;
    }
    
    item.strShopAddr = strShopAddr;
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
    TT_RELEASE_SAFELY(strShopName);  
    TT_RELEASE_SAFELY(strShopTel);
    TT_RELEASE_SAFELY(strShopAddr);
    [super dealloc];  
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// NSCoding  

- (id)initWithCoder:(NSCoder*)decoder {  
    if (self = [super initWithCoder:decoder]) {  
        self.strShopName = [decoder decodeObjectForKey:@"strShopAddr"];  
        self.strShopTel = [decoder decodeObjectForKey:@"strShopTel"];
        self.strShopAddr = [decoder decodeObjectForKey:@"strShopAddr"];
    }  
    return self;  
}  

- (void)encodeWithCoder:(NSCoder*)encoder {  
    [super encodeWithCoder:encoder];  
    if (self.strShopName) {  
        [encoder encodeObject:self.strShopName forKey:@"strShopName"];  
    }  
    if (self.strShopTel) {  
        [encoder encodeObject:self.strShopTel forKey:@"strShopTel"];  
    }
    if (self.strShopAddr) {  
        [encoder encodeObject:self.strShopAddr forKey:@"strShopAddr"];  
    } 
}  

@end
