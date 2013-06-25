#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>
#import "PageDataSource.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class PageListDataSource;

@interface PageController : TTTableViewController<TTURLRequestDelegate,CLLocationManagerDelegate,MKReverseGeocoderDelegate> {
    NSInteger intPage;
    PageDataSource *listDataSource;
    CLLocationManager *mLocationManager;
    MKReverseGeocoder *reverseGeocoder;
    int mIntType;
    UIImageView *mBkUIImageView;
    
}

@property(nonatomic,readwrite)NSInteger intPage;
@property(nonatomic,retain)UIImageView *mBkUIImageView;
@property (nonatomic, retain) MKReverseGeocoder *reverseGeocoder;

@end
