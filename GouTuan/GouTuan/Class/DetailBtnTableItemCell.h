//
//  PageTableItemCell.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface DetailBtnTableItemCell : TTTableImageItemCell
{
    UIButton*     favButton;
    UIButton*     purButton;
    UIButton*     shareButton;
    UIButton*     commentButton;
}
@property (nonatomic, readonly, retain) UIButton*     favButton;
@property (nonatomic, readonly, retain) UIButton*     purButton;
@property (nonatomic, readonly, retain) UIButton*     shareButton;
@property (nonatomic, readonly, retain) UIButton*     commentButton;
@end
