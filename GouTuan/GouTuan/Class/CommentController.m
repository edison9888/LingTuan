#import "CommentController.h"
#import "ShareData.h"
#import "MockDataSource.h"

@implementation CommentController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
@synthesize mStrProductID,mBkUIImageView;
- (id)init:(NSString*)strProductID {
  if (self = [super init]) {
      self.title = NSLocalizedString(@"comment",nil);
      self.tableViewStyle = UITableViewStyleGrouped;
      self.variableHeightRows = YES;
      //self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
      commentDataSource = [TTSectionedDataSource dataSourceWithObjects:nil];
      self.dataSource = commentDataSource;
      self.mStrProductID = @"66829";
      self.mBkUIImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gt_images2.png"]];
      self.tableView.backgroundView = self.mBkUIImageView;
      self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem 
                                                  alloc] 
                                                 initWithTitle:NSLocalizedString(@"submitcomment",nil) style:UIBarButtonItemStylePlain 
                                                 target:self 
                                                 action:@selector(submitComment)] autorelease];
      [[TTNavigator navigator].URLMap from:@"tt://post"
                          toViewController:self selector:@selector(post:)];
  }
  return self;
}

- (void)dealloc {
    [[TTNavigator navigator].URLMap removeURL:@"tt://post"];
    [self.mBkUIImageView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [self requestAction];
    [super viewWillAppear:animated];
}

- (void)postController: (TTPostController*)postController
           didPostText: (NSString*)text
            withResult: (id)result
{
    NSString* pString = text;
    [self requestPostComment:pString];
}

- (UIViewController*)post:(NSDictionary*)query {
    TTPostController* controller = [[[TTPostController alloc] initWithNavigatorURL:nil
                                                                             query:
                                     [NSDictionary dictionaryWithObjectsAndKeys:@"", @"text", nil]]
                                    autorelease];
    controller.delegate = self;
    controller.originView = [query objectForKey:@"__target__"];
    return controller;
}


-(void)submitComment
{
    if ([ShareData sharedInstance].sIntLoginSuccess==1) {
        TTOpenURL(@"tt://post");
    }
    else if([ShareData sharedInstance].sIntLoginSuccess==0)
    {
        TTOpenURL(@"tt://login/init");
    }
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) requestAction {
    TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=productCommentList&pid=%@&pageid=1&pagecount=5",self.mStrProductID]
                                                delegate: self];
    
    // TTURLImageResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse and TTURLXMLResponse.
    request.cachePolicy = TTURLRequestCachePolicyNetwork;
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    request.userInfo = @"refreshData";
    [request send];
}

-(void)requestPostComment:(NSString*)strComment
{
    NSString *strURL = [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=sendProductComment2&sessionid=%@&pid=%@&comment=%@", [[ShareData sharedInstance].sStrLoginSession stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                     [self.mStrProductID stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[strComment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    TTURLRequest* request = [TTURLRequest requestWithURL:strURL
                                                delegate: self];
    
    // TTURLImageResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse and TTURLXMLResponse.
    request.cachePolicy = TTURLRequestCachePolicyNetwork;
    request.httpMethod = @"post";
    request.multiPartForm = YES;
    
    //NSString* pMultiForm = [NSString stringWithFormat:@"sessionid=%@&pid=%@&comment=%@",[ShareData sharedInstance].sStrLoginSession,self.mStrProductID,strComment];
    //request.httpBody = [pMultiForm dataUsingEncoding:NSUTF8StringEncoding]; 
    //request.httpMethod = @"POST";
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    request.userInfo = @"postComment";
    [request send];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTURLRequestDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
    
    NSString *strResponseUserInfo = request.userInfo;
    if ([strResponseUserInfo isEqualToString:@"postComment"])
    {
        TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
        NSDictionary * rootObject = response.rootObject;
        NSString *strErrCode = [rootObject objectForKey:@"errcode"];
        NSInteger intErrCode = [strErrCode intValue];
        NSString *strMsg = [rootObject objectForKey:@"msg"];
        if (intErrCode==0) {
            [self requestAction];
            TTAlertNoTitle(NSLocalizedString(@"commentsuccess",nil));
        }
        else
        {
            TTAlertNoTitle(strMsg);
        }

    }
    else if([strResponseUserInfo isEqualToString:@"refreshData"])
    {
        TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
        NSArray * rootObject = response.rootObject;
        NSArray * commentObject = [rootObject objectAtIndex:0];
        
        NSMutableArray *commentArray = [NSMutableArray arrayWithCapacity:[rootObject count]];
        for (id comment in commentObject) {
            NSDictionary *commentDic = comment;
            NSString *commentUser = [commentDic objectForKey:@"user"];
            NSString *commentContent = [commentDic objectForKey:@"content"];
            NSString *commentTime = [commentDic objectForKey:@"time"];
            NSString *s = [NSString stringWithFormat:@"%@",commentTime];
            NSDate *d  = [NSDate dateWithTimeIntervalSince1970:[s doubleValue]];
            NSLog(@"dddd:%@",d); 
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *currentDateStr = [dateFormatter stringFromDate:d];
            NSLog(@"%@",currentDateStr);
            
            [commentArray addObject:[TTTableMessageItem itemWithTitle:commentUser caption:nil text:commentContent timestamp:currentDateStr URL:nil]];
        }
        [commentDataSource.sections removeAllObjects];
        [commentDataSource.items removeAllObjects];
        [commentDataSource.sections addObject:@""];
        [commentDataSource.items addObject:commentArray];
        
        //ds.addressBook.fakeLoadingDuration = 1.0;
        self.dataSource = commentDataSource;
        
        
        [self.tableView reloadData];
        [self invalidateView]; 
    }

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"Fail: %@",error);
    TTAlert([[error userInfo] valueForKey:@"fault"]);
    [super request:request didFailLoadWithError:error];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    TTTableTextItemCell *cell = [self.dataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
    [ShareData sharedInstance].sStrCity = cell.textLabel.text;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self.tableView reloadData];
    
}


@end
