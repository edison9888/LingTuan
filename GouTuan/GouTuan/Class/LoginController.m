//
//  LoginController.m
//  GouTuan
//
//  Created by  on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import "ShareData.h"

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
        
        UISwitch* switchy = [[UISwitch alloc] init];
        NSUInteger loginAuto = [ShareData sharedInstance].sIntLoginAuto;
        if ([ShareData sharedInstance].sIntLoginAuto==1) {
            [switchy setOn:YES];
        }
        else
        {
            [switchy setOn:NO];
        }
        [switchy addTarget:self action:@selector(switchchange:) forControlEvents:UIControlEventValueChanged];
        
        switchItem = [[TTTableControlItem alloc] init];
        switchItem.caption = NSLocalizedString(@"loginautomatic",nil);
        switchItem.control = switchy;
        
        loginItem = [[TTTableControlItem alloc] init];
        UIButton *loginButton= [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
        loginButton.backgroundColor = [UIColor clearColor]; 
        [loginButton setTitle:NSLocalizedString(@"login",nil) forState:UIControlStateNormal]; 
        [loginButton addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside]; 
        loginItem.control = loginButton;
        
        registerItem = [[TTTableControlItem alloc] init];
        UIButton *registerButton= [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
        registerButton.backgroundColor = [UIColor clearColor]; 
        [registerButton setTitle:NSLocalizedString(@"register",nil) forState:UIControlStateNormal]; 
        [registerButton addTarget:self action:@selector(registerButton) forControlEvents:UIControlEventTouchUpInside]; 
        registerItem.control = registerButton;
        
        registerNameTextField = [[UITextField alloc] init];
        registerNameTextField.placeholder = NSLocalizedString(@"inputaccount",nil);
        registerNameTextField.font = TTSTYLEVAR(font);
        registerNameItem = [[TTTableControlItem alloc] init];
        registerNameItem.caption = NSLocalizedString(@"account",nil);
        registerNameItem.control = registerNameTextField;
        
        registerPasswordTextField = [[UITextField alloc] init];
        registerPasswordTextField.placeholder = NSLocalizedString(@"inputpassword",nil);
        registerPasswordTextField.font = TTSTYLEVAR(font);
        registerPasswordTextField.secureTextEntry = YES;
        registerPasswordItem = [[TTTableControlItem alloc] init];
        registerPasswordItem.caption = NSLocalizedString(@"password",nil);
        registerPasswordItem.control = registerPasswordTextField;
        
        registerConfirmPasswordTextField = [[UITextField alloc] init];
        registerConfirmPasswordTextField.placeholder = NSLocalizedString(@"inputpasswordagain",nil);
        registerConfirmPasswordTextField.font = TTSTYLEVAR(font);
        registerConfirmPasswordTextField.secureTextEntry = YES;
        registerConfirmPasswordItem = [[TTTableControlItem alloc] init];
        registerConfirmPasswordItem.caption = NSLocalizedString(@"confirmpassword",nil);
        registerConfirmPasswordItem.control = registerConfirmPasswordTextField;
        
        emailTextField = [[UITextField alloc] init];
        emailTextField.placeholder = NSLocalizedString(@"inputemail",nil);
        emailTextField.font = TTSTYLEVAR(font);
        emailItem = [[TTTableControlItem alloc] init];
        emailItem.caption = NSLocalizedString(@"email",nil);
        emailItem.control = emailTextField;
        
        loginDataSource = [TTListDataSource dataSourceWithObjects:nameItem,passwordItem,switchItem,loginItem,nil];
        //registerDataSource = [TTListDataSource dataSourceWithObjects:registerNameTextField,registerPasswordTextField,registerConfirmPasswordTextField,emailTextField,nil];
        self.dataSource = loginDataSource;
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                                  initWithTitle:NSLocalizedString(@"cancel",nil) style:UIBarButtonItemStyleBordered
                                                  target:self action:@selector(dismiss)] autorelease];
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"login",nil),NSLocalizedString(@"register",nil),nil]];
        //segmentedControl.frame = CGRectMake(100, 10, 180, 30);
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.selectedSegmentIndex = 0;
        
        self.navigationItem.titleView = segmentedControl;
        [segmentedControl release];
        
    }
    
    return self;
}

- (void)dealloc {
    
    [super dealloc];
}

- (void)segmentAction:(id)sender
{
    [self reload];
    if ([sender selectedSegmentIndex]==0) {
        [loginDataSource.items removeAllObjects];
        [loginDataSource.items addObject:nameItem];
        [loginDataSource.items addObject:passwordItem];
        [loginDataSource.items addObject:switchItem];
        [loginDataSource.items addObject:loginItem];
        [self.tableView reloadData];
    }
    else if([sender selectedSegmentIndex]==1)
    {
        [loginDataSource.items removeAllObjects];
        [loginDataSource.items addObject:registerNameItem];
        [loginDataSource.items addObject:registerPasswordItem];
        [loginDataSource.items addObject:registerConfirmPasswordItem];
        [loginDataSource.items addObject:emailItem];
        [loginDataSource.items addObject:registerItem];
        [self.tableView reloadData];
    }
}



- (void)switchchange:(id)sender {
    UISwitch *ctlSwitch = sender;
    if (ctlSwitch.on) {
        [ShareData sharedInstance].sIntLoginAuto = 1;
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"intloginauto"];
    }
    else
    {
        [ShareData sharedInstance].sIntLoginAuto = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"intloginauto"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}


-(void)loginButton
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
    request.userInfo = @"requestLogin";
    [request send];
}

-(void)registerButton
{
    NSString *strName = registerNameTextField.text;
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
    NSString *strPassword = registerPasswordTextField.text;
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
    NSString *strConfirmPassword = registerConfirmPasswordTextField.text;
    if (strConfirmPassword) {
        if ([strConfirmPassword isEmptyOrWhitespace]) {
            TTAlertNoTitle(NSLocalizedString(@"confirmpasswordempty",nil));
            return;
        }
        else if(![strConfirmPassword isEqualToString:strPassword])
        {
            TTAlertNoTitle(NSLocalizedString(@"confirmpasswordnotmatch",nil));
            return;
        }
    }
    else
    {
        TTAlertNoTitle(NSLocalizedString(@"confirmpasswordempty",nil));
        return;
    }
    NSString *strEmail = emailTextField.text;
    if (strEmail) {
        if ([strEmail isEmptyOrWhitespace]) {
            TTAlertNoTitle(NSLocalizedString(@"emailEmpty",nil));
            return;
        }
    }
    else
    {
        TTAlertNoTitle(NSLocalizedString(@"emailEmpty",nil));
        return;
    }
    
    [self registerRegister];
}

- (void)registerRegister
{
    TTURLRequest* request = [TTURLRequest requestWithURL: [NSString stringWithFormat:@"http://www.goutuan.net/index.php?m=Iphone&a=register&name=%@&password=%@&email=%@",registerNameTextField.text,registerPasswordTextField.text,emailTextField.text]
                                                delegate: self];
    
    request.cachePolicy = TTURLRequestCachePolicyNetwork;
    // TTURLImageResponse is just one of a set of response types you can use.
    // Also available are TTURLDataResponse and TTURLXMLResponse.
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    request.userInfo = @"registerRegister";
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
    NSString *strUserInfo = (NSString *)request.userInfo;
    if ([strUserInfo isEqualToString:@"requestLogin"]) {
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
        TTAlertNoTitle(strMsg);
    }
    else if([strUserInfo isEqualToString:@"registerRegister"])
    {
        TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
        NSDictionary * rootObject = response.rootObject;
        NSString *strErrCode = [rootObject objectForKey:@"errcode"];
        NSInteger intErrCode = [strErrCode intValue];
        NSString *strMsg = [rootObject objectForKey:@"msg"];
        TTAlertNoTitle(strMsg);
        [self dismissModalViewControllerAnimated:YES];
    }
    


}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    
}


@end
