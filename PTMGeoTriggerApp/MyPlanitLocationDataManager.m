//
//  MyPlanitLocationDataManager.m
//  MyPlanIt
//
//  Created by Justin Wanajrat on 17/04/14.
//  Copyright (c) 2014 SSTIG. All rights reserved.
//

#import "MyPlanitLocationDataManager.h"
#import "MapViewDetails.h"
#import "DataModel.h"
#import "AppDelegate.h"
@implementation MyPlanitLocationDataManager
#pragma mark - inserting location details and adding moments
/***
 This method is used for the saving the location details into the database. Location is updated when the distance from the last location to the new location is greater than 10 meters and the moment will be inserted if the time slice between from last location to current location is greater than 5 mins .
 @param manager (CustomLocationManager object)
 @param newLocation - This is the new location which needs to updated .
 ***/
-(void)managerDidUpdateLocation:(CustomLocationManager *)manager withLocation:(CLLocation *)newLocation
{
    MapViewDetails *mapDetails = [[MapViewDetails alloc] init];
    [mapDetails setCurrentLocationWithNewLocation:newLocation];
    [mapDetails setLocationLatitude:newLocation.coordinate.latitude andLocationLongitude:newLocation.coordinate.longitude];
    if ([mapDetails returnCurrentLocation] != nil)
    {
        NSLog(@"%@",[NSString stringWithFormat:@"%.8f", [mapDetails returnLocationLatitude]]);
        NSLog(@"%@",[NSString stringWithFormat:@"%.8f", [mapDetails returnLocationLongitude]]);
    }
    NSLog(@"%@",[mapDetails returnCurrentLocation]);
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[mapDetails returnCurrentLocation] completionHandler:^(NSArray *placemarks, NSError *error) {
        
       NSString *locationAddress =[[NSString alloc]init];
        CLPlacemark *placemark;
        if (error == nil && [placemarks count] > 0 )
        {
            placemark = [placemarks lastObject];
            if (placemark.subThoroughfare)
                locationAddress = [locationAddress stringByAppendingFormat:@"%@ ",placemark.subThoroughfare];
            if (placemark.thoroughfare)
                locationAddress = [locationAddress stringByAppendingFormat:@"%@ ",placemark.thoroughfare];
            if (placemark.postalCode)
                locationAddress = [locationAddress stringByAppendingFormat:@"%@ ",placemark.postalCode];
            if (placemark.locality)
                locationAddress = [locationAddress stringByAppendingFormat:@"%@ ",placemark.locality];
            if (placemark.administrativeArea)
                locationAddress = [locationAddress stringByAppendingFormat:@"%@ ",placemark.administrativeArea];
            if (placemark.country)
                locationAddress = [locationAddress stringByAppendingFormat:@"%@ ",placemark.country];
            
            NSLog(@"%@",placemark.locality);
            
            [mapDetails setMainLocation:locationAddress];
            CLLocation *currentLocation =[[CLLocation alloc]initWithLatitude:[mapDetails returnLocationLatitude] longitude:[mapDetails returnLocationLongitude]];
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
            NSString *dateString = [formatter stringFromDate:date];
            double dateF = [date timeIntervalSince1970];
            
            DataModel *model        = [DataModel sharedModel];
            LocationParams *previousLocationobject  = [model getOldLatitudeandLongitude];
            
            if (previousLocationobject == nil)
            {
                //if previous location is nil(first time exe)
                [model insertLocationDetails:currentLocation.coordinate.latitude andLongitude:currentLocation.coordinate.longitude andDate:dateF andLocationName:locationAddress andDateString:dateString andSelectedLoc:-1 andSpeed:newLocation.speed];
                
//                [manager stopMonitoringUpdates];
//                [manager startMonitoringforRegionWithRadius:currentLocation withRadius:10];
                
            }
            else
            {
                CLLocation *locA   = [[CLLocation alloc] initWithLatitude:previousLocationobject.latitude longitude:previousLocationobject.longitude];
                CLLocation *locB        = [[CLLocation alloc] initWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
                CLLocationDistance distance    = [locA distanceFromLocation:locB];
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                double distanceSetting = [[user objectForKey:@"Distance"] doubleValue];
                if (distanceSetting == 0)
                {
                    distanceSetting = 3; //6a
                }
                if (distance > distanceSetting)
                {
                    if (manager == nil) {
                        [NSException raise:@"Location Manager Not Initialized" format:@"You must initialize location manager first."];
                    }
                    if(![CLLocationManager isMonitoringAvailableForClass:[CLRegion class]])
                    {
                        [self showAlertWithMessage:@"This app requires region monitoring features which are unavailable on this device."];
                        return;
                    }
                    //compare times
                    double previousTimeInterval = previousLocationobject.date;
                    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:previousTimeInterval];
                    NSDate *newDate = [NSDate date];
                    double timeDiff = [newDate timeIntervalSinceDate:oldDate];
                    // NSLog(@"%f mins",timeDiff*60);
                    if (timeDiff > 300) //time diff > 5 min
                    {
                        [model insertLocationDetails:currentLocation.coordinate.latitude andLongitude:currentLocation.coordinate.longitude andDate:dateF andLocationName:locationAddress andDateString:dateString andSelectedLoc:-1 andSpeed:newLocation.speed];
                    //This will stops the monitoring updates using GPS geofence with in the radius of 10 meters.
//                        [manager stopMonitoringUpdates];
//                        //Again start the monitoring updates using GPS geofence with in the radius of 10 meters .
//                        [manager startMonitoringforRegionWithRadius:currentLocation withRadius:10]; //6a
                        
                    }
                    
                    
                }
            }
            

            //[manager stopUpdatingLocation];
        }
        
    } ];
}
/**
 * This method used to  convert the time interval into a required date sting
 *
 * @param date the time interval which is to be converted to date.
 * @return NSString the formatted date string
 */


-(NSString *) dateFromTimeInterval:(double) date //6a
{
    NSDate *dateF = [NSDate dateWithTimeIntervalSince1970:date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    NSString *dateString =  [dateFormatter stringFromDate:dateF];
    
    return dateString;
}
- (void)showAlertWithMessage:(NSString*)alertText {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location Services Error"
                                                        message:alertText
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}


@end