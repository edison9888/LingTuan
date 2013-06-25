#import <Three20/Three20.h>
#import "WallDataSource.h"
#import <extThree20JSON/extThree20JSON.h>
@interface WallViewController : TTTableViewController<TTTableViewDelegate>{
    WallDataSource *listDataSource;
    int startDeceleratingPosition;
    UILabel *distanceTextLabel;
    UIImageView *distanceImageView;
}
@property(nonatomic,retain)UILabel *distanceTextLabel;
@property(nonatomic,retain)UIImageView *distanceImageView;
@end
