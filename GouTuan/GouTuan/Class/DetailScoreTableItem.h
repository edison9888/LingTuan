//
//  PageTableItem.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailScoreTableItem : TTTableImageItem
{
    NSString *strScore;
}

@property(nonatomic,copy) NSString* strScore;  

+ (id)itemWithCompanyIcon:(NSString*)strCompanyIcon score:(NSString*)strScore;
@end
