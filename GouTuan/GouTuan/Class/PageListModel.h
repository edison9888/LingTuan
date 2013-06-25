//
//  PageListModel.h
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 DGMB. All rights reserved.
//

@interface PageListModel : TTURLRequestModel
{
    NSArray *pageList;
    NSUInteger page;
    NSUInteger intUrl;
    NSString *strSearchModel;
    int intMore;
}

@property (nonatomic,retain) NSArray *pageList;
@property (nonatomic,readwrite)int intMore;
@property (nonatomic,readwrite)NSUInteger page;
-(id)initWithPage;
-(id)initWithLocation;
-(id)initWithMyFav;
-(id)initWithMyPurchase;
-(id)initWithHistory;
-(id)initWithSearch:(NSString*)strSearch;
@end
