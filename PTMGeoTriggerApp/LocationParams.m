//
//  LocationParams.m
//  LocationPOC
//
//  Created by Justin Wanajrat on 31/01/14.
//  Copyright (c) 2014 SSTIG. All rights reserved.
//

#import "LocationParams.h"

@implementation LocationParams
@synthesize latitude;
@synthesize longitude;
@synthesize date;
@synthesize locationName;
@synthesize dateString;
@synthesize selectedLoc;
@synthesize nearByVenues;
- (NSComparisonResult)dateCompare:(LocationParams *)otherObject
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate *date1,*date2;
    date1 = [NSDate dateWithTimeIntervalSince1970:self.date];
    date2 = [NSDate dateWithTimeIntervalSince1970:otherObject.date];
    return [date1 compare:date2];
}
@end
