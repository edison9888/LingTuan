#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>
@interface CommentController : TTTableViewController<TTURLRequestDelegate,TTPostControllerDelegate> {
    TTSectionedDataSource *commentDataSource;
    NSString *mStrProductID;
    UIImageView *mBKUIImageView;
}
@property(nonatomic,retain)UIImageView *mBkUIImageView;
@property(nonatomic,retain) NSString* mStrProductID;
- (void) requestDetailAction;
-(void)requestPostComment:(NSString*)strComment;
-(void)requestAction;
@end
