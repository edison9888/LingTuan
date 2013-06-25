#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

@interface MineController : TTTableViewController<TTURLRequestDelegate> {
    TTListDataSource *listDataSource;
    UIImageView *mBKUIImageView;
}
@property(nonatomic,retain)UIImageView *mBkUIImageView;

- (void) requestLoginAuto;
@end
