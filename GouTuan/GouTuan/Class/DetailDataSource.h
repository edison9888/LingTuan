//
//  PageDataSource.h
//  GouTuan
//
//  Created by  on 8/2/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "Three20/Three20.h"
#import "DetailListModel.h"

@interface DetailDataSource : TTListDataSource
{
    DetailListModel *_myModel;
    NSString *strProductID;
    NSString *strProductNotes;
    NSString *strProductDetail;
    NSString *mStrShopLat;
    NSString *mStrShopLng;
    NSString *mStrShopAddr;
    NSString *mStrShopName;

}
+(DetailDataSource*)detailDataSource;
+(DetailDataSource*)pageDataSourceWithLocation;
+(DetailDataSource*)pageDataSourceWithMyFav;
+(DetailDataSource*)pageDataSourceWithMyPurchase;
+(DetailDataSource*)pageDataSourceWithHistory;
+(DetailDataSource*)pageDataSourceWithSearch:(NSString*)strSearchKey;

@property (nonatomic,readonly) NSArray *pageList;
- (id)initWithLocation;
- (id)initWithMyFav;
- (id)initWithMyPurchase;
- (id)initWithHistory;
- (id)initWithSearch:(NSString*)strSearchData;
@end
