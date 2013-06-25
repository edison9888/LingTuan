//
//  PageTableItem.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailShopTableItem : TTTableImageItem
{
    NSString *strShopName;
    NSString *strShopTel;
    NSString *strShopAddr;
}

@property(nonatomic,copy) NSString* strShopName;  
@property(nonatomic,copy) NSString* strShopTel;
@property(nonatomic,copy) NSString* strShopAddr; 

+ (id)itemWithShopName:(NSString*)strShopName shopTel:(NSString*)strShopTel shopAddr:(NSString*)strShopAddr;
@end
