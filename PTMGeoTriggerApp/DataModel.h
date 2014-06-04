//
//  DataModel.h
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "LocationParams.h"
@interface DataModel : NSObject
{
    FMDatabase *db;
    
    sqlite3 *contactsDB;
    sqlite3_stmt *preparedSatement;
    NSString *contactDBPath;
}
+(DataModel *)sharedModel;
-(NSMutableArray *) getLocationDetails;
//Location related Database Operations
-(void) insertLocationDetails:(double) latitude andLongitude:(double) longitude andDate:(double) date andLocationName:(NSString *) locationName andDateString:(NSString *) dateString andSelectedLoc:(int) loc andSpeed:(double) speed;
-(NSMutableArray *) getLocationDetailsDate:(NSString *) date;
-(LocationParams *) getOldLatitudeandLongitude;
@end
