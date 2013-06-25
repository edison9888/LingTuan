#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>
@interface CityController : TTTableViewController<TTURLRequestDelegate,UIAlertViewDelegate> {
    TTSectionedDataSource *cityDataSource;
    NSIndexPath* cityIndex;
}

- (void) requestAction;
@end
