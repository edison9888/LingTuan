//
//  PageDataSource.m
//  GouTuan
//
//  Created by  on 8/2/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "TodayDataSource.h"
#import "PageTableItem.h"
#import "PageTableItemCell.h"
#import "TodayListModel.h"
#import "ShareData.h"

@implementation TodayDataSource

+(TodayDataSource*)todayDataSource
{
    TodayDataSource* dataSource =  [[[TodayDataSource alloc] initWithItems:
										[NSMutableArray arrayWithObjects:nil]] autorelease];
	return dataSource;
}

- (id)initWithItems:(NSArray*)items {
	self = [self init];
    if (self) {
        _myModel = [[TodayListModel alloc] initWithToday];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc {
    TT_RELEASE_SAFELY(_myModel);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSArray *)pageList { return _myModel.todayList; }

- (id<TTModel>)model { return _myModel; }

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    
    if ([self.items count]!=0) {
        [self.items removeAllObjects];
    }
    
	for(id  category in _myModel.todayList) {
        NSDictionary *categoryDic = category;
        NSNumber *categoryID = [categoryDic objectForKey:@"categoryid"];
        int intCategoryID = [categoryID intValue];
        NSString *categoryName = [categoryDic objectForKey:@"categoryname"];
        if (![categoryName isKindOfClass:[NSNull class]]) {
            if (![categoryName isEmptyOrWhitespace]) {
                NSNumber *categoryNumber = [categoryDic objectForKey:@"num"];
                int intCatetoryNumber = [categoryNumber intValue];
                NSString *URL = [NSString stringWithFormat:@"tt://page/%d/%@/%d", intCategoryID,
                                 [categoryName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],intCatetoryNumber];
                
                [self.items addObject:[TTTableImageItem itemWithText:[NSString stringWithFormat:@"%@  (%@)",categoryName,categoryNumber] imageURL:[NSString stringWithFormat:@"bundle://cat_%@.png",categoryID] URL:URL]];
            }
        }

    }
    
    [super tableViewDidLoadModel:tableView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

//- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
//    
//	if ([object isKindOfClass:[PageTableItem class]]) { 
//		return [PageTableItemCell class]; 		
//	} else { 
//		return [super tableView:tableView cellClassForObject:object]; 
//	}
//}
@end
