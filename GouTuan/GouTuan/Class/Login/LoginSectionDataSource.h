//
//  sectionDataSource.h
//  Groupon
//
//  Created by  on 11-9-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Three20/Three20.h"
#import <extThree20JSON/extThree20JSON.h>

@interface LoginSectionDataSource : TTSectionedDataSource
{
    
    UITextField* nameTextField;
    TTTableControlItem* nameItem;
    UITextField* passwordTextField;
    TTTableControlItem* passwordItem;
    
}
+(LoginSectionDataSource*)initLoginDataSource;
@end
