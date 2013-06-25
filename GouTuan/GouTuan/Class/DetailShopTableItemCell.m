//
//  PageTableItemCell.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailShopTableItemCell.h"
#import "DetailShopTableItem.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageHeight = 100;
static const CGFloat kDefaultImageWidth = 100;
static const CGFloat kDefaultButtonWidth = 75;
static const CGFloat kDefaultButtonHeight = 25;
static const CGFloat kHPadding = 8;  
static const CGFloat kVPadding = 15; 
static const CGFloat kTextHeight = 20;

@implementation DetailShopTableItemCell
@synthesize     shopNameLabel,shopTelLabel,shopAddrLabel,telButton,mapButton;


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
    DetailShopTableItem* imageItem = object;
    
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
    return 120;
}


///////////////////////////////////////////////////////////////////////////////////////////////////  

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {  
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {  
        _item = nil;  
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item_bg.png"]] autorelease];
        
        shopNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:shopNameLabel];
        self.shopNameLabel.font = TTSTYLEVAR(tableFont);
        self.shopNameLabel.textColor = TTSTYLEVAR(textColor);
        self.shopNameLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.shopNameLabel.backgroundColor = [UIColor clearColor];
        
        shopTelLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:shopTelLabel];
        self.shopTelLabel.font = TTSTYLEVAR(tableFont);
        self.shopTelLabel.textColor = TTSTYLEVAR(textColor);
        self.shopTelLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.shopTelLabel.backgroundColor = [UIColor clearColor];
        
        shopAddrLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:shopAddrLabel];
        self.shopAddrLabel.font = TTSTYLEVAR(tableFont);
        self.shopAddrLabel.textColor = TTSTYLEVAR(textColor);
        self.shopAddrLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.shopAddrLabel.backgroundColor = [UIColor clearColor];
        self.shopAddrLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.shopAddrLabel.numberOfLines = 2;
        
        telButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:telButton];
        [telButton setBackgroundImage:[UIImage imageNamed:@"btn_telmap_up.png"] forState:UIControlStateNormal];
        [telButton setBackgroundImage:[UIImage imageNamed:@"btn_telmap_down.png"] forState:UIControlStateHighlighted]; 
        [telButton addTarget:self action:@selector(telButton) forControlEvents:UIControlEventTouchUpInside];
        [telButton setTitle:@"拨号" forState:UIControlStateNormal];
        telButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [telButton setTitleColor:[UIColor colorWithRed:(100)/255.0f green:(100)/255.0f blue:(100)/255.0f alpha:1] forState:UIControlStateNormal];
        [telButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:mapButton];
        [mapButton setBackgroundImage:[UIImage imageNamed:@"btn_telmap_up.png"] forState:UIControlStateNormal];
        [mapButton setBackgroundImage:[UIImage imageNamed:@"btn_telmap_down.png"] forState:UIControlStateHighlighted]; 
        [mapButton addTarget:self action:@selector(mapButton) forControlEvents:UIControlEventTouchUpInside];
        [mapButton setTitle:@"查看地图" forState:UIControlStateNormal];
        mapButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [mapButton setTitleColor:[UIColor colorWithRed:(100)/255.0f green:(100)/255.0f blue:(100)/255.0f alpha:1] forState:UIControlStateNormal];
        [mapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        //[self.contentView sendSubviewToBack:self.imageView2];
        /*
        productOriginPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productOriginPriceLabel];
        self.productOriginPriceLabel.font = [UIFont boldSystemFontOfSize:14];;
        self.productOriginPriceLabel.textColor = [UIColor colorWithRed:(202)/255.0f green:(153)/255.0f blue:(64)/255.0f alpha:1];
        self.productOriginPriceLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productOriginPriceLabel.backgroundColor = [UIColor clearColor];
        
        productDiscountLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productDiscountLabel];
        self.productDiscountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.productDiscountLabel.textColor = [UIColor colorWithRed:(248)/255.0f green:(152)/255.0f blue:(30)/255.0f alpha:1];
        self.productDiscountLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productDiscountLabel.backgroundColor = [UIColor clearColor];
        
        productSoldcountLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productSoldcountLabel];
        self.productSoldcountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.productSoldcountLabel.textColor = [UIColor colorWithRed:(248)/255.0f green:(152)/255.0f blue:(30)/255.0f alpha:1];
        self.productSoldcountLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productSoldcountLabel.backgroundColor = [UIColor clearColor];
        
        productAreaLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productAreaLabel];
        self.productAreaLabel.font = [UIFont boldSystemFontOfSize:14];
        self.productAreaLabel.textColor = [UIColor colorWithRed:(157)/255.0f green:(157)/255.0f blue:(157)/255.0f alpha:1];
        self.productAreaLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productAreaLabel.backgroundColor = [UIColor clearColor];
        */

    }  
    return self;  
} 

- (void)dealloc {  
    TT_RELEASE_SAFELY(shopNameLabel); 
    TT_RELEASE_SAFELY(shopTelLabel);
    TT_RELEASE_SAFELY(shopAddrLabel);
    
    [super dealloc];  
}

- (void)gotoPurButton {
    TTOpenURL(@"tt://detail/gotopurchase");
}

- (void)telButton {
    NSString *strTel = [shopTelLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    TTOpenURL([NSString stringWithFormat:@"tel:%@",strTel]);
}

- (void)mapButton {
    [[NSUserDefaults standardUserDefaults] setValue:shopNameLabel.text forKey:kShopName];
	[[NSUserDefaults standardUserDefaults] setValue:shopAddrLabel.text forKey:kShopAddr];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *mStrShopLat = [[NSUserDefaults standardUserDefaults] objectForKey:kShopLocationLatitude];
    NSString *mStrShopLng = [[NSUserDefaults standardUserDefaults] objectForKey:kShopLocationLongitude];
    
    TTOpenURL([NSString stringWithFormat:@"tt://map/%@/%@",[mStrShopLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[mStrShopLat stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
}
///////////////////////////////////////////////////////////////////////////////////////////////////  
// UIView  

- (void)layoutSubviews {  
    [super layoutSubviews];  
    
    self.textLabel.frame = CGRectOffset(self.textLabel.frame,-5,-15);
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width+10, self.textLabel.frame.size.height);
    //CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    self.imageView2.frame = CGRectMake(self.imageView2.frame.origin.x, self.imageView2.frame.origin.y, self.imageView2.frame.size.width, self.imageView2.frame.size.height);
    //self.imageView2.frame = CGRectOffset(self.imageView2.frame,-5,10);
    //[self.detailTextLabel sizeToFit];  
    //self.detailTextLabel.top = kKeySpacing;  
    
    //self.textLabel.height = self.detailTextLabel.height;  
    
    //productCompanyLabel.frame = CGRectMake(kVPadding-10, kVPadding-12, kDefaultImageWidth, kTextHeight);
    //productTimeLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom , kDefaultImageWidth-10, kTextHeight);
    shopNameLabel.frame = CGRectMake(self.imageView2.left+kHPadding, self.imageView2.top+kHPadding, kDefaultImageWidth*3, kTextHeight);
    shopTelLabel.frame = CGRectMake(self.shopNameLabel.left, self.shopNameLabel.bottom+kHPadding , kDefaultImageWidth*2.1, kTextHeight);
    telButton.frame =  CGRectMake(self.shopTelLabel.right, self.shopTelLabel.top , kDefaultButtonWidth, kDefaultButtonHeight);
    shopAddrLabel.frame = CGRectMake(self.shopNameLabel.left, self.shopTelLabel.bottom, kDefaultImageWidth*2.1, kTextHeight*2);
    mapButton.frame =  CGRectMake(self.shopAddrLabel.right, self.shopAddrLabel.top+kHPadding, kDefaultButtonWidth, kDefaultButtonHeight);
   
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  

- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
        
        DetailShopTableItem* item = object;  
        
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
        shopNameLabel.text = item.strShopName;
        shopNameLabel.textAlignment = UITextAlignmentLeft;
        
        
        NSString *strShopTel = [NSString stringWithFormat:@"联系电话：%@",item.strShopTel];
        shopTelLabel.text = strShopTel;
        shopTelLabel.textAlignment = UITextAlignmentLeft;
        
        NSString *strShopAddr = [NSString stringWithFormat:@"地址：%@",item.strShopAddr];
        shopAddrLabel.text = strShopAddr;
        shopAddrLabel.textAlignment = UITextAlignmentLeft;
    }  
}  

@end
