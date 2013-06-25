//
//  PageTableItem.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailScoreTableItem.h"

@implementation DetailScoreTableItem
@synthesize strScore;

+ (id)itemWithCompanyIcon:(NSString*)strCompanyIcon score:(NSString*)strScore
{
    DetailScoreTableItem* item = [[[self alloc] init] autorelease];
    item.imageURL = strCompanyIcon;
    item.imageStyle = TTSTYLE(rounded);
    item.defaultImage = TTIMAGE(@"bundle://default_product.png");
    item.strScore = strScore;
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
    TT_RELEASE_SAFELY(strScore);  
    [super dealloc];  
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// NSCoding  

- (id)initWithCoder:(NSCoder*)decoder {  
    if (self = [super initWithCoder:decoder]) {  
        self.strScore = [decoder decodeObjectForKey:@"strScore"];  
    }  
    return self;  
}  

- (void)encodeWithCoder:(NSCoder*)encoder {  
    [super encodeWithCoder:encoder];  
    if (self.strScore) {  
        [encoder encodeObject:self.strScore forKey:@"strScore"];  
    }
}  

@end
