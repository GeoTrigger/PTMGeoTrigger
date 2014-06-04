//
//  MapViewDetails.h
//  LocationPOC
//
//  Created by Justin Wanajrat on 31/01/14.
//  Copyright (c) 2014 SSTIG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapViewDetails : NSObject<MKMapViewDelegate,CLLocationManagerDelegate>
{
    float latitude;
    float longitude;
    NSString *locAddress;
    CLLocation *currentLocation;
    NSString *dateString;
}
-(void)setLocationLatitude:(float)lati andLocationLongitude:(float)longi;
-(float)returnLocationLatitude;
-(float)returnLocationLongitude;
-(void)setMainLocation:(NSString *)locationAdd;
-(NSString *)returnMainLocation;
-(void)setCurrentLocation;
-(void)setCurrentLocationWithNewLocation:(CLLocation *)newLoc;
-(CLLocation *)returnCurrentLocation;
@end
