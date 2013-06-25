//
//  PageTableItemCell.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailShopTableItemCell : TTTableImageItemCell
{
    UILabel*      shopNameLabel;
    UILabel*      shopTelLabel;
    UILabel*      shopAddrLabel;
    UIButton*     telButton;
    UIButton*     mapButton;
    
}
@property (nonatomic, readonly, retain) UILabel*      shopNameLabel;
@property (nonatomic, readonly, retain) UILabel*      shopTelLabel;
@property (nonatomic, readonly, retain) UILabel*      shopAddrLabel;
@property (nonatomic, readonly, retain) UIButton*      telButton;
@property (nonatomic, readonly, retain) UIButton*      mapButton;
@end
