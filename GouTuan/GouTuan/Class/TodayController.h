#import <Three20/Three20.h>
#import "TodayDataSource.h"

@interface TodayController : TTTableViewController<UISearchBarDelegate> {
    NSString *citName;
    TodayDataSource *listDataSource;
    UISearchBar *searchBar;
    UIImageView *mBKUIImageView;
}
@property(nonatomic,retain)UIImageView *mBkUIImageView;
@property(nonatomic,retain) NSString *citName;
@property (nonatomic, retain) UISearchBar *searchBar;
@end
