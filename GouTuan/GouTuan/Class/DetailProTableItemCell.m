//
//  PageTableItemCell.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailProTableItemCell.h"
#import "DetailProTableItem.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageHeight = 100;
static const CGFloat kDefaultImageWidth = 100;
static const CGFloat kHPadding = 8;  
static const CGFloat kVPadding = 15; 
static const CGFloat kTextHeight = 20;

@implementation DetailProTableItemCell
@synthesize     productSoldcountLabel,productDiscountLabel,productCurrentPriceLabel,productOriginPriceLabel,productTimeLabel,productAreaLabel,visitButton;


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
    DetailProTableItem* imageItem = object;
    
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
        
        productTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        //[self.contentView addSubview:productTimeLabel];
        self.productTimeLabel.font = TTSTYLEVAR(tableTitleFont);
        self.productTimeLabel.textColor = TTSTYLEVAR(textColor);
        self.productTimeLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productTimeLabel.backgroundColor = [UIColor clearColor];
        
        productCurrentPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productCurrentPriceLabel];
        self.productCurrentPriceLabel.font = [UIFont boldSystemFontOfSize:20];
        self.productCurrentPriceLabel.textColor = [UIColor colorWithRed:(220)/255.0f green:(42)/255.0f blue:(144)/255.0f alpha:1];
        self.productCurrentPriceLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.productCurrentPriceLabel.backgroundColor = [UIColor clearColor];
        
        visitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:visitButton];
        //visitButton.backgroundColor = [UIColor clearColor];
        [visitButton setBackgroundImage:[UIImage imageNamed:@"visit_up.png"] forState:UIControlStateNormal];
        [visitButton setBackgroundImage:[UIImage imageNamed:@"visit_down.png"] forState:UIControlStateHighlighted]; 
        [visitButton addTarget:self action:@selector(gotoPurButton) forControlEvents:UIControlEventTouchUpInside];
        
        productOriginPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:productOriginPriceLabel];
        self.productOriginPriceLabel.font = [UIFont boldSystemFontOfSize:14];
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
        

    }  
    return self;  
} 

- (void)dealloc {  
    TT_RELEASE_SAFELY(productTimeLabel); 

    TT_RELEASE_SAFELY(productCurrentPriceLabel);
    //TT_RELEASE_SAFELY(visitButton);
    TT_RELEASE_SAFELY(productOriginPriceLabel);
    TT_RELEASE_SAFELY(productDiscountLabel);
    TT_RELEASE_SAFELY(productSoldcountLabel);
    
    TT_RELEASE_SAFELY(productAreaLabel);
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
    self.imageView2.frame = CGRectMake(self.imageView2.frame.origin.x, self.imageView2.frame.origin.y+kKeySpacing, self.imageView2.frame.size.width*0.8, self.imageView2.frame.size.height*0.8);
    //self.imageView2.frame = CGRectOffset(self.imageView2.frame,-5,10);
    //[self.detailTextLabel sizeToFit];  
    //self.detailTextLabel.top = kKeySpacing;  
    
    //self.textLabel.height = self.detailTextLabel.height;  
    
    //productCompanyLabel.frame = CGRectMake(kVPadding-10, kVPadding-12, kDefaultImageWidth, kTextHeight);
    //productTimeLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom , kDefaultImageWidth-10, kTextHeight);
    productCurrentPriceLabel.frame = CGRectMake(self.imageView2.right+kHPadding, self.textLabel.top+kHPadding, kDefaultImageWidth, kTextHeight);
    visitButton.frame = CGRectMake(self.imageView2.right+kHPadding, self.productCurrentPriceLabel.bottom , kDefaultImageWidth+34, kVPadding*2);
    productOriginPriceLabel.frame = CGRectMake(self.imageView2.right+kHPadding, self.productCurrentPriceLabel.bottom+kVPadding*2, kDefaultImageWidth+50, kTextHeight);
    productDiscountLabel.frame = CGRectMake(self.imageView2.right+kHPadding, self.productOriginPriceLabel.bottom , kDefaultImageWidth+50, kTextHeight);
    productSoldcountLabel.frame = CGRectMake(self.imageView2.right+kHPadding, self.productDiscountLabel.bottom , kDefaultImageWidth+50, kTextHeight);
   
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  

- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
        
        DetailProTableItem* item = object;  
        
        
        _imageView2.style = item.imageStyle;
        _imageView2.defaultImage = item.defaultImage;
        _imageView2.urlPath = item.imageURL;
        
        
        self.textLabel.font = [[self class] fontForImageItem:item];
        
        if ([_item isKindOfClass:[TTTableRightImageItem class]]) {
            self.textLabel.textAlignment = UITextAlignmentCenter;
            self.accessoryType = UITableViewCellAccessoryNone;
            
        } else {
            self.textLabel.backgroundColor = [UIColor clearColor];
            self.textLabel.textAlignment = UITextAlignmentLeft;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        self.accessoryType = UITableViewCellAccessoryNone;
        productTimeLabel.text = item.strProductTime;
        productTimeLabel.textAlignment = UITextAlignmentLeft;
        
        float fPrice = [item.strProductCurrentPrice floatValue];
        productCurrentPriceLabel.text = [NSString stringWithFormat:@"￥%.1f",fPrice];
        productCurrentPriceLabel.textAlignment = UITextAlignmentCenter;
        
        NSString *strOriginPrice = [NSString stringWithFormat:@"原价： ￥%@",item.strProductOriginPrice];
        productOriginPriceLabel.text = strOriginPrice;
        productCurrentPriceLabel.textAlignment = UITextAlignmentLeft;
        
        
        float fDiscount = [item.strProductDiscount floatValue];
        /*
        if (fDiscount<1) {
            fDiscount = fDiscount*10;
        }
         */
        NSString *strDiscount = [NSString stringWithFormat:@"折扣： %.2f折",fDiscount];
        productDiscountLabel.text = strDiscount;
        productDiscountLabel.textAlignment = UITextAlignmentLeft;
        
        NSString *strSoldcount = [NSString stringWithFormat:@"售出： %@件",item.strProductSoldcount];
        productSoldcountLabel.text = strSoldcount;
        productSoldcountLabel.textAlignment = UITextAlignmentLeft;
    }  
}  

@end
