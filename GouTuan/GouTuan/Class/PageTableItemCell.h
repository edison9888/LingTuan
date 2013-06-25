//
//  PageTableItemCell.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface PageTableItemCell : TTTableImageItemCell
{
    UILabel*      productCompanyLabel;
    UILabel*      productTimeLabel;
    UILabel*      productCountLabel;
    UILabel*      productPriceLabel;
    UILabel*      productAreaLabel;
    
}
@property (nonatomic, readonly, retain) UILabel*      productCompanyLabel;
@property (nonatomic, readonly, retain) UILabel*      productTimeLabel;
@property (nonatomic, readonly, retain) UILabel*      productCountLabel;
@property (nonatomic, readonly, retain) UILabel*      productPriceLabel;
@property (nonatomic, readonly, retain) UILabel*      productAreaLabel;
@end
