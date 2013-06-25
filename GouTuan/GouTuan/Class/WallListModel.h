//
//  WallListModel.h
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

@interface WallListModel : TTURLRequestModel
{
    NSArray *pageList;
    NSUInteger page;
    NSUInteger intWallFirstRun;
    NSString *strSearchModel;
    NSUInteger intMore;
}

@property (nonatomic,retain) NSArray *pageList;
@property (nonatomic,readwrite)NSUInteger intMore;
@property (nonatomic,readwrite)NSUInteger page;
@property (nonatomic,readwrite)NSUInteger intWallFirstRun;
-(id)initWithWall;
@end
