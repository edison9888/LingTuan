#import <Three20/Three20.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutController : TTTableViewController<MFMailComposeViewControllerDelegate> {
    UIImageView *mBKUIImageView;
}
@property(nonatomic,retain)UIImageView *mBkUIImageView;
-(void)showPicker;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end
