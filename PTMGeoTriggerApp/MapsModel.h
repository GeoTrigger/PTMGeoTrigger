//
//  MapsModel.h
//  MeetAt
//
//  Created by Ramakrishna on 9/30/13.
//  Copyright (c) 2013 SSTIG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface MapsModel : NSObject<MKAnnotation>



#pragma mark - MKAnnotation Properties and Methods

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
