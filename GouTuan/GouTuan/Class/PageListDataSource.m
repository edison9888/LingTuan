//
//  PageListDataSource.m
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageListDataSource.h"
#import "PageListModel.h"

@implementation PageListDataSource


- (NSArray *)pageList { return _myModel.pageList; }

- (id<TTModel>)model { return _myModel; }

-(id)initWithPageList:(NSArray *)list {
	if(self=[self init]) {
        _myModel = [[PageListModel alloc] initWithPageList:list];
    }
    return self;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray *items = [NSMutableArray array];
	for(NSString *word in _myModel.pageList) {
        NSString *URL = [NSString stringWithFormat:@"tt://words/%@",[word stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [items addObject:[TTTableTextItem itemWithText:word URL:URL]];
    }
    [items addObject:[TTTableTextItem itemWithText:@"Click to more"]];
    self.items = items;
    [super tableViewDidLoadModel:tableView];
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_myModel);
    [super dealloc];
}

@end
