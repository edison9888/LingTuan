//
//  PageTableItemCell.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailProTableItemCell : TTTableImageItemCell
{
    UILabel*      productTimeLabel;
    UILabel*      productSoldcountLabel;
    UILabel*      productDiscountLabel;
    UILabel*      productCurrentPriceLabel;
    UILabel*      productOriginPriceLabel;
    UILabel*      productAreaLabel;
    UIButton*     visitButton;
    
}
@property (nonatomic, readonly, retain) UILabel*      productTimeLabel;
@property (nonatomic, readonly, retain) UILabel*      productSoldcountLabel;
@property (nonatomic, readonly, retain) UILabel*      productDiscountLabel;
@property (nonatomic, readonly, retain) UILabel*      productCurrentPriceLabel;
@property (nonatomic, readonly, retain) UILabel*      productOriginPriceLabel;
@property (nonatomic, readonly, retain) UILabel*      productAreaLabel;
@property (nonatomic, readonly, retain) UIButton*      visitButton;
@end
