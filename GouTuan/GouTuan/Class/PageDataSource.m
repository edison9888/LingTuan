#import "PageDataSource.h"
#import "PageTableItem.h"
#import "PageTableItemCell.h"
#import "PageListModel.h"
#import "ShareData.h"
#import "DetailProTableItem.h"
#import "DetailProTableItemCell.h"

@implementation PageDataSource
@synthesize dataSourceTodayPageList,dataSourceNearbyPageList;

+(PageDataSource*)pageDataSource
{
    PageDataSource* dataSource =  [[[PageDataSource alloc] initWithItems:
										[NSMutableArray arrayWithObjects:nil]] autorelease];
	return dataSource;
}

+(PageDataSource*)pageDataSourceWithLocation
{
    PageDataSource* dataSource =  [[[PageDataSource alloc] initWithLocation] autorelease];
	return dataSource;
}

+(PageDataSource*)pageDataSourceWithMyFav
{
    PageDataSource* dataSource =  [[[PageDataSource alloc] initWithMyFav] autorelease];
	return dataSource;
}

+(PageDataSource*)pageDataSourceWithMyPurchase
{
    PageDataSource* dataSource =  [[[PageDataSource alloc] initWithMyPurchase] autorelease];
	return dataSource;
}

+(PageDataSource*)pageDataSourceWithHistory
{
    PageDataSource* dataSource =  [[[PageDataSource alloc] initWithHistory] autorelease];
	return dataSource;
}

+(PageDataSource*)pageDataSourceWithSearch:(NSString*)strSearchKey
{
    PageDataSource* dataSource =  [[[PageDataSource alloc] initWithSearch:strSearchKey] autorelease];
	return dataSource;
}

- (id)initWithItems:(NSArray*)items {
	self = [super init];
    if (self) {
        self.dataSourceTodayPageList = [NSMutableArray arrayWithCapacity:0];
        _myModel = [[PageListModel alloc] initWithPage];
        iModel = 1;
    }
    
    return self;
}

- (id)initWithLocation{
	self = [super init];
    if (self) {
        self.dataSourceNearbyPageList = [NSMutableArray arrayWithCapacity:0];
        _myModel = [[PageListModel alloc] initWithLocation];
        iModel = 2;
    }
    
    return self;
}

- (id)initWithMyFav{
	self = [super init];
    if (self) {
        _myModel = [[PageListModel alloc] initWithMyFav];
        iModel = 3;
    }
    
    return self;
}

- (id)initWithMyPurchase{
	self = [super init];
    if (self) {
        _myModel = [[PageListModel alloc] initWithMyPurchase];
        iModel = 4;
    }
    
    return self;
}

- (id)initWithHistory{
	self = [super init];
    if (self) {
        //_myModel = [[PageListModel alloc] initWithHistory];
        historyModel = [[TTModel alloc] init];
        iModel = 5;
    }
    
    return self;
}

- (id)initWithSearch:(NSString*)strSearchData{
	self = [super init];
    if (self) {
        _myModel = [[PageListModel alloc] initWithSearch:strSearchData];
        iModel = 6;
    }
    
    return self;
}
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc {
    [self.dataSourceTodayPageList removeAllObjects];
    [self.dataSourceTodayPageList release];
    [self.dataSourceNearbyPageList removeAllObjects];
    [self.dataSourceNearbyPageList release];
    TT_RELEASE_SAFELY(_myModel);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSArray *)pageList { return _myModel.pageList; }

- (id<TTModel>)model {
    if (iModel==5) {
        return historyModel;
    }
    else
    {
        return _myModel;
    }
     
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	//NSMutableArray *items = [NSMutableArray array];
    if(iModel == 5)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *pathToUserCopyOfPlist;
        
        pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
        
        NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:pathToUserCopyOfPlist];
        
        for (int i =0; i<[historyArray count];i++) {
            NSDictionary *productDic = [historyArray objectAtIndex:i];
            
            NSString *productID = [productDic objectForKey:@"ProductID"];
            NSString *productImage = [productDic objectForKey:@"ProductImage"];
            NSString *productSmallImage = [productDic objectForKey:@"ProductSmallImage"];
            NSString *productArea = [productDic objectForKey:@"ProductArea"];
            NSString *productCompany = [productDic objectForKey:@"ProductCompanyName"];
            NSString *productPrice = [productDic objectForKey:@"ProductCurrentPrice"];
            NSString *productDiscount = [productDic objectForKey:@"ProductDiscount"];
            NSString *productDescription = [productDic objectForKey:@"ProductDescription"];
            NSString *productEffectivePeriod = [productDic objectForKey:@"ProductEffectivePeriod"];
            NSString *productNotes = [productDic objectForKey:@"ProductNotes"];
            NSString *productDetail = [productDic objectForKey:@"ProductDetail"];
            NSString *productSoldCount = [productDic objectForKey:@"ProductSoldCount"];
            NSString *strTime = [[ShareData sharedInstance] formatTime:productEffectivePeriod];
            //        [self.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
            //                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount time:strTime URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
            //                                         ]];
            //    [selfDataSource.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
            //                                         defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
            //                           ]];
            //        [selfDataSource.items insertObject:[PageTableItem itemWithText:productDescription imageURL:productImage
            //                                                          defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
            //                                            ] atIndex:0];

            [self.items addObject:[PageTableItem itemWithText:productDescription 
                                                     imageURL:(productSmallImage?productSmallImage:productImage)
                                                 defaultImage:TTIMAGE(@"bundle://default_product.png") 
                                                   imageStyle:TTSTYLE(rounded) 
                                                      company:productCompany 
                                                        price:productPrice 
                                                     discount:productDiscount 
                                                         area:productArea 
                                                     itemType:iModel
                                                          URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
                                   ]];
            

        }
    } else {
        PageListModel *pageListModel = (PageListModel*)self.model;
        if (pageListModel.intMore == 1) {
            pageListModel.intMore = 0;
            if ([self.items count]!=0) {
                [self.items removeLastObject];
            }
        } else {
            [self.items removeAllObjects];
            if (iModel == 1) {
                [self.dataSourceTodayPageList removeAllObjects];
            } else if(iModel == 2){
                [self.dataSourceNearbyPageList removeAllObjects];
            }
        }
        
        for(id product in _myModel.pageList) {
            NSDictionary *productDic = product;
            NSString *productID = [productDic objectForKey:@"ProductID"];
            NSString *productImage = [productDic objectForKey:@"ProductImage"];
            NSString *productSmallImage = [productDic objectForKey:@"ProductSmallImage"];
            NSString *productArea = [productDic objectForKey:@"ProductArea"];
            NSString *productCompany = [productDic objectForKey:@"ProductCompanyName"];
            NSString *productPrice = [productDic objectForKey:@"ProductCurrentPrice"];
            NSString *productDiscount = [productDic objectForKey:@"ProductDiscount"];
            NSString *productDescription = [productDic objectForKey:@"ProductDescription"];
            NSString *productEffectivePeriod = [productDic objectForKey:@"ProductEffectivePeriod"];
            NSString *productNotes = [productDic objectForKey:@"ProductNotes"];
            NSString *productDetail = [productDic objectForKey:@"ProductDetail"];
            NSString *productSoldCount = [productDic objectForKey:@"ProductSoldCount"];
            NSString *strTime = [[ShareData sharedInstance] formatTime:productEffectivePeriod];
            
            //        [self.items addObject:[PageTableItem itemWithText:productDescription imageURL:productImage
            //                                                       defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount time:strTime URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
            //                                         ]];
            if (iModel == 2) {
                [self.items addObject:[PageTableItem itemWithText:productDescription 
                                                         imageURL:productSmallImage
                                                     defaultImage:TTIMAGE(@"bundle://default_product.png") 
                                                       imageStyle:TTSTYLE(rounded) 
                                                          company:productCompany 
                                                            price:productPrice 
                                                         discount:productDiscount 
                                                             area:productArea 
                                                         itemType:iModel 
                                                              URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
                                       ]];
            } else {
                [self.items addObject:[PageTableItem itemWithText:productDescription 
                                                         imageURL:productImage
                                                     defaultImage:TTIMAGE(@"bundle://default_product.png") 
                                                       imageStyle:TTSTYLE(rounded) 
                                                          company:productCompany 
                                                            price:productPrice 
                                                         discount:productDiscount 
                                                             area:productArea 
                                                         itemType:iModel 
                                                              URL:[NSString stringWithFormat:@"tt://detail/%@",productID]
                                       ]];
            }

            if (iModel==1) {
                [self.dataSourceTodayPageList addObject:productDic];
            } else if(iModel==2) {
                [self.dataSourceNearbyPageList addObject:productDic];
            }
            
            // [self.items addObject:[DetailProTableItem itemWithText:productDescription imageURL:productImage
            // defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount soldCount:productSoldCount URL:nil]];
        }
        if (iModel==2) {
            [ShareData sharedInstance].sNearbyArray = self.dataSourceNearbyPageList;
        }
        
        int intx = [ShareData sharedInstance].sIntCategoryCount;
        int inty = [self.items count];
        
        if (iModel == 5) {
        } else {
            if ([ShareData sharedInstance].sIntCategoryCount-[self.items count] > 1 && [self.items count] > 9) {
                [self.items addObject:[TTTableMoreButton itemWithText:NSLocalizedString(@"clickmore",nil)]];
            }
        }
    }
    
    //self.items = items;
    [super tableViewDidLoadModel:tableView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
    
	if ([object isKindOfClass:[PageTableItem class]]) { 
		return [PageTableItemCell class]; 		
	} else if ([object isKindOfClass:[DetailProTableItem class]]) { 
		return [DetailProTableItemCell class]; 		
	} else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}


@end
