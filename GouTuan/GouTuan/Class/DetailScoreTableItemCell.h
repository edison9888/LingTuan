//
//  PageTableItemCell.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailScoreTableItemCell : TTTableImageItemCell
{
    UILabel*      shopNameLabel;
    UILabel*      shopTelLabel;
    UILabel*      shopAddrLabel;
    UIButton*     telButton;
    UIButton*     mapButton;
    NSMutableArray*      scoreImageArray;
}
@property (nonatomic, readonly, retain) UILabel*      shopNameLabel;
@property (nonatomic, readonly, retain) UILabel*      shopTelLabel;
@property (nonatomic, readonly, retain) UILabel*      shopAddrLabel;
@property (nonatomic, readonly, retain) UIButton*      telButton;
@property (nonatomic, readonly, retain) UIButton*      mapButton;
@property (nonatomic, retain) NSMutableArray*      scoreImageArray;
@end
