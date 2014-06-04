//
//  DataModel.m
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import "DataModel.h"
#define DOCPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define DB_VERSION 2.1
static DataModel *sharedDataModel;
@implementation DataModel
- (id)init
{
    self = [super init];
    if(self)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        double version = [[userDefaults objectForKey:@"DB_VERSION"] doubleValue];
        NSString *dbPath = [DOCPATH stringByAppendingPathComponent:@"GeoTrigger.db"];
        BOOL isCreateDB = YES;
        if([[NSFileManager defaultManager] fileExistsAtPath:dbPath]) isCreateDB = NO;
        if (version !=0 && version < DB_VERSION && isCreateDB==NO)
        {
            NSString *str= dbPath;
            NSError *error;
            BOOL success = [[NSFileManager defaultManager] removeItemAtPath:str error:&error];
            if (!success) {
                NSLog(@"Error removing file at path: %@", error.localizedDescription);
            }
            else
            {
                NSLog(@"File removed  at path: %@", error.localizedDescription);
            }
            isCreateDB = YES;
        }
        
        if(isCreateDB)
        {
            [userDefaults setObject:[NSString stringWithFormat:@"%f",DB_VERSION] forKey:@"DB_VERSION"];
            [userDefaults synchronize];
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"GeoTrigger" ofType:@"sqlite"];
            NSData *mainData = [NSData dataWithContentsOfFile:bundlePath];
            [mainData writeToFile:dbPath atomically:YES];
        }
        
        db      = [FMDatabase databaseWithPath:dbPath] ;
        if (![db open]) {
            NSLog(@"Could not open it");
        }
        
    }
    return self;
}
-(id)fmDataQueue
{
    return [FMDatabaseQueue databaseQueueWithPath:[DOCPATH stringByAppendingPathComponent:@"GeoTrigger.db"]];
}
+(DataModel *)sharedModel
{
    if (!sharedDataModel) {
        sharedDataModel = [[DataModel alloc] init];
    }
    return sharedDataModel;
}
-(NSMutableArray *) getLocationDetails
{
    NSMutableArray *allLocations = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [self fmDataQueue];
    [queue inDatabase:^(FMDatabase *db1) {
        
        NSString *sql = [NSString stringWithFormat:@"select distinct * from LocationDetails"];
        FMResultSet *rs = [db1 executeQuery:sql];
        
        while ([rs next])
        {
            LocationParams *location = [[LocationParams alloc] init];
            location.latitude = [rs doubleForColumn:@"latitude"];
            location.longitude = [rs doubleForColumn:@"longitude"];
            location.date = [rs doubleForColumn:@"date"];
            location.locationName = [rs stringForColumn:@"locationName"];
            location.dateString = [rs stringForColumn:@"dateString"];
            location.selectedLoc = [rs intForColumn:@"selectedLoc"];
            location.speed = [rs doubleForColumn:@"speed"];
            [allLocations addObject:location];
            location = nil;
        }
        sql = nil;
        rs  = nil;
    }];
    
    
    return allLocations;
}
-(NSMutableArray *) getLocationDetailsDate:(NSString *) date
{
    NSMutableArray *allLocations = [[NSMutableArray alloc] init];
    FMDatabaseQueue *queue = [self fmDataQueue];
    [queue inDatabase:^(FMDatabase *db1) {
        
        NSString *sql = [NSString stringWithFormat:@"select distinct * from LocationDetails where dateString = '%@'",date];
        FMResultSet *rs = [db1 executeQuery:sql];
        
        while ([rs next])
        {
            LocationParams *location = [[LocationParams alloc] init];
            location.latitude = [rs doubleForColumn:@"latitude"];
            location.longitude = [rs doubleForColumn:@"longitude"];
            location.date = [rs doubleForColumn:@"date"];
            location.locationName = [rs stringForColumn:@"locationName"];
            location.dateString = [rs stringForColumn:@"dateString"];
            location.selectedLoc = [rs intForColumn:@"selectedLoc"];
            [allLocations addObject:location];
            location = nil;
        }
        sql = nil;
        rs  = nil;
        
    }];
    
    
    return allLocations;
}
-(LocationParams *) getOldLatitudeandLongitude
{
    __block LocationParams *location ;//6a
    FMDatabaseQueue *queue = [self fmDataQueue];
    [queue inDatabase:^(FMDatabase *db1) {
        NSString *sql = [NSString stringWithFormat:@"select latitude,longitude,date,locationName,dateString,selectedLoc from LocationDetails order by id desc limit 1"];
        FMResultSet *rs = [db1 executeQuery:sql];
        
        while ([rs next])
        {
            location   = [[LocationParams alloc] init];//6a
            location.latitude = [rs doubleForColumn:@"latitude"];
            location.longitude = [rs doubleForColumn:@"longitude"];
            location.date   = [rs doubleForColumn:@"date"];//6a
            location.locationName = [rs stringForColumn:@"locationName"];
            location.dateString = [rs stringForColumn:@"dateString"];
            location.selectedLoc = [rs intForColumn:@"selectedLoc"];
        }
        sql = nil;
        rs  = nil;
    }];
    
    
    return location;
}
#pragma mark - Location Details table operations
-(void) insertLocationDetails:(double) latitude andLongitude:(double) longitude andDate:(double) date andLocationName:(NSString *) locationName andDateString:(NSString *) dateString andSelectedLoc:(int) loc andSpeed:(double) speed
{
    FMDatabaseQueue *queue = [self fmDataQueue];
    [queue inDatabase:^(FMDatabase *db1) {
        NSLog(@"%d",[db1 executeUpdate:[NSString stringWithFormat:@"insert into LocationDetails(latitude,longitude,date,locationName,dateString,selectedLoc,speed) values(%f,%f,%f,'%@','%@',%d,%f)",latitude,longitude,date,locationName,dateString,loc,speed]]);
        
    }];
    
}

@end
