//
//  MapViewDetails.m
//  LocationPOC
//
//  Created by Justin Wanajrat on 31/01/14.
//  Copyright (c) 2014 SSTIG. All rights reserved.
//

#import "MapViewDetails.h"

@implementation MapViewDetails
-(void)setLocationLatitude:(float)lati andLocationLongitude:(float)longi{
    
    latitude=lati;
    longitude=longi;
    
    
}
-(float)returnLocationLatitude{
    
    return latitude;
    
}
-(float)returnLocationLongitude{
    
    return longitude;
    
}
-(void)setMainLocation:(NSString *)locationAdd{
    
    
    locAddress=locationAdd;
    
    
}
-(NSString*)returnMainLocation{
    
    
    return locAddress;
    
    
}


-(void)setCurrentLocation{
    
    currentLocation = [[CLLocation alloc]
                       initWithLatitude:[self returnLocationLatitude] longitude:[self returnLocationLongitude]];
    
}
-(void)setCurrentLocationWithNewLocation:(CLLocation *)newLoc{
    
    currentLocation=newLoc;
    
}
-(CLLocation *)returnCurrentLocation{
    
    
    return currentLocation;
    
}

@end
