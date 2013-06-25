//
//  PageTableItem.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailBtnTableItem.h"

@implementation DetailBtnTableItem
@synthesize mStrCommentCount;
+ (id)initWithCommentCount:(NSString*)strCommentCount
{
    DetailBtnTableItem* item = [[[self alloc] init] autorelease];
    item.mStrCommentCount = strCommentCount;
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
    TT_RELEASE_SAFELY(mStrCommentCount);
    [super dealloc];  
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// NSCoding  

- (id)initWithCoder:(NSCoder*)decoder {  
    if (self = [super initWithCoder:decoder]) {  
    }  
    return self;  
}  

- (void)encodeWithCoder:(NSCoder*)encoder {  
    [super encodeWithCoder:encoder];  
}  

@end
