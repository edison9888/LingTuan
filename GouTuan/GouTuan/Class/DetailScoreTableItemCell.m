//
//  PageTableItemCell.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailScoreTableItemCell.h"
#import "DetailScoreTableItem.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageHeight = 64;
static const CGFloat kDefaultImageWidth = 120;
static const CGFloat kScoreImageWidth = 32;
static const CGFloat kDefaultButtonWidth = 75;
static const CGFloat kDefaultButtonHeight = 25;
static const CGFloat kHPadding = 8;  
static const CGFloat kVPadding = 15; 
static const CGFloat kTextHeight = 20;

@implementation DetailScoreTableItemCell
@synthesize     shopNameLabel,shopTelLabel,shopAddrLabel,telButton,mapButton,scoreImageArray;


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIFont*)fontForImageItem:(id)imageItem {
    if ([imageItem isKindOfClass:[TTTableRightImageItem class]]) {
        return TTSTYLEVAR(tableSmallFont);
        
    } else {
        return TTSTYLEVAR(tableSmallFont);
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public
    
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {  
    DetailScoreTableItem* imageItem = object;
    
    UIImage* image = imageItem.imageURL
    ? [[TTURLCache sharedCache] imageForURL:imageItem.imageURL] : nil;
    if (!image) {
        image = imageItem.defaultImage;
    }
    
    CGFloat imageHeight, imageWidth;
    TTImageStyle* style = [imageItem.imageStyle firstStyleOfClass:[TTImageStyle class]];
    if (style && !CGSizeEqualToSize(style.size, CGSizeZero)) {
        imageWidth = style.size.width + kKeySpacing;
        imageHeight = style.size.height;
        
    } else {
        imageWidth = image
        ? image.size.width + kKeySpacing
        : (imageItem.imageURL ? kDefaultImageHeight + kKeySpacing : 0);
        imageHeight = image
        ? image.size.height
        : (imageItem.imageURL ? kDefaultImageHeight : 0);
    }
    
    CGFloat maxWidth = tableView.width - (imageWidth + kTableCellHPadding*2 + kTableCellMargin*2);
    
    CGSize textSize = [imageItem.text sizeWithFont:[self fontForImageItem:imageItem]
                                 constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     lineBreakMode:UILineBreakModeTailTruncation];
    
    CGFloat contentHeight = textSize.height > imageHeight ? textSize.height : imageHeight;
    //return contentHeight + kTableCellVPadding*2;
    return 64;
}


///////////////////////////////////////////////////////////////////////////////////////////////////  

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {  
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {  
        _item = nil;  

        self.textLabel.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item_bg.png"]] autorelease];
        self.scoreImageArray = [NSMutableArray arrayWithCapacity:5];
        for (int i=0; i<5; i++) {
            UIImageView *scoreImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_03.png"]] autorelease];
            [self.contentView addSubview:scoreImageView];
            [self.scoreImageArray addObject:scoreImageView];
        }
        
    }  
    return self;  
} 

- (void)dealloc {
    [self.scoreImageArray removeAllObjects];
    [self.scoreImageArray release];
    TT_RELEASE_SAFELY(shopNameLabel); 
    TT_RELEASE_SAFELY(shopTelLabel);
    TT_RELEASE_SAFELY(shopAddrLabel);
    [super dealloc];  
}

- (void)gotoPurButton {
    TTOpenURL(@"tt://detail/gotopurchase");
}

///////////////////////////////////////////////////////////////////////////////////////////////////  
// UIView  

- (void)layoutSubviews {  
    [super layoutSubviews];  
    
    self.textLabel.frame = CGRectOffset(self.textLabel.frame,-5,-15);
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width+10, self.textLabel.frame.size.height);
    //CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    self.imageView2.frame = CGRectMake(self.imageView2.frame.origin.x, self.imageView2.frame.origin.y, self.imageView2.frame.size.width, self.imageView2.frame.size.height);
    
    for (int i=0; i<5; i++) {
        UIImageView *scoreImageView = [scoreImageArray objectAtIndex:i];
        scoreImageView.frame = CGRectMake(kDefaultImageWidth+i*(kScoreImageWidth+kHPadding), kVPadding , kScoreImageWidth, kScoreImageWidth);
    }
    //self.imageView2.frame = CGRectOffset(self.imageView2.frame,-5,10);
    //[self.detailTextLabel sizeToFit];  
    //self.detailTextLabel.top = kKeySpacing;  
    
    //self.textLabel.height = self.detailTextLabel.height;  
    
    //productCompanyLabel.frame = CGRectMake(kVPadding-10, kVPadding-12, kDefaultImageWidth, kTextHeight);
    //productTimeLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom , kDefaultImageWidth-10, kTextHeight);
//    shopNameLabel.frame = CGRectMake(self.imageView2.left+kHPadding, self.imageView2.top+kHPadding, kDefaultImageWidth*3, kTextHeight);
//    shopTelLabel.frame = CGRectMake(self.shopNameLabel.left, self.shopNameLabel.bottom+kHPadding , kDefaultImageWidth*2.1, kTextHeight);
//    telButton.frame =  CGRectMake(self.shopTelLabel.right, self.shopTelLabel.top , kDefaultButtonWidth, kDefaultButtonHeight);
//    shopAddrLabel.frame = CGRectMake(self.shopNameLabel.left, self.shopTelLabel.bottom, kDefaultImageWidth*2.1, kTextHeight*2);
//    mapButton.frame =  CGRectMake(self.shopAddrLabel.right, self.shopAddrLabel.top+kHPadding, kDefaultButtonWidth, kDefaultButtonHeight);
   
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  

- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
        
        DetailScoreTableItem* item = object;  
        
        _imageView2.style = item.imageStyle;
        _imageView2.defaultImage = item.defaultImage;
        _imageView2.urlPath = item.imageURL;
        
        
        self.textLabel.font = [[self class] fontForImageItem:item];
        
//        if ([_item isKindOfClass:[TTTableRightImageItem class]]) {
//            self.textLabel.textAlignment = UITextAlignmentCenter;
//            self.accessoryType = UITableViewCellAccessoryNone;
//            
//        } else {
//            self.textLabel.backgroundColor = [UIColor clearColor];
//            self.textLabel.textAlignment = UITextAlignmentLeft;
//            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
        
        self.accessoryType = UITableViewCellAccessoryNone;
        float intScore = [item.strScore floatValue];
        for (int i=0; i<5; i++) {
            if ((intScore-i)>=0.5) {
                UIImageView *scoreImageView = [scoreImageArray objectAtIndex:i];
                [scoreImageView setImage:[UIImage imageNamed:@"star_01.png"]];
            }
        }
    }  
}  

@end
