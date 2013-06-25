//
//  GouTuanAppDelegate.h
//  GouTuan
//
//  Created by  on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

@class GouTuanViewController;

@interface GouTuanAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GouTuanViewController *viewController;

-(void)initConfigure;
@end
