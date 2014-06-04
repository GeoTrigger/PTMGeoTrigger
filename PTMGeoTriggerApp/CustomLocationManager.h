//
//  CustomLocationManager.h
//  Speeddemo
//
//  Created by Justin Wanajrat on 16/04/13.
//  Copyright (c) 2013 sstig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol LocationManagerAssigneeProtocol;
@interface CustomLocationManager : NSObject<CLLocationManagerDelegate>
{
    id<LocationManagerAssigneeProtocol> locationManagerDelegate;
    CLLocationManager* locationManager;
}
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLLocation *lastlocationknown;
@property (nonatomic, strong) id<LocationManagerAssigneeProtocol> locationManagerDelegate;
+ (CustomLocationManager*) sharedSingleton;
- (void) setUserLocationWithDelegate:(id) delegate;
- (void) startSignificantChangeUpdates;
- (void)stopSignificantChangeUpdates;
- (void)startStandardUpdates;
-(void)stopMonitoringUpdates;
- (void) startMonitoringforRegionWithRadius:(int)radius;
-(void) startMonitoringforRegionWithRadius:(CLLocation *)clLocation withRadius:(int)radius;
- (BOOL) issignificentMonitoringAvailable;
@end

@protocol  LocationManagerAssigneeProtocol
- (void) ubididUpdateToLocation:(CLLocation *) location;
- (void) ubilocationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
- (void) ubilocationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
- (void) ubilocationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region;
- (void) ubilocationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region;
- (void) ubilocationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region;
@end
