//
//  PageListDataSource.h
//  GouTuan
//
//  Created by  on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class PageListModel;
@interface PageListDataSource : TTListDataSource
{
    PageListModel *_myModel;
}

@property (nonatomic,readonly) NSArray *pageList;

-(id)initWithPageList:(NSArray *)list;

@end
