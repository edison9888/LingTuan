//
//  PageDataSource.m
//  GouTuan
//
//  Created by  on 8/2/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "DetailDataSource.h"
#import "DetailProTableItem.h"
#import "DetailProTableItemCell.h"
#import "DetailBtnTableItem.h"
#import "DetailBtnTableItemCell.h"
#import "DetailShopTableItem.h"
#import "DetailShopTableItemCell.h"
#import "DetailScoreTableItem.h"
#import "DetailScoreTableItemCell.h"
#import "DetailListModel.h"
#import "ShareData.h"
#import "PageTableItem.h"
#import "PageTableItemCell.h"
@implementation DetailDataSource

+(DetailDataSource*)detailDataSource
{
    DetailDataSource* dataSource =  [[[DetailDataSource alloc] initWithItems:
										[NSMutableArray arrayWithObjects:nil]] autorelease];
	return dataSource;
}

+(DetailDataSource*)pageDataSourceWithLocation
{
    DetailDataSource* dataSource =  [[[DetailDataSource alloc] initWithLocation] autorelease];
	return dataSource;
}

+(DetailDataSource*)pageDataSourceWithMyFav
{
    DetailDataSource* dataSource =  [[[DetailDataSource alloc] initWithMyFav] autorelease];
	return dataSource;
}

+(DetailDataSource*)pageDataSourceWithMyPurchase
{
    DetailDataSource* dataSource =  [[[DetailDataSource alloc] initWithMyPurchase] autorelease];
	return dataSource;
}

+(DetailDataSource*)pageDataSourceWithHistory
{
    DetailDataSource* dataSource =  [[[DetailDataSource alloc] initWithHistory] autorelease];
	return dataSource;
}

+(DetailDataSource*)pageDataSourceWithSearch:(NSString*)strSearchKey
{
    DetailDataSource* dataSource =  [[[DetailDataSource alloc] initWithSearch:strSearchKey] autorelease];
	return dataSource;
}

- (id)initWithItems:(NSArray*)items {
	self = [self init];
    if (self) {
        _myModel = [[DetailListModel alloc] initWithDetail];
    }
    
    return self;
}

- (id)initWithLocation{
	self = [self init];
    if (self) {
        _myModel = [[DetailListModel alloc] initWithLocation];
    }
    
    return self;
}

- (id)initWithMyFav{
	self = [self init];
    if (self) {
        _myModel = [[DetailListModel alloc] initWithMyFav];
    }
    
    return self;
}

- (id)initWithMyPurchase{
	self = [self init];
    if (self) {
        _myModel = [[DetailListModel alloc] initWithMyPurchase];
    }
    
    return self;
}

- (id)initWithHistory{
	self = [self init];
    if (self) {
        _myModel = [[DetailListModel alloc] initWithHistory];
    }
    
    return self;
}

- (id)initWithSearch:(NSString*)strSearchData{
	self = [self init];
    if (self) {
        _myModel = [[DetailListModel alloc] initWithSearch:strSearchData];
    }
    
    return self;
}
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc {
    //TT_RELEASE_SAFELY(_myModel);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSArray *)pageList { return _myModel.pageList; }

- (id<TTModel>)model { return _myModel; }

- (void)tableViewDidLoadModel:(UITableView*)tableView {

    
    NSDictionary * productDic = [_myModel.pageList objectAtIndex:0];
    
    NSString *productID = [productDic objectForKey:@"ProductID"];
    NSString *productImage = [productDic objectForKey:@"ProductImage"];
    NSString *productScore = [productDic objectForKey:@"ProductSiteScore"];
    NSString *productArea = [productDic objectForKey:@"ProductArea"];
    NSString *productCompany = [productDic objectForKey:@"ProductCompany"];
    NSString *productCompanyIcon = [productDic objectForKey:@"ProductCompanyIcon"];
    NSString *productPrice = [productDic objectForKey:@"ProductPrice"];
    NSString *productDiscount = [productDic objectForKey:@"ProductDiscount"];
    NSString *productDescription = [productDic objectForKey:@"ProductDescription"];
    NSString *productUrl = [productDic objectForKey:@"ProductUrl"];
    [[NSUserDefaults standardUserDefaults] setObject:productDescription forKey:@"productdescription"];
    [[NSUserDefaults standardUserDefaults] setObject:productUrl forKey:@"producturl"];
    [[NSUserDefaults standardUserDefaults] setObject:productID forKey:@"productid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSNumber *productEffectivePeriod = [productDic objectForKey:@"ProductEffectivePeriod"];
    int intTimer = [productEffectivePeriod intValue];
    NSString *productSoldCount = [productDic objectForKey:@"ProductSoldCount"];
    NSString *productCommentCount = [productDic objectForKey:@"ProductCommentCount"];
    NSString *productDetail = [productDic objectForKey:@"ProductDetail"];
    NSString *productNotes = [productDic objectForKey:@"ProductNotes"];
    //NSString *strTime = [[ShareData sharedInstance] formatTime:[NSString stringWithFormat:@"%d",productEffectivePeriod]];
    NSString *strTime = [[ShareData sharedInstance] formatTime:[NSString stringWithFormat:@"%d",intTimer]];
    [[NSUserDefaults standardUserDefaults] setValue:productEffectivePeriod forKey:kDetailLeftTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UILabel *timeAniLable = [tableView.tableHeaderView.subviews objectAtIndex:1];
    timeAniLable.text = strTime;
    //TTOpenURL(@"tt://detail/leftTime");
    NSDictionary *shopDic = [productDic objectForKey:@"ProductShopInfo"];
    NSString *strShopLat = [shopDic objectForKey:@"lat"];
    mStrShopLat = [strShopLat copy];
    NSString *strShopLng = [shopDic objectForKey:@"lng"];
    mStrShopLng = [strShopLng copy];
    NSString *strShopAddr = [shopDic objectForKey:@"addr"];
    mStrShopAddr = [strShopAddr copy];
    if (mStrShopLat&&mStrShopLng) {
        if ([mStrShopLat floatValue]>0||[mStrShopLng floatValue]>0) {
            //[self.navigationItem.rightBarButtonItem setEnabled:YES];
            [[NSUserDefaults standardUserDefaults] setValue:mStrShopLat forKey:kShopLocationLatitude];
            [[NSUserDefaults standardUserDefaults] setValue:mStrShopLng forKey:kShopLocationLongitude];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    }
    else
    {
        //[self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    NSString *strShopTel = [shopDic objectForKey:@"tel"];
    NSString *strShopName = [shopDic objectForKey:@"name"];
    mStrShopName = [strShopName copy];
    
    
    [self.items addObject:[TTTableTextItem itemWithText:productDescription]];
    [self.items addObject:[DetailProTableItem itemWithText:productDescription imageURL:productImage
                                              defaultImage:TTIMAGE(@"bundle://default_product_detail.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount soldCount:productSoldCount URL:nil]];
    [self.items addObject:[DetailBtnTableItem initWithCommentCount:productCommentCount]];
    
    /*
    NSMutableArray *shopArray = [NSMutableArray array];
    if (![strShopName isEmptyOrWhitespace]) {
        [self.items addObject:[TTTableCaptionItem itemWithText:strShopName caption:NSLocalizedString(@"shopname",nil)]];
    }
    
    if (![strShopAddr isEmptyOrWhitespace]) {
        [self.items addObject:[TTTableCaptionItem itemWithText:strShopAddr caption:NSLocalizedString(@"shopaddr",nil)]];
    }
    
    if (![strShopTel isEmptyOrWhitespace]) {
        [self.items addObject:[TTTableCaptionItem itemWithText:strShopTel caption:NSLocalizedString(@"shoptel",nil) URL:[NSString stringWithFormat:@"tel:%@",strShopTel]]];
    }
    */
    if (strShopName) {
        if (![strShopName isEmptyOrWhitespace]) {
                [self.items addObject:[DetailShopTableItem itemWithShopName:strShopName shopTel:strShopTel shopAddr:strShopAddr]];
        }
    }

    [self.items addObject:[DetailScoreTableItem itemWithCompanyIcon:productCompanyIcon score:productScore]];
    NSMutableArray *addArray = [NSMutableArray array];
    if (productNotes) {
        if (![productNotes isEmptyOrWhitespace]) {
            [self.items addObject:[TTTableSubtextItem itemWithText:NSLocalizedString(@"productnotes",nil) caption:productNotes]];
        }
    }
    
    if (productDetail) {
        if (![productDetail isEmptyOrWhitespace]) {
            [self.items addObject:[TTTableSubtextItem itemWithText:NSLocalizedString(@"productdetail",nil) caption:productDetail]];
        }
    }
    

    [super tableViewDidLoadModel:tableView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
    
	if ([object isKindOfClass:[DetailProTableItem class]]) { 
		return [DetailProTableItemCell class]; 		
	}
    else if ([object isKindOfClass:[DetailBtnTableItem class]]) { 
		return [DetailBtnTableItemCell class]; 		
	}
    else if ([object isKindOfClass:[DetailShopTableItem class]]) { 
		return [DetailShopTableItemCell class]; 		
	}
    else if ([object isKindOfClass:[DetailScoreTableItem class]]) { 
		return [DetailScoreTableItemCell class]; 		
	}
    else if ([object isKindOfClass:[PageTableItem class]]) { 
		return [PageTableItemCell class]; 		
	}
    else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}

@end
