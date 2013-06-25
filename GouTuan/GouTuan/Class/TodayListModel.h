//
//  PageListModel.h
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

@interface TodayListModel : TTURLRequestModel
{
    NSArray *todayList;
    NSUInteger category;
}

@property (nonatomic,retain) NSArray *todayList;
-(id)initWithToday;
@end
