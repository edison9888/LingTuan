//
//  PageDataSource.m
//  GouTuan
//
//  Created by  on 8/2/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "WallDataSource.h"
#import "WallTableItem.h"
#import "WallTableItemCell.h"
#import "WallListModel.h"
#import "ShareData.h"

@implementation WallDataSource

+(WallDataSource*)wallDataSource
{
    WallDataSource* dataSource =  [[[WallDataSource alloc] initWithItems:
										[NSMutableArray arrayWithObjects:nil]] autorelease];
	return dataSource;
}

- (id)initWithItems:(NSArray*)items {
	self = [super init];
    if (self) {
        _myModel = [[WallListModel alloc] initWithWall];
        iModel = 1;
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc {
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

    if (_myModel.intMore==1) {
        _myModel.intMore = 0;
        if ([self.items count]!=0) {
            [self.items removeLastObject];
        }
    }
    else
    {
        [self.items removeAllObjects];
    }

    int intPageListCount = [_myModel.pageList count];
    NSLog(@"_myModel.pageList %d",intPageListCount);
    for(int i=0;i<intPageListCount;i+=2) {
        NSDictionary *productLeftDic = [_myModel.pageList objectAtIndex:i];
        NSString *productLeftID = [productLeftDic objectForKey:@"ProductID"];
        NSString *productLeftImage = [productLeftDic objectForKey:@"ProductImage"];
        NSDictionary *shopDic = [productLeftDic objectForKey:@"ProductShopInfo"];
        NSString * lngtitude = [shopDic objectForKey:@"lng"];
        NSString * lattitude = [shopDic objectForKey:@"lat"];
        
        NSDictionary *productRightDic = [_myModel.pageList objectAtIndex:i+1];
        NSString *productRightID = [productRightDic objectForKey:@"ProductID"];
        NSString *productRightImage = [productRightDic objectForKey:@"ProductImage"];
        
        [self.items addObject:[WallTableItem itemWithText:@"" imageURL:productLeftImage
                                             defaultImage:TTIMAGE(@"bundle://default_product_detail.png") imageStyle:NULL productIDLeft:productLeftID productIDRight:productRightID productImageLeft:productLeftImage  productImageRight:productRightImage latLeft:lattitude lngLeft:lngtitude
                               ]];

        
        //        [self.items addObject:[DetailProTableItem itemWithText:productDescription imageURL:productImage
        //                                                  defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount soldCount:productSoldCount URL:nil]];
    }

    if ([ShareData sharedInstance].sIntCategoryCount-[self.items count]>1&&[self.items count]>9) {
        [self.items addObject:[TTTableMoreButton itemWithText:NSLocalizedString(@"clickmore",nil)]];
    }
        
        
    
    //self.items = items;
    [super tableViewDidLoadModel:tableView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
    
	if ([object isKindOfClass:[WallTableItem class]]) { 
		return [WallTableItemCell class]; 		
	}
    else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}


@end
