#import <Three20/Three20.h>
#import "Three20UI/TTActionSheetControllerDelegate.h"
#import "Three20UI/TTActionSheet.h"
#import <extThree20JSON/extThree20JSON.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface DetailController : TTTableViewController <TTURLRequestDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate,TTActionSheetControllerDelegate>{
    TTListDataSource *listDataSource;
    NSString *strProductID;
    NSString *strProductNotes;
    NSString *strProductDetail;
    NSString *mStrShopLat;
    NSString *mStrShopLng;
    NSString *mStrShopAddr;
    NSString *mStrShopName;
    NSString *mStrProductDescription;
    UILabel *timerAniLabel;

    UIImageView *mBKUIImageView;
}
@property(nonatomic,retain)UIImageView *mBkUIImageView;
@property(nonatomic,retain)NSString *mStrProductDescription;
@property(nonatomic,retain)UILabel *timerAniLabel;
- (void) requestDetailAction;
-(void)addtomyfav;
-(void)addtomypurchase;
-(void)gotopurchase;
-(void)shareWithSMS;
-(void)shareWithEmail;
@end
