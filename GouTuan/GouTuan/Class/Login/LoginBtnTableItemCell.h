//
//  PageTableItemCell.h
//  GouTuan
//
//  Created by  on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface LoginBtnTableItemCell : TTTableImageItemCell
{    
    TTButton* m_pBackButton;
    UIButton* m_pLoginButton;
}
@property(nonatomic,retain) TTButton *m_pBackButton;
@property(nonatomic,retain) UIButton *m_pLoginButton;
@end
