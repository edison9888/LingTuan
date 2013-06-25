//
//  LoginController.h
//  GouTuan
//
//  Created by  on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>
#import "LoginSectionDataSource.h"

@interface LoginController : TTTableViewController<TTURLRequestDelegate>
{
    LoginSectionDataSource *loginDataSource;

    UITextField* nameTextField;
    TTTableControlItem* nameItem;
    UITextField* passwordTextField;
    TTTableControlItem* passwordItem;

}
@end
