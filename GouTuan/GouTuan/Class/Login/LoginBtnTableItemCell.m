//
//  PageTableItemCell.m
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginBtnTableItemCell.h"
#import "LoginBtnTableItem.h"

static const CGFloat kKeySpacing = 12;
static const CGFloat kDefaultImageHeight = 100;
static const CGFloat kDefaultImageWidth = 100;
static const CGFloat kHPadding = 8;  
static const CGFloat kVPadding = 15; 
static const CGFloat kTextHeight = 20;

@implementation LoginBtnTableItemCell
@synthesize m_pBackButton,m_pLoginButton;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public
    
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {  
    return 50;
}


///////////////////////////////////////////////////////////////////////////////////////////////////  

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {  
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {  
        _item = nil;  
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[[UIImageView alloc] initWithImage:nil] autorelease];
        
        //self.m_pBackButton = [TTButton buttonWithStyle:@"remoteButton:"];
        
        /*
        self.m_pBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.m_pBackButton setFrame:CGRectMake(1, 3, 143, 45)];
        [self.m_pBackButton setBackgroundImage:[UIImage imageNamed:@"backbt_normal.png"] forState:UIControlStateNormal];
        [self.m_pBackButton setBackgroundImage:[UIImage imageNamed:@"backbt_selected.png"] forState:UIControlStateHighlighted];
        [self.m_pBackButton addTarget:self action:@selector(handleBack) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.m_pBackButton];
        */
        self.m_pBackButton = [TTButton buttonWithStyle:@"backButton:"];
        [self.m_pBackButton addTarget:self action:@selector(handleBack) forControlEvents:UIControlEventTouchUpInside];
        [self.m_pBackButton sizeToFit];
        [self.contentView addSubview:self.m_pBackButton];
        
        self.m_pLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.m_pLoginButton setFrame:CGRectMake(155, 3, 143, 45)];
        [self.m_pLoginButton setBackgroundImage:[UIImage imageNamed:@"loginbt_normal.png"] forState:UIControlStateNormal];
        [self.m_pLoginButton setBackgroundImage:[UIImage imageNamed:@"loginbt_selected.png"] forState:UIControlStateHighlighted];
        [self.m_pLoginButton addTarget:self action:@selector(handleLogin) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:self.m_pLoginButton];

    }  
    return self;  
} 

- (void)dealloc {  
    [super dealloc];  
    [self.m_pBackButton release];
    [self.m_pLoginButton release];
}

- (void)handleBack {
    TTOpenURL(@"tt://login/handleback");
}

- (void)handleLogin {
    TTOpenURL(@"tt://login/handlelogin");
}

///////////////////////////////////////////////////////////////////////////////////////////////////  
// UIView  

- (void)layoutSubviews {  
    [super layoutSubviews];  
    
    self.textLabel.frame = CGRectOffset(self.textLabel.frame,-5,-15);
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width+10, self.textLabel.frame.size.height);
    [self.m_pBackButton setFrame:CGRectMake(1, 3, 143, 45)];
}  


///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  

- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
        
        LoginBtnTableItem* item = object;  
        [self.m_pBackButton setImage:@"backbt_normal.png" forState:UIControlStateNormal];
        [self.m_pBackButton setImage:@"backbt_selected.png" forState:UIControlStateHighlighted];
        self.accessoryType = UITableViewCellAccessoryNone;

    }  
}  

@end
