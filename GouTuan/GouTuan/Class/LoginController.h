//
//  LoginController.h
//  GouTuan
//
//  Created by  on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

@interface LoginController : TTTableViewController<TTURLRequestDelegate>
{
    TTListDataSource *loginDataSource;
    TTListDataSource *registerDataSource;
    UITextField* nameTextField;
    TTTableControlItem* nameItem;
    UITextField* passwordTextField;
    TTTableControlItem* passwordItem;
    TTTableControlItem* switchItem;
    UITextField* registerNameTextField;
    TTTableControlItem* registerNameItem;
    UITextField* registerPasswordTextField;
    TTTableControlItem* registerPasswordItem;
    UITextField* registerConfirmPasswordTextField;
    TTTableControlItem* registerConfirmPasswordItem;
    UITextField* emailTextField;
    TTTableControlItem* emailItem;
    TTTableControlItem* loginItem;
    TTTableControlItem* registerItem;
}
@end
