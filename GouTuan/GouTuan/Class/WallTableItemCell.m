//
//  PageTableItemCell.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WallTableItemCell.h"
#import "WallTableItem.h"
#import "GTDefaultStyleSheet.h"

static const CGFloat kVKeySpacing = 5;
static const CGFloat kKeySpacing = 15;
static const CGFloat kDefaultImageHeight = 100;
static const CGFloat kDefaultImageWidth = 100;
static const CGFloat kImageHeight = 120;
static const CGFloat kImageWidth = 200;
static const CGFloat kHPadding = 8;  
static const CGFloat kVPadding = 15; 
static const CGFloat kTextHeight = 20;

@implementation WallTableItemCell
@synthesize leftButton,rightButton,leftImageView,rightImageView,mStrLat,mStrLng;

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
    WallTableItem* imageItem = object;
    
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
    return 95;
}


///////////////////////////////////////////////////////////////////////////////////////////////////  

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {  
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {  
        _item = nil;  
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        //self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item_bg.png"]] autorelease];
        //self.leftImageView = [[TTImageView alloc] init];
        //self.rightImageView = [[TTImageView alloc] init];
        
        
        
        self.leftButton = [TTButton buttonWithStyle:@"remoteButton:"];
        [self.leftButton addTarget:self action:@selector(handleLeft) forControlEvents:UIControlEventTouchUpInside];
        [self.leftButton sizeToFit];

        
        self.rightButton = [TTButton buttonWithStyle:@"remoteButton:"];
        [self.rightButton addTarget:self action:@selector(handleRight) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton sizeToFit];
        
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        

        //[self.contentView addSubview:self.leftImageView];
        //[self.contentView addSubview:self.rightImageView];

    }  
    return self;  
} 

-(void)handleLeft
{
    WallTableItem *item = (WallTableItem *)_item;
    NSString *strProducID = item.mStrProductIDLeft;
    TTOpenURL([NSString stringWithFormat:@"tt://detail/%@",strProducID]);
    
}

-(void)handleRight
{
    WallTableItem *item = (WallTableItem *)_item;
    NSString *strProducID = item.mStrProductIDRight;
    TTOpenURL([NSString stringWithFormat:@"tt://detail/%@",strProducID]);
}


- (void)dealloc {
    [self.leftImageView release];
    [self.rightImageView release];
    [super dealloc];  
}

///////////////////////////////////////////////////////////////////////////////////////////////////  
// UIView  

- (void)layoutSubviews {  
    [super layoutSubviews];  
    
    //self.textLabel.frame = CGRectOffset(self.textLabel.frame,-5,-15);
    //self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width+10, self.textLabel.frame.size.height);
    //CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    //self.imageView2.frame = CGRectOffset(self.imageView2.frame,0,0);
    //self.leftImageView.frame = CGRectMake(kVKeySpacing, kHPadding, kImageWidth*0.75, kImageHeight*0.75);
    self.leftButton.frame = CGRectMake(kVKeySpacing, self.textLabel.top+5, kImageWidth*0.75, kImageHeight*0.75);
    //self.rightImageView.frame = CGRectMake(165, self.textLabel.frame.origin.y+kKeySpacing, kImageWidth*0.75, kImageHeight*0.75);
    self.rightButton.frame = CGRectMake(161, self.textLabel.top+5, kImageWidth*0.75+4, kImageHeight*0.75);
    //self.rightButton.frame = CGRectMake(200,10,100,60);
    //[self.detailTextLabel sizeToFit];  
    //self.detailTextLabel.top = kKeySpacing;  
    
    //self.textLabel.height = self.detailTextLabel.height;  

   
}  

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (self.superview) {
        //self.leftImageView.backgroundColor = self.backgroundColor;
        //self.rightImageView.backgroundColor = self.backgroundColor;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  

- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
        
        WallTableItem* item = object;  
        
        /*
        _imageView2.style = item.imageStyle;
        _imageView2.defaultImage = item.defaultImage;
        _imageView2.urlPath = item.imageURL;
        */
        

        /*
        self.leftImageView.style = item.imageStyle;
        self.leftImageView.defaultImage = item.defaultImage;
        self.leftImageView.urlPath = item.mStrProductImageLeft;
        
        self.rightImageView.style = item.imageStyle;
        self.rightImageView.defaultImage = item.defaultImage;
        self.rightImageView.urlPath = item.mStrProductImageRight;
        */
        
        self.mStrLat = item.mStrLatLeft;
        self.mStrLng = item.mStrLngLeft;
        
        [self.leftButton setImage:item.mStrProductImageLeft forState:UIControlStateNormal];
        [self.rightButton setImage:item.mStrProductImageRight forState:UIControlStateNormal];
        
        self.textLabel.font = [[self class] fontForImageItem:item];
        
        if ([_item isKindOfClass:[TTTableRightImageItem class]]) {
            self.textLabel.textAlignment = UITextAlignmentCenter;
            self.accessoryType = UITableViewCellAccessoryNone;
            
        } else {
     
        }
        
    }  
}  

@end
