//
//  PageDataSource.h
//  GouTuan
//
//  Created by  on 8/2/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "Three20/Three20.h"
#import "TodayListModel.h"

@interface TodayDataSource : TTListDataSource
{
    TodayListModel *_myModel;
}
+(TodayDataSource*)todayDataSource;
@property (nonatomic,readonly) NSArray *todayList;
@end
