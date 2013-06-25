//
//  PageDataSource.h
//  GouTuan
//
//  Created by  on 8/2/11.
//  Copyright 2011 DGMB. All rights reserved.
//

#import "Three20/Three20.h"
#import "WallListModel.h"

@interface WallDataSource : TTListDataSource
{
    TTModel *historyModel;
    WallListModel *_myModel;
    int iModel;
}
+(WallDataSource*)wallDataSource;

@end
