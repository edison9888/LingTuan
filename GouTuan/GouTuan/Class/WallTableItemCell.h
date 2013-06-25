//
//  PageTableItemCell.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface WallTableItemCell : TTTableLinkedItemCell
{
    TTButton *leftButton;
    TTButton *rightButton;
    TTImageView *leftImageView;
    TTImageView *rightImageView;
    NSString* mStrLat;
    NSString* mStrLng;
}
@property (nonatomic, retain) TTButton *leftButton;
@property (nonatomic, retain) TTButton *rightButton;
@property (nonatomic, retain) TTImageView* leftImageView;
@property (nonatomic, retain) TTImageView* rightImageView;
@property (nonatomic, retain) NSString* mStrLat;
@property (nonatomic, retain) NSString* mStrLng;
@end
