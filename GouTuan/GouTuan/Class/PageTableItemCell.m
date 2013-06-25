//
//  PageTableItemCell.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageTableItemCell.h"
#import "PageTableItem.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageHeight = 100;
static const CGFloat kDefaultImageWidth = 100;
static const CGFloat kHPadding = 8;  
static const CGFloat kVPadding = 15; 
static const CGFloat kTextHeight = 20;

@implementation PageTableItemCell
@synthesize     productCompanyLabel,productCountLabel,productPriceLabel,productTimeLabel,productAreaLabel;


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
    PageTableItem* imageItem = object;
    
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
    return 90;
}


///////////////////////////////////////////////////////////////////////////////////////////////////  

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {  
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {  
        _item = nil;  
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item_bg.png"]] autorelease];
        
        productCompanyLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productCompanyLabel];  
        self.productCompanyLabel.font = TTSTYLEVAR(tableFont);
        self.productCompanyLabel.textColor = TTSTYLEVAR(messageFieldTextColor);
        self.productCompanyLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productCompanyLabel.backgroundColor = [UIColor clearColor];
        
        productTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        //[self.contentView addSubview:productTimeLabel];
        self.productTimeLabel.font = TTSTYLEVAR(tableTitleFont);
        self.productTimeLabel.textColor = TTSTYLEVAR(textColor);
        self.productTimeLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productTimeLabel.backgroundColor = [UIColor clearColor];
        
        
        productCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productCountLabel];
        self.productCountLabel.font = [UIFont boldSystemFontOfSize:14];
        self.productCountLabel.textColor = [UIColor colorWithRed:(248)/255.0f green:(152)/255.0f blue:(30)/255.0f alpha:1];
        self.productCountLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productCountLabel.backgroundColor = [UIColor clearColor];
        
        productPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productPriceLabel];
        self.productPriceLabel.font = [UIFont boldSystemFontOfSize:20];;
        self.productPriceLabel.textColor = [UIColor colorWithRed:(220)/255.0f green:(42)/255.0f blue:(144)/255.0f alpha:1];
        self.productPriceLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productPriceLabel.backgroundColor = [UIColor clearColor];
        
        productAreaLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productAreaLabel];
        self.productAreaLabel.font = [UIFont boldSystemFontOfSize:14];
        self.productAreaLabel.textColor = [UIColor colorWithRed:(157)/255.0f green:(157)/255.0f blue:(157)/255.0f alpha:1];
        self.productAreaLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productAreaLabel.backgroundColor = [UIColor clearColor];
    }  
    return self;  
} 

- (void)dealloc {  
    TT_RELEASE_SAFELY(productCompanyLabel); 
    TT_RELEASE_SAFELY(productTimeLabel); 
    TT_RELEASE_SAFELY(productCountLabel);  
    TT_RELEASE_SAFELY(productPriceLabel);
    TT_RELEASE_SAFELY(productAreaLabel);
    [super dealloc];  
}

///////////////////////////////////////////////////////////////////////////////////////////////////  
// UIView  

- (void)layoutSubviews {  
    [super layoutSubviews];  
    

    //CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    PageTableItem *item = (PageTableItem *)_item;

    self.textLabel.frame = CGRectOffset(self.textLabel.frame,-5,-15);
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width+10, self.textLabel.frame.size.height);
    self.imageView2.frame = CGRectOffset(self.imageView2.frame,-5,10);
    

    //[self.detailTextLabel sizeToFit];  
    //self.detailTextLabel.top = kKeySpacing;  
    
    //self.textLabel.height = self.detailTextLabel.height;  
    
    productCompanyLabel.frame = CGRectMake(kVPadding-10, kVPadding-12, kDefaultImageWidth, kTextHeight);
    //productTimeLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom , kDefaultImageWidth-10, kTextHeight);
    productPriceLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom , kDefaultImageWidth-20, kTextHeight);
    productCountLabel.frame = CGRectMake(self.productPriceLabel.right-5, self.textLabel.bottom , kDefaultImageWidth/2, kTextHeight);
    productAreaLabel.frame = CGRectMake(self.productCountLabel.right-5, self.textLabel.bottom , kDefaultImageWidth, kTextHeight);
   
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  

- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
        
        PageTableItem* item = object;  
        
        /*
        _imageView2.style = item.imageStyle;
        _imageView2.defaultImage = item.defaultImage;
        _imageView2.urlPath = item.imageURL;
        */
        
        self.textLabel.font = [[self class] fontForImageItem:item];
        
        if ([_item isKindOfClass:[TTTableRightImageItem class]]) {
            self.textLabel.textAlignment = UITextAlignmentCenter;
            self.accessoryType = UITableViewCellAccessoryNone;
            
        } else {
     
        }
        
        
        productCompanyLabel.text = item.strProductCompany;
        productCompanyLabel.textAlignment = UITextAlignmentCenter;
        
        productTimeLabel.text = item.strProductTime;
        productTimeLabel.textAlignment = UITextAlignmentLeft;
        
        int iPrice = [item.strProductCurrentPrice intValue];
        float fDecimal = [item.strProductCurrentPrice floatValue]-iPrice;
        if (fDecimal>0.5) {
            productPriceLabel.text = [NSString stringWithFormat:@"￥%.1f",[item.strProductCurrentPrice floatValue]];
        }
        else
        {
            productPriceLabel.text = [NSString stringWithFormat:@"￥%d",iPrice];
        }
        
        productPriceLabel.textAlignment = UITextAlignmentLeft;
        
        
        float fDiscount = [item.strProductCount floatValue];
        /*
        if (fDiscount<1) {
            fDiscount = fDiscount*10;
        }
         */
        
        productCountLabel.text = [NSString stringWithFormat:@"%.2f折",fDiscount];
        productCountLabel.textAlignment = UITextAlignmentLeft;
        
        productAreaLabel.text = item.strProductArea;
        productAreaLabel.textAlignment = UITextAlignmentLeft;
    }  
}  

@end
