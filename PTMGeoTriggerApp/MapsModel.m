//
//  MapsModel.m
//  MeetAt
//
//  Created by Ramakrishna on 9/30/13.
//  Copyright (c) 2013 SSTIG. All rights reserved.
//

#import "MapsModel.h"

@implementation MapsModel
@synthesize coordinate,title,subtitle;

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{

    coordinate=newCoordinate;
}
@end
