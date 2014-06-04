//
//  LocationViewController.h
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapViewDetails.h"
#import "MapsModel.h"
#import "CustomLocationManager.h"
#import "AppDelegate.h"
@interface LocationViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,LocationManagerAssigneeProtocol>
{
    IBOutlet MKMapView *mappView;
    CLLocationManager *locationManager;
    CustomLocationManager *customLocManager;
    CLLocation *currentLocation;
    MapViewDetails *mapDetails;
    MapsModel *mpM;
    CLGeocoder *geoCoder;
    CLPlacemark *placemark;
    NSString *locationAddress;
    MKCoordinateRegion region1;

}

@end
