//
//  PageDataSource.h
//  GouTuan
//
//  Created by  on 8/2/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "Three20/Three20.h"
#import "PageListModel.h"

@interface PageDataSource : TTListDataSource
{
    TTModel *historyModel;
    PageListModel *_myModel;
    int iModel;
    NSMutableArray *dataSourceTodayPageList;
    NSMutableArray *dataSourceNearbyPageList;
}
+(PageDataSource*)pageDataSource;
+(PageDataSource*)pageDataSourceWithLocation;
+(PageDataSource*)pageDataSourceWithMyFav;
+(PageDataSource*)pageDataSourceWithMyPurchase;
+(PageDataSource*)pageDataSourceWithHistory;
+(PageDataSource*)pageDataSourceWithSearch:(NSString*)strSearchKey;

@property (nonatomic,retain) NSMutableArray *dataSourceTodayPageList;
@property (nonatomic,retain) NSMutableArray *dataSourceNearbyPageList;
- (id)initWithLocation;
- (id)initWithMyFav;
- (id)initWithMyPurchase;
- (id)initWithHistory;
- (id)initWithSearch:(NSString*)strSearchData;
@end
