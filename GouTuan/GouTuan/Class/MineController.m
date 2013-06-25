#import "MineController.h"
#import "ShareData.h"
#import "ShareData.h"

@implementation MineController
@synthesize mBkUIImageView;
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
      self.title = NSLocalizedString(@"mine",nil);
      UIImage* image = [UIImage imageNamed:@"menu_mine.png"];
      self.tableViewStyle = UITableViewStyleGrouped;
      self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:3] autorelease];
      self.mBkUIImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
      self.tableView.backgroundView = self.mBkUIImageView;
      self.variableHeightRows = YES;
      if ([ShareData sharedInstance].sIntLoginSuccess==1) {
          self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                                     initWithTitle:NSLocalizedString(@"logout",nil) style:UIBarButtonItemStyleBordered
                                                     target:self action:@selector(openLogout)] autorelease];
          listDataSource = [TTListDataSource dataSourceWithObjects:[TTTableTextItem itemWithText:NSLocalizedString(@"myfavorite",nil)],[TTTableTextItem itemWithText:NSLocalizedString(@"mypurchase",nil)],nil];
          self.dataSource = listDataSource;
      }
      else{
//          self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
//                                                    initWithTitle:NSLocalizedString(@"login",nil) style:UIBarButtonItemStyleBordered
//                                                    target:self action:@selector(openLogin)] autorelease];
          listDataSource = [TTListDataSource dataSourceWithObjects:[TTTableButton itemWithText:NSLocalizedString(@"history",nil) URL:@"tt://page/myhistory"],[TTTableButton itemWithText:NSLocalizedString(@"login",nil) URL:@"tt://login/init"],nil];
          self.dataSource = listDataSource;
          if([ShareData sharedInstance].sIntLoginAuto)
          {
              [self requestLoginAuto];
          }
          
      }
      
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([ShareData sharedInstance].sIntLoginSuccess==1) {
        [listDataSource.items removeAllObjects];
        [listDataSource.items addObject:[TTTableTextItem itemWithText:NSLocalizedString(@"history",nil) URL:@"tt://page/myhistory"]];
        [listDataSource.items addObject:[TTTableTextItem itemWithText:NSLocalizedString(@"myfavorite",nil) URL:@"tt://page/myfav"]];
        [listDataSource.items addObject:[TTTableTextItem itemWithText:NSLocalizedString(@"mypurchase",nil) URL:@"tt://page/mypur"]];
        NSString *strName = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginname"];
        [listDataSource.items addObject:[TTTableButton  itemWithText:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"logout",nil),strName]]];
        [self.tableView reloadData];
        self.tableView.backgroundView = self.mBkUIImageView;
    }
    else
    {

    }
    [super viewDidAppear:animated];
}

- (void)openLogout
{
    
}

- (void)openLogin
{
    //TTOpenURL([NSString stringWithFormat:@"tt://login/init"]);
}

- (void)dealloc {
    [self.mBkUIImageView release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (void) requestLoginAuto
{
    NSString *strName = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginname"];
    if(strName)
    {
        if (![strName isEmptyOrWhitespace]) {
            NSString *strPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginpassword"];
            TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=login&name=%@&password=%@",strName,strPassword]
                                                        delegate: self];
            
            request.userInfo = @"requestLoginAuto";
            // TTURLImageResponse is just one of a set of response types you can use.
            // Also available are TTURLDataResponse and TTURLXMLResponse.
            request.response = [[[TTURLJSONResponse alloc] init] autorelease];
            
            [request send];
        }
    }

}

-(void)requestLogOut
{
    [ShareData sharedInstance].sIntLoginSuccess=0;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginname"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginpassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *strSession = [ShareData sharedInstance].sStrLoginSession;
    TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=logout&sessionid=%@",[ShareData sharedInstance].sStrLoginSession]
                                                delegate: self];
    request.userInfo = @"requestLogOut";
    // TTURLImageResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    
    [request send];
    
    [listDataSource.items removeAllObjects];
    listDataSource = [TTListDataSource dataSourceWithObjects:[TTTableTextItem itemWithText:NSLocalizedString(@"history",nil) URL:@"tt://page/myhistory"],
                      [TTTableButton itemWithText:NSLocalizedString(@"login",nil) URL:@"tt://login/init"],nil];
    self.dataSource = listDataSource;
    [self.tableView reloadData];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    if ([indexPath row]==3) {
        [self requestLogOut];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLRequestDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    NSString *requestUserInfo = request.userInfo;
    if ([requestUserInfo isEqualToString:@"requestLoginAuto"]) {
        TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
        TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
        NSDictionary * rootObject = response.rootObject;
        NSString *strSessionID = [rootObject objectForKey:@"sessionid"];
        NSString *strErrCode = [rootObject objectForKey:@"errcode"];
        NSInteger intErrCode = [strErrCode intValue];
        NSString *strMsg = [rootObject objectForKey:@"msg"];
        if (intErrCode==0) {
            [ShareData sharedInstance].sIntLoginSuccess = 1;
            [ShareData sharedInstance].sStrLoginSession = strSessionID;
            [[NSUserDefaults standardUserDefaults] setObject:strSessionID forKey:@"loginsession"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        else
        {
            TTAlertNoTitle(strMsg);
        }
    }
    else if([requestUserInfo isEqualToString:@"requestLogOut"])
    {
        TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
        TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
        NSDictionary * rootObject = response.rootObject;
        NSString *strErrCode = [rootObject objectForKey:@"errcode"];
        NSInteger intErrCode = [strErrCode intValue];
        NSString *strMsg = [rootObject objectForKey:@"msg"];
        if (intErrCode==0) {
            TTAlertNoTitle(strMsg);
        }
        else
        {
            TTAlertNoTitle(strMsg);
        }
    }
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    TTAlert([error localizedDescription]);
}

@end
