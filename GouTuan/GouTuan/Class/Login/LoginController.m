//
//  LoginController.m
//  GouTuan
//
//  Created by  on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import "ShareData.h"
#import "LoginBtnTableItem.h"
#import "LoginBtnTableItemCell.h"

@implementation LoginController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.title = NSLocalizedString(@"login",nil);
        self.tableViewStyle = UITableViewStyleGrouped;
        self.autoresizesForKeyboard = YES;
        self.variableHeightRows = YES;
        
        nameTextField = [[UITextField alloc] init];
        nameTextField.placeholder = NSLocalizedString(@"inputaccount",nil);
        nameTextField.font = TTSTYLEVAR(font);
        nameItem = [[TTTableControlItem alloc] init];
        nameItem.caption = NSLocalizedString(@"account",nil);
        nameItem.control = nameTextField;
        
        passwordTextField = [[UITextField alloc] init];
        passwordTextField.placeholder = NSLocalizedString(@"inputpassword",nil);
        passwordTextField.font = TTSTYLEVAR(font);
        passwordTextField.secureTextEntry = YES;
        passwordItem = [[TTTableControlItem alloc] init];
        passwordItem.caption = NSLocalizedString(@"password",nil);
        passwordItem.control = passwordTextField;

        
        loginDataSource = [LoginSectionDataSource dataSourceWithObjects:@"",nameItem,passwordItem,@"",[LoginBtnTableItem initLoginBtnTableItem],@"",[TTTableTextItem itemWithText:@"快速注册团宝账户" URL:@"tt://register/init"],nil];
         
        //loginDataSource = [LoginSectionDataSource initLoginDataSource];
        self.dataSource = loginDataSource;
        
        TTURLMap *map = [TTNavigator navigator].URLMap;
        [map from:@"tt://login/handleback" toViewController:self selector:@selector(handleBackCallback)];
        //[map from:@"tt://login/handlelogin" toViewController:self selector:@selector(handleLoginCallback)];
        
    }
    
    return self;
}

- (void)dealloc {
    TTURLMap *map = [TTNavigator navigator].URLMap;
    [map removeURL:@"tt://login/handleback"];
    //[map removeURL:@"tt://login/handlelogin"];
    [super dealloc];
}

- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)handleBackCallback
{
    [self dismiss];
}

-(void)handleLoginCallback
{
    NSString *strName = nameTextField.text;
    if (strName) {
        if ([strName isEmptyOrWhitespace]) {
            TTAlertNoTitle(NSLocalizedString(@"accountEmpty",nil));
            return;
        }
    }
    else
    {
        TTAlertNoTitle(NSLocalizedString(@"accountEmpty",nil));
        return;
    }
    NSString *strPassword = passwordTextField.text;
    if (strPassword) {
        if ([strPassword isEmptyOrWhitespace]) {
            TTAlertNoTitle(NSLocalizedString(@"passwordEmpty",nil));
            return;
        }
    }
    else
    {
        TTAlertNoTitle(NSLocalizedString(@"passwordEmpty",nil));
        return;
    }
    [self requestLogin];
    
}

- (void) requestLogin
{
    TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=login&name=%@&password=%@",nameTextField.text,passwordTextField.text]
                                                delegate: self];
    
    request.cachePolicy = TTURLRequestCachePolicyNetwork;
    // TTURLImageResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    
    [request send];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TTURLRequestDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse* response = (TTURLJSONResponse*)request.response;
    TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
    NSDictionary * rootObject = response.rootObject;
    NSString *strSessionID = [rootObject objectForKey:@"sessionid"];
    NSString *strErrCode = [rootObject objectForKey:@"errcode"];
    NSInteger intErrCode = [strErrCode intValue];
    NSString *strMsg = [rootObject objectForKey:@"msg"];
    if (intErrCode==0) {
        [ShareData sharedInstance].sIntLoginSuccess = 1;
        [ShareData sharedInstance].sStrLoginName = nameTextField.text;
        [ShareData sharedInstance].sStrLoginPassword = passwordTextField.text;
        [ShareData sharedInstance].sStrLoginSession = strSessionID;
        [[NSUserDefaults standardUserDefaults] setObject:nameTextField.text forKey:@"loginname"];
        [[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:@"loginpassword"];
        [[NSUserDefaults standardUserDefaults] setObject:strSessionID forKey:@"loginsession"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissModalViewControllerAnimated:YES];
        
    }
    else
    {
        TTAlertNoTitle(strMsg);
    }
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    
}

@end
