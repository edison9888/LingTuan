#import "AboutController.h"

@implementation AboutController
@synthesize mBkUIImageView;
static NSString* kStrAbout = @"引领团购时尚，领军团购导航。领团提供最专业的团购导航与团购搜索，帮助您快速找到心仪的团购产品。领团严格审核收录中国1500多家优质团购网，提供全国最全最新的团购信息。同时提供比价，点评维权等功能与服务。领团创新思维，率先提出“团需”（我想团）与“团购3.0”理念，为您领航时尚团购生活。";
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject


- (id)init {
  if (self = [super init]) {
      self.title = NSLocalizedString(@"about",nil);
      UIImage* image = [UIImage imageNamed:@"menu_about.png"];
      self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:5] autorelease];
      self.tableViewStyle = UITableViewStyleGrouped;
      self.mBkUIImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
      self.tableView.backgroundView = self.mBkUIImageView;
      self.variableHeightRows = YES;
      NSString* strVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersionShort"];
      self.dataSource = [TTListDataSource dataSourceWithObjects:[TTTableSubtextItem itemWithText:@"关于领团" caption:kStrAbout],
                         [TTTableCaptionItem itemWithText:@"www.lingtuan.com" caption:@"领团首页" URL:@"http://www.lingtuan.com"],
                         [TTTableCaptionItem itemWithText:@"http://m.lingtuan.com" caption:@"手机领团" URL:@"http://m.goutuan.net"],
                         [TTTableCaptionItem itemWithText:@"app@lingtuan.com" caption:@"意见反馈" URL:nil],
                         [TTTableSubtextItem itemWithText:@"当前版本" caption:strVersion],
                         nil];
  }
  return self;
}


- (void)dealloc {
    [self.mBkUIImageView release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
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
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    if ([indexPath row]==3) {
        [self showPicker];
    };
    
    
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
	
	[picker setSubject:@"领团意见反馈!"];
	
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"app@lingtuan.com"]; 
	//NSArray *ccRecipients = [NSArray array]; 
	//NSArray *bccRecipients = [NSArray array]; 
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	
	// Fill out the email body text
	NSString *emailBody = @"";
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
	NSString *recipients = @"mailto:app@movo.net?cc=&subject=购团意见反馈!";
	NSString *body = @"&body=";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


@end
