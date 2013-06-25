//
//  PageTableItemCell.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailBtnTableItemCell.h"
#import "DetailBtnTableItem.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageHeight = 100;
static const CGFloat kDefaultImageWidth = 100;
static const CGFloat kHPadding = 8;  
static const CGFloat kVPadding = 15; 
static const CGFloat kTextHeight = 20;

@implementation DetailBtnTableItemCell
@synthesize     favButton,purButton,shareButton,commentButton;


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
    DetailBtnTableItem* imageItem = object;
    
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
    return 50;
}


///////////////////////////////////////////////////////////////////////////////////////////////////  

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {  
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {  
        _item = nil;  
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item_bg.png"]] autorelease];
        
        favButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:favButton];
        //favButton.backgroundColor = [UIColor clearColor];
        [favButton setBackgroundImage:[UIImage imageNamed:@"btn_01_up.png"] forState:UIControlStateNormal];
        [favButton setBackgroundImage:[UIImage imageNamed:@"btn_01_down.png"] forState:UIControlStateHighlighted];
        [favButton setTitle:@"收藏" forState:UIControlStateNormal];
        [favButton setTitleColor:[UIColor colorWithRed:(100)/255.0f green:(100)/255.0f blue:(100)/255.0f alpha:1] forState:UIControlStateNormal];
        [favButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [favButton addTarget:self action:@selector(favButton) forControlEvents:UIControlEventTouchUpInside];
        
        purButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:purButton];
        //purButton.backgroundColor = [UIColor clearColor];
        [purButton setBackgroundImage:[UIImage imageNamed:@"btn_02_up.png"] forState:UIControlStateNormal];
        [purButton setBackgroundImage:[UIImage imageNamed:@"btn_02_down.png"] forState:UIControlStateHighlighted];
        [purButton setTitle:@"登记" forState:UIControlStateNormal];
        [purButton setTitleColor:[UIColor colorWithRed:(100)/255.0f green:(100)/255.0f blue:(100)/255.0f alpha:1] forState:UIControlStateNormal];
        [purButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [purButton addTarget:self action:@selector(purButton) forControlEvents:UIControlEventTouchUpInside];
        
        shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:shareButton];
        //smsButton.backgroundColor = [UIColor clearColor];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"btn_03_up.png"] forState:UIControlStateNormal];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"btn_03_down.png"] forState:UIControlStateHighlighted];
        [shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [shareButton setTitleColor:[UIColor colorWithRed:(100)/255.0f green:(100)/255.0f blue:(100)/255.0f alpha:1] forState:UIControlStateNormal];
        [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [shareButton addTarget:self action:@selector(shareButton) forControlEvents:UIControlEventTouchUpInside];
        
        commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:commentButton];
        //emailButton.backgroundColor = [UIColor clearColor];
        [commentButton setBackgroundImage:[UIImage imageNamed:@"btn_04_up.png"] forState:UIControlStateNormal];
        [commentButton setBackgroundImage:[UIImage imageNamed:@"btn_04_down.png"] forState:UIControlStateHighlighted];
        [commentButton setTitle:@"评论" forState:UIControlStateNormal];
        [commentButton setTitleColor:[UIColor colorWithRed:(100)/255.0f green:(100)/255.0f blue:(100)/255.0f alpha:1] forState:UIControlStateNormal];
        [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [commentButton addTarget:self action:@selector(commentButton) forControlEvents:UIControlEventTouchUpInside];

    }  
    return self;  
} 

- (void)dealloc {  
    [super dealloc];  
}

- (void)gotoPurButton {
    TTOpenURL(@"tt://detail/gotopurchase");
}

- (void)favButton {
    TTOpenURL(@"tt://detail/addtomyfav");
    return;
}

- (void)purButton {
    TTOpenURL(@"tt://detail/addtomypurchase");
    return;
}

- (void)shareButton {
    TTOpenURL(@"tt://detail/openShareAction");
    return;
}

- (void)commentButton {
    //TTOpenURL(@"tt://detail/showcomment");
    NSString *strProductID = [[NSUserDefaults standardUserDefaults] stringForKey:@"productid"];
    TTOpenURL([NSString stringWithFormat:@"tt://comment/%@",strProductID]);
    return;
}
///////////////////////////////////////////////////////////////////////////////////////////////////  
// UIView  

- (void)layoutSubviews {  
    [super layoutSubviews];  
    
    self.textLabel.frame = CGRectOffset(self.textLabel.frame,-5,-15);
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width+10, self.textLabel.frame.size.height);
    favButton.frame = CGRectMake(kHPadding, kVPadding/2, 75, 31);
    purButton.frame = CGRectMake(kHPadding+75, kVPadding/2, 75, 31);
    shareButton.frame = CGRectMake(kHPadding+150, kVPadding/2, 75, 31);
    commentButton.frame = CGRectMake(kHPadding+225, kVPadding/2, 75, 31);
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  

- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
        
        DetailBtnTableItem* item = object;  
        
        /*
        _imageView2.style = item.imageStyle;
        _imageView2.defaultImage = item.defaultImage;
        _imageView2.urlPath = item.imageURL;
        */
        
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
        if (item.mStrCommentCount) {
        }
        else
        {
            item.mStrCommentCount=@"";
        }
        NSString *strCommentCount = [NSString stringWithFormat:@"评论%@",item.mStrCommentCount];
        [commentButton setTitle:strCommentCount forState:UIControlStateNormal];
        self.accessoryType = UITableViewCellAccessoryNone;

    }  
}  

@end
