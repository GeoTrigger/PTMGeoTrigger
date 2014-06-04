//
//  MyPlanitLocationDataManager.h
//  MyPlanIt
//
//  Created by Justin Wanajrat on 17/04/14.
//  Copyright (c) 2014 SSTIG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomLocationManager.h"
@interface MyPlanitLocationDataManager : NSObject
{
     NSArray *nearbyVenues;
    
}
-(void)managerDidUpdateLocation:(CustomLocationManager *)manager withLocation:(CLLocation *)newLocation;
@end
