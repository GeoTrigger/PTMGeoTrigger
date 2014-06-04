//
//  LocationParams.h
//  LocationPOC
//
//  Created by Justin Wanajrat on 31/01/14.
//  Copyright (c) 2014 SSTIG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationParams : NSObject
{
    
}
@property(nonatomic) double latitude;
@property(nonatomic) double longitude;
@property(nonatomic,retain) NSString *locationName;
@property(nonatomic) double date;
@property(nonatomic,retain) NSString *dateString;
@property(nonatomic) int selectedLoc;
@property(nonatomic,retain) NSArray *nearByVenues;
- (NSComparisonResult)dateCompare:(LocationParams *)otherObject;
@property(nonatomic) int speed;
@end
