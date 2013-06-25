//
//  PageListModel.h
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

@interface DetailListModel : TTURLRequestModel
{
    NSArray *pageList;
    NSUInteger page;
    NSUInteger intUrl;
    NSString *strSearchModel;
}

@property (nonatomic,retain) NSArray *pageList;
-(id)initWithDetail;
-(id)initWithLocation;
-(id)initWithMyFav;
-(id)initWithMyPurchase;
-(id)initWithHistory;
-(id)initWithSearch:(NSString*)strSearch;
@end
