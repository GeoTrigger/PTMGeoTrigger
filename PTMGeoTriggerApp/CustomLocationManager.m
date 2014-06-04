//
//  CustomLocationManager.m
//  Speeddemo
//
//  Created by Justin Wanajrat on 16/04/13.
//  Copyright (c) 2013 sstig. All rights reserved.
//

#import "CustomLocationManager.h"
#import "NetworkModel.h"

@implementation CustomLocationManager
@synthesize locationManager;
@synthesize lastlocationknown;
@synthesize locationManagerDelegate;
- (id)init {
    self = [super init];
    
    if(self) {
        self.locationManager = [CLLocationManager new];
        [self.locationManager setDelegate:self];
        [self.locationManager setDistanceFilter:kCLLocationAccuracyNearestTenMeters];
        [self.locationManager setHeadingFilter:kCLHeadingFilterNone];
        //do any more customization to your location manager
    }
    
    return self;
}

/**
 * This method called to get the instance of the CustomLocationManager class . A new instance is created if previously doesnt exist else returns the existed instance.
 *
 * @return Returns void
 */
+ (CustomLocationManager*)sharedSingleton {
    static CustomLocationManager* sharedSingleton;
    if(!sharedSingleton) {
        @synchronized(sharedSingleton) {
            sharedSingleton = [CustomLocationManager new];
        }
    }
    
    return sharedSingleton;
}

/**
 * On this method call it starts monitoring significant method calls .
 *
 * @return Returns void
 */
- (void)startSignificantChangeUpdates

{
    [locationManager startMonitoringSignificantLocationChanges];
}

/**
 * On this method call it stops monitoring significant method calls .
 *
 * @return Returns void
 */
- (void)stopSignificantChangeUpdates

{
    [locationManager stopMonitoringSignificantLocationChanges];
}

/**
 * On this method call it starts monitoring standard method calls .
 *
 * @return Returns void
 */
- (void)startStandardUpdates
{
    [locationManager startUpdatingLocation];
}
/**
 * On this method call it stops monitoring standard method calls .
 *
 * @return Returns void
 */
-(void)stopMonitoringUpdates
{
    [locationManager stopUpdatingLocation];
}
/**
 * This method sets the delegate variable defined to send the location updates to the called object.
 *
 * @param delegate reference Id of the object
 * @return Returns void
 */
-(void) setUserLocationWithDelegate:(id) delegate {
    if([CLLocationManager locationServicesEnabled])
    {
        locationManagerDelegate = delegate;
    }
}

-(void) startMonitoringforRegionWithRadius:(int)radius
{
    if (lastlocationknown != nil)
    {
        [self startMonitoringforRegionWithRadius:lastlocationknown withRadius:radius];
    }
    
}
/**
 This will restarts the monitoring region location updates .
 @param clLocation - CLLocation object
 @param radius - This is the radius with in this distance the location updatios will be occured . 
 ***/
-(void) startMonitoringforRegionWithRadius:(CLLocation *)clLocation withRadius:(int)radius
{
    if (clLocation != nil)
    {
        CLLocationCoordinate2D cord = clLocation.coordinate;
        //CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:cord radius:radius identifier:@"myPlanit"];
        CLCircularRegion *region1 = [[CLCircularRegion alloc] initWithCenter:cord radius:radius identifier:@"myPlanit"];
        [locationManager startMonitoringForRegion:region1];
    }
    
}


-(BOOL)issignificentMonitoringAvailable
{
    return [CLLocationManager significantLocationChangeMonitoringAvailable];
    
}

#pragma CLLocationManagerDelegate
/**
 * This CLLocation delegate method implemented in CustomLocation class to receive failure.
 *
 * @param manager CLLocationManager object.
 * @return Returns void
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

/**
 * This CLLocation delegate method implemented in CustomLocation class to receive location updates.
 *
 * @param manager CLLocationManager object.
 * @param locations CLLocation updates array
 * @return Returns void
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if ([locations lastObject] != nil) {
        lastlocationknown= [locations lastObject];
    }
    if (locationManagerDelegate != nil) {
        [locationManagerDelegate ubilocationManager:manager didUpdateLocations:locations];
    }
}

/**
 * This CLLocation delegate method implemented in CustomLocation class to receive location updates.
 *
 * @param manager CLLocationManager object.
 * @param newLocation CLLocation object with new location info
 * @param oldLocation CLLocation object with previous location info
 * @return Returns void
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation != nil)
    {
        lastlocationknown= newLocation;
    }
    if (locationManagerDelegate != nil) {
        [locationManagerDelegate ubilocationManager:manager didUpdateToLocation:newLocation fromLocation:oldLocation];
    }
}

/**
 * This CLLocation delegate method implemented in CustomLocation class to receive region updates.
 *
 * @param manager CLLocationManager object.
 * @param region  CLRegion object with new region info
 * @return Returns void
 */
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    if (locationManagerDelegate != nil)
    {
        [locationManagerDelegate ubilocationManager:manager didEnterRegion:region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    if (locationManagerDelegate != nil)
    {
        [locationManagerDelegate ubilocationManager:manager didExitRegion:region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    if (locationManagerDelegate != nil) {
        [locationManagerDelegate ubilocationManager:manager didStartMonitoringForRegion:region];
    }
}



@end
