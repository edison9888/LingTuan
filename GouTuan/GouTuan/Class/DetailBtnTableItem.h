//
//  PageTableItem.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailBtnTableItem : TTTableImageItem
{
    NSString * mStrCommentCount;
}

+ (id)initWithCommentCount:(NSString*)strCommentCount;
@property(nonatomic,copy) NSString * mStrCommentCount;
@end
