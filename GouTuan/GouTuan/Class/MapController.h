#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface MapController : TTViewController<MKMapViewDelegate>{

    MKMapView *mapView;
    MapAnnotation *mMapAnnotation;
    NSString *productID;
    double annotationLongtitude;
    double annotationLatitude;
    bool blRoute;
    bool blSingleAnnotation;
    CLLocationCoordinate2D desCoordinate;
    int intMapModel;
}
@property (nonatomic, retain)MKMapView *mapView;
- (void)setMapLocation:(CLLocationCoordinate2D)coordinate distance:(double)distance animated:(BOOL)animated;
@end
