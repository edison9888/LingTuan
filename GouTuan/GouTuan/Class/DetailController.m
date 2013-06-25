#import "DetailController.h"
#import "ShareData.h"
#import "DetailProTableItem.h"
#import "DetailProTableItemCell.h"
#import "PageTableItem.h"
#import "PageTableItemCell.h"
#import "DetailDataSource.h"

@implementation DetailController
@synthesize mStrProductDescription,timerAniLabel,mBkUIImageView;
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
-(id)initDetail:(NSString*)strProID
{
    if (self = [super init]) {
        strProductID = strProID;
        [ShareData sharedInstance].sStrProductID = strProID;
        strProductNotes = nil;
        self.title = NSLocalizedString(@"detail",nil);
        //self.title = NSLocalizedString(@"detail",nil);
        UIImage* image = [UIImage imageNamed:@"gt_images21.png"];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
        //self.tableViewStyle = UITableViewStyleGrouped;
        self.variableHeightRows = YES;
        self.mStrProductDescription = @"OK";
        self.mBkUIImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
        self.tableView.backgroundView = self.mBkUIImageView;
        //sectionedDataSource = [TTSectionedDataSource dataSourceWithObjects:nil];
        self.dataSource = [DetailDataSource detailDataSource];
        //[self requestDetailAction];
        UIImageView *timerbgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timer_item_bg.png"]] autorelease];
        UILabel *timerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 85, 32)];
        timerTextLabel.text = @"剩余时间";
        timerTextLabel.backgroundColor = [UIColor clearColor];
        timerTextLabel.textColor = [UIColor whiteColor];
        timerTextLabel.font = [UIFont boldSystemFontOfSize:14];
        
        self.timerAniLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 220, 32)];
        self.timerAniLabel.text = @"";
        self.timerAniLabel.backgroundColor = [UIColor clearColor];
        self.timerAniLabel.textColor = [UIColor whiteColor];
        self.timerAniLabel.font = [UIFont boldSystemFontOfSize:18];
        
        [timerbgView addSubview:timerTextLabel];
        [timerbgView addSubview:timerAniLabel];
        self.tableView.tableHeaderView = timerbgView;
        
        TTURLMap *map = [TTNavigator navigator].URLMap;
        [map from:@"tt://displaychoices" toViewController:self selector:@selector(displayChoices)];
        [map from:@"tt://shareWithEmail" toViewController:self selector:@selector(shareWithEmail)];
        [map from:@"tt://shareWithSMS" toViewController:self selector:@selector(shareWithSMS)];
    }
    return self;
}

-(void)handleBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:175.0/255.0 green:191.0/255.0 blue:236.0/255.0 alpha:1.0]; 
    
    //Create the custom back button
    TTButton *backButtonView = [TTButton buttonWithStyle:@"toolbarBackButton:" title:NSLocalizedString(@"back",nil)];
    [backButtonView addTarget:self action:@selector(handleBack) forControlEvents:UIControlEventTouchUpInside];
    [backButtonView sizeToFit];
    backButtonView.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release]; 
}

- (id)init {
  if (self = [super init]) {
      
  }
  return self;
}

- (void)dealloc {
    TTURLMap *map = [TTNavigator navigator].URLMap;
    [map removeURL:@"tt://displaychoices"];
    [map removeURL:@"tt://shareWithEmail"];
    [map removeURL:@"tt://shareWithSMS"];
    [self.mBkUIImageView release];
    [super dealloc];
}

- (void)openDetailMap
{
	[[NSUserDefaults standardUserDefaults] setValue:mStrShopName forKey:kShopName];
	[[NSUserDefaults standardUserDefaults] setValue:mStrShopAddr forKey:kShopAddr];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    TTOpenURL([NSString stringWithFormat:@"tt://map/%@/%@",[mStrShopLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[mStrShopLat stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
}


- (void) requestDetailAction
{
    TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=productInfo&pid=%@",strProductID]
                                                delegate: self];
    
    // TTURLImageResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    request.userInfo = @"requestDetail";
    [request send];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTURLRequestDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    NSString *requestUserInfo = request.userInfo;
    if ([requestUserInfo isEqualToString:@"addtomyfav"]) {
        TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
        TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
        NSDictionary * rootObject = response.rootObject;
        NSString *strSessionID = [rootObject objectForKey:@"sessionid"];
        NSString *strErrCode = [rootObject objectForKey:@"errcode"];
        NSInteger intErrCode = [strErrCode intValue];
        NSString *strMsg = [rootObject objectForKey:@"msg"];
        if (intErrCode==0) {
            TTAlertNoTitle(NSLocalizedString(@"addfavoritesuccess",nil));
        }
        else
        {
            TTAlertNoTitle(strMsg);
        }
    }
    else if([requestUserInfo isEqualToString:@"addtomypur"])
    {
        TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
        TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
        NSDictionary * rootObject = response.rootObject;
        NSString *strSessionID = [rootObject objectForKey:@"sessionid"];
        NSString *strErrCode = [rootObject objectForKey:@"errcode"];
        NSInteger intErrCode = [strErrCode intValue];
        NSString *strMsg = [rootObject objectForKey:@"msg"];
        if (intErrCode==0) {
            TTAlertNoTitle(NSLocalizedString(@"addpurchasesuccess",nil));
        }
        else
        {
            TTAlertNoTitle(strMsg);
        }
    }
    else if([requestUserInfo isEqualToString:@"requestDetail"])
    {
        TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
        TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
        NSArray * rootObject = response.rootObject;
        
        NSDictionary * productDic = [rootObject objectAtIndex:0];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *pathToUserCopyOfPlist;
        
        //pathToUserCopyOfPlist = [documentsDirectory stringByAppendingPathComponent:@"History.plist"];
        //[[ShareData sharedInstance].sHistoryArray addObject:productDic];
        //BOOL blWrite=[[ShareData sharedInstance].sHistoryArray writeToFile:pathToUserCopyOfPlist atomically:YES];
        
        NSString *productID = [productDic objectForKey:@"ProductID"];
        NSString *productImage = [productDic objectForKey:@"ProductImage"];
        NSString *productArea = [productDic objectForKey:@"ProductArea"];
        NSString *productCompany = [productDic objectForKey:@"ProductCompany"];
        NSString *productPrice = [productDic objectForKey:@"ProductPrice"];
        NSString *productDiscount = [productDic objectForKey:@"ProductDiscount"];
        NSString *productDescription = [productDic objectForKey:@"ProductDescription"];
        NSString *productUrl = [productDic objectForKey:@"ProductUrl"];
        [[NSUserDefaults standardUserDefaults] setObject:productDescription forKey:@"productdescription"];
        [[NSUserDefaults standardUserDefaults] setObject:productUrl forKey:@"producturl"];
        [[NSUserDefaults standardUserDefaults] setObject:productID forKey:@"productid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *productEffectivePeriod = [productDic objectForKey:@"ProductEffectivePeriod"];
        NSString *leftTimer = [[ShareData sharedInstance] formatTime:productEffectivePeriod];
        self.timerAniLabel.text = leftTimer;
        NSString *productSoldCount = [productDic objectForKey:@"ProductSoldCount"];
        NSString *productDetail = [productDic objectForKey:@"ProductDetail"];
        NSString *productNotes = [productDic objectForKey:@"ProductNotes"];
        
        NSDictionary *shopDic = [productDic objectForKey:@"ProductShopInfo"];
        NSString *strShopLat = [shopDic objectForKey:@"lat"];
        mStrShopLat = [strShopLat copy];
        NSString *strShopLng = [shopDic objectForKey:@"lng"];
        mStrShopLng = [strShopLng copy];
        NSString *strShopAddr = [shopDic objectForKey:@"addr"];
        mStrShopAddr = [strShopAddr copy];
        NSString *strShopTel = [shopDic objectForKey:@"tel"];
        NSString *strShopName = [shopDic objectForKey:@"name"];
        mStrShopName = [strShopName copy];
        
        
        listDataSource = [DetailDataSource dataSourceWithObjects:
                               [TTTableTextItem itemWithText:productDescription],
                               //[TTTableSubtitleItem itemWithText:productPrice subtitle:[NSString stringWithFormat:@"已售%@    折扣%@",productSoldCount,productDiscount] imageURL:productImage URL:nil],
                               [PageTableItem itemWithText:productDescription imageURL:productImage
                                                   defaultImage:TTIMAGE(@"bundle://default_product.png") imageStyle:TTSTYLE(rounded) company:productCompany price:productPrice discount:productDiscount area:productArea URL:nil],
                               [TTTableButton itemWithText:NSLocalizedString(@"sharewithsms",nil)],
                               [TTTableButton itemWithText:NSLocalizedString(@"sharewithemail",nil)],
                               [TTTableButton itemWithText:NSLocalizedString(@"addfavorite",nil)],
                               [TTTableButton itemWithText:NSLocalizedString(@"addpurchase",nil)],
                               [TTTableButton itemWithText:NSLocalizedString(@"nowpurchase",nil)],
                               nil];
        self.dataSource = listDataSource;
        
        
        NSMutableArray *shopArray = [NSMutableArray array];
        if (![strShopName isEmptyOrWhitespace]) {
            [shopArray addObject:[TTTableCaptionItem itemWithText:strShopName caption:NSLocalizedString(@"shopname",nil)]];
        }
        
        if (![strShopAddr isEmptyOrWhitespace]) {
            [shopArray addObject:[TTTableCaptionItem itemWithText:strShopAddr caption:NSLocalizedString(@"shopaddr",nil)]];
        }
        
        if (![strShopTel isEmptyOrWhitespace]) {
            [shopArray addObject:[TTTableCaptionItem itemWithText:strShopTel caption:NSLocalizedString(@"shoptel",nil) URL:[NSString stringWithFormat:@"tel:%@",strShopTel]]];
        }
        
        if (![strShopName isEmptyOrWhitespace]||![strShopAddr isEmptyOrWhitespace] ||![strShopTel isEmptyOrWhitespace]) {
            [listDataSource.items addObject:shopArray];
        }
        
        NSMutableArray *addArray = [NSMutableArray array];
        if (productNotes) {
            if (![productNotes isEmptyOrWhitespace]) {
                [addArray addObject:[TTTableSubtextItem itemWithText:NSLocalizedString(@"productnotes",nil) caption:productNotes]];
            }
        }
        
        if (productDetail) {
            if (![productDetail isEmptyOrWhitespace]) {
                [addArray addObject:[TTTableSubtextItem itemWithText:NSLocalizedString(@"productdetail",nil) caption:productDetail]];
            }
        }
        
        if (productNotes||productDetail) {
            if (![productNotes isEmptyOrWhitespace]||![productDetail isEmptyOrWhitespace]) {
                [listDataSource.items addObject:addArray];
            }
        }
        
        
        //self.dataSource = sectionedDataSource;
        
        //[[TTTableSubtitleItem itemWithText:productPrice subtitle:[NSString stringWithFormat:@"已售%@    折扣%@",productSoldCount,productDiscount] imageURL:productImage URL:nil],[TTTableTextItem itemWithText:@"北京市朝阳区慧中北里302号楼1单元402"],
        //[self invalidateModel];
        //[self reload];
        //[self invalidateView];
        [self.tableView reloadData];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    TTAlert([error localizedDescription]);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

/*
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    if ([indexPath section]==1) {
        if ([indexPath row]==0) {
            [self shareWithSMS];
            
        }
        else if([indexPath row]==1)
        {
            [self shareWithEmail];
        }
        else if([indexPath row]==2)
        {
            [self addtomyfav];
        }
        else if([indexPath row]==3)
        {
            [self addtomypurchase];
        }
        else if([indexPath row]==4)
        {
            [self gotopurchase];
        }
    };
    
    
}
 */

-(void)openShareAction
{
    //UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Is Anyone Injured?"
//                                                             delegate:self
//                                                    cancelButtonTitle:nil
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:nil];
    //[actionSheet addButtonWithTitle:@"Cancel"];
    //[actionSheet showInView:self.view];
    
    TTURLAction *action = [TTURLAction actionWithURLPath:@"tt://displaychoices"];
    [action setAnimated:YES];
    [action setTransition:UIViewAnimationTransitionNone];
    [action setWithDelay:NO];
    [[TTNavigator navigator] openURLAction:action];
    
//    TTActionSheetController* actionSheet = [[[TTActionSheetController alloc] initWithTitle:nil delegate:self] autorelease];
//    [actionSheet addButtonWithTitle:NSLocalizedString(@"sharewithsms",nil) URL:nil];
//    [actionSheet addButtonWithTitle:NSLocalizedString(@"sharewithemail",nil) URL:nil];
//    [actionSheet addButtonWithTitle:NSLocalizedString(@"cancel",nil) URL:nil];
    //self.view = actionSheet;
}

- (UIViewController *)displayChoices {
    TTActionSheetController *controller = [[[TTActionSheetController alloc] initWithTitle:NSLocalizedString(@"share",nil) delegate:self] autorelease];
    [controller addDestructiveButtonWithTitle:NSLocalizedString(@"sharewithsms",nil) URL:@"tt://shareWithSMS"];
    [controller addButtonWithTitle:NSLocalizedString(@"sharewithemail",nil) URL:@"tt://shareWithEmail"];
    [controller addCancelButtonWithTitle:NSLocalizedString(@"cancel",nil) URL:nil];
    
    return controller;
}

-(void)showComment
{
    TTOpenURL(@"");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// I like it
-(void)addtomyfav
{
    if ([ShareData sharedInstance].sIntLoginSuccess==1) {
        NSString *strProID = [[NSUserDefaults standardUserDefaults] objectForKey:@"productid"];
        NSString *strSessionID = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginsession"];
        TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=collect&sessionid=%@&pid=%@",strSessionID,strProID]
                                                    delegate: self];
        
        request.cachePolicy = TTURLRequestCachePolicyNetwork;
        request.response = [[[TTURLJSONResponse alloc] init] autorelease];
        request.userInfo = @"addtomyfav";
        [request send];
    }
    else
    {
        TTOpenURL([NSString stringWithFormat:@"tt://login/init"]);
    }
}

-(void)addtomypurchase
{
    if ([ShareData sharedInstance].sIntLoginSuccess==1) {
        NSString *strProID = [[NSUserDefaults standardUserDefaults] objectForKey:@"productid"];
        NSString *strSessionID = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginsession"];
        TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=buy&sessionid=%@&pid=%@",strSessionID,strProID]
                                                    delegate: self];
        
        request.cachePolicy = TTURLRequestCachePolicyNetwork;
        request.response = [[[TTURLJSONResponse alloc] init] autorelease];
        request.userInfo = @"addtomypur";
        [request send];
    }
    else
    {
        TTOpenURL([NSString stringWithFormat:@"tt://login/init"]);
    }
}

-(void)gotopurchase
{
    NSString *strProUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"producturl"];
    TTOpenURL([NSString stringWithFormat:strProUrl]);
}



///////////////////////////////////////////////////////////////////////////////////////////////////
// SMS Related
-(void)shareWithSMS
{
    Class smsClass = NSClassFromString(@"MFMessageComposeViewController");
    if (smsClass != nil)
    {
        if ([smsClass canSendText])
        {
            [self displaySMSComposerSheet];
        }
        else {
            [self launchSmsAppOnDevice];
        }
    }
    else {
        [self launchSmsAppOnDevice];
        
    }
}

-(void)launchSmsAppOnDevice
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:// "]];
    
}

#pragma mark -

#pragma mark Componse sms

-(void)displaySMSComposerSheet
{
    
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    NSString *strProDes = [[NSUserDefaults standardUserDefaults] objectForKey:@"productdescription"];
    picker.body = strProDes;
    picker.messageComposeDelegate = self;
    [self presentModalViewController:picker animated:YES];
    [picker release];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
            TTAlert(@"Unknown Error");
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Email Related
-(void)shareWithEmail
{
    [self showPicker];
}

-(void)showPicker
{
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"购团分享!"];
	
    
	// Set up recipients
	NSArray *toRecipients = [NSArray array]; 
	//NSArray *ccRecipients = [NSArray array]; 
	//NSArray *bccRecipients = [NSArray array]; 
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	
	// Fill out the email body text
    NSString *strProDes = [[NSUserDefaults standardUserDefaults] objectForKey:@"productdescription"];
	NSString *emailBody = strProDes;
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:app@movo.net?cc=&subject=购团分享!";
	NSString *body = @"&body=";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

@end
