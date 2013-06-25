//
//  sectionDataSource.m
//  Groupon
//
//  Created by  on 11-9-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginSectionDataSource.h"
#import "LoginBtnTableItem.h"
#import "LoginBtnTableItemCell.h"
#import "ShareData.h"

@implementation LoginSectionDataSource

+(LoginSectionDataSource*)initLoginDataSource
{
    LoginSectionDataSource * dataSource = [[LoginSectionDataSource alloc] initWithItems:[NSMutableArray arrayWithObjects:nil] sections:[NSMutableArray arrayWithObjects:nil]];
	return dataSource;
}

- (id)initWithItems:(NSArray*)items sections:(NSArray*)sections {
	self = [self init];
    if (self) {
        _items    = [items mutableCopy];
        _sections = [sections mutableCopy];
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc {
    //TT_RELEASE_SAFELY(_myModel);
	[super dealloc];
}
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    
    
    [super tableViewDidLoadModel:tableView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
    

    if ([object isKindOfClass:[LoginBtnTableItem class]]) { 
		return [LoginBtnTableItemCell class]; 		
	}
    else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}
@end
