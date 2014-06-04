//
//  AppDelegate.m
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
   
    ViewController *view = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
    self.window.rootViewController = navController;
    if([[launchOptions valueForKey:UIApplicationLaunchOptionsLocationKey] boolValue])
    {
        CustomLocationManager *locmanager = [CustomLocationManager sharedSingleton];
        [locmanager setUserLocationWithDelegate:self];
        if ([locmanager issignificentMonitoringAvailable])
        {
            [locmanager startSignificantChangeUpdates];
        }
    }
    
    locManager = [CustomLocationManager sharedSingleton];
    [locManager setLocationManagerDelegate:self];
    [locManager startStandardUpdates];
    dataManager = [[MyPlanitLocationDataManager alloc] init];
   
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
//    CustomLocationManager *locmanager = [CustomLocationManager sharedSingleton];
//    [locmanager setUserLocationWithDelegate:self];
//    if ([locmanager issignificentMonitoringAvailable])
//    {
//        [locmanager startSignificantChangeUpdates];
//    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)showAlert:(NSString *)message
{
    if (syncAlert==nil) {
        syncAlert = [[UIAlertView alloc] initWithTitle:@"PTM" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [syncAlert show];
    }
    else
    {
        [syncAlert dismissWithClickedButtonIndex:-1 animated:NO];
        [syncAlert setMessage:message];
        [syncAlert show];
    }
}
#pragma mark - location updates delegate
/***
 This delegate method will be called when a new location gets GPS Geofence
 
 ***/
-(void)ubilocationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *newLocation = [locations lastObject];
    if (newLocation)
    {
        if (newLocation.speed > 11)
       {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
           NSLog(@"%@",[userDefaults objectForKey:@"lastRecordDate"]);
            if ([userDefaults objectForKey:@"lastRecordDate"])
            {
                if ([self diffTimestamps:[NSDate date] sessTime:[userDefaults objectForKey:@"lastRecordDate"]]>=5) {
                    [userDefaults setObject:[NSDate date] forKey:@"lastRecordDate"];
                    [userDefaults synchronize];
                    DataModel *modal = [DataModel sharedModel];
                    NSDate *date = [NSDate date];
                    double dateF = [date timeIntervalSince1970];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
                    NSString *dateString = [formatter stringFromDate:date];
                     [modal insertLocationDetails:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude andDate:dateF andLocationName:@"" andDateString:dateString andSelectedLoc:-1 andSpeed:newLocation.speed];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"locationSaved" object:nil];                   //[dataManager managerDidUpdateLocation:locManager withLocation:newLocation];
                }
            }
            else
            {
                [userDefaults setObject:[NSDate date] forKey:@"lastRecordDate"];
                [userDefaults synchronize];
                DataModel *modal = [DataModel sharedModel];
                NSDate *date = [NSDate date];
                double dateF = [date timeIntervalSince1970];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
                NSString *dateString = [formatter stringFromDate:date];
                [modal insertLocationDetails:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude andDate:dateF andLocationName:@"" andDateString:dateString andSelectedLoc:-1 andSpeed:newLocation.speed];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"locationSaved" object:nil];
            }
           
            
        }
        else
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if ([userDefaults objectForKey:@"lastRecordDate"] ==nil )
            {
                [userDefaults setObject:[NSDate date] forKey:@"lastRecordDate"];
                [userDefaults synchronize];
                DataModel *modal = [DataModel sharedModel];
                NSDate *date = [NSDate date];
                double dateF = [date timeIntervalSince1970];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
                NSString *dateString = [formatter stringFromDate:date];
                [modal insertLocationDetails:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude andDate:dateF andLocationName:@"" andDateString:dateString andSelectedLoc:-1 andSpeed:newLocation.speed];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"locationSaved" object:nil];
            }
        }
        currentLocation = newLocation;
            //This method will handle the location updations into the database .
            
        
    }
    NSLog(@"%@",locations);
}
-(long)diffTimestamps:(NSDate *)current sessTime:(NSDate *)sess_time
{
    long current_milli = [current timeIntervalSince1970];
    long session=[sess_time timeIntervalSince1970];
    
    long diff= current_milli-session;
    
    long diffSecs = diff;//(60 * 1000)
    
    return diffSecs;
}

-(void)startUpdates
{
    [locManager startStandardUpdates];
    
}
- (void) ubilocationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@ -- %@",newLocation,oldLocation);
    /*[UIApplication sharedApplication].applicationIconBadgeNumber=0;
     UILocalNotification *localNotif = [[UILocalNotification alloc] init];
     if (localNotif == nil) return;
     NSDate *fireTime        = [[NSDate date] addTimeInterval:1];
     localNotif.fireDate     = fireTime;
     NSDictionary *infoDict  = [NSDictionary dictionaryWithObject:@"App delegate loc" forKey:@"speedalert"];
     localNotif.userInfo     = infoDict;
     localNotif.alertBody    = @"App delegate loc";
     [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];*/
}

- (void)ubilocationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)regio
{
    //[self locationManager:manager didEnterRegion:regio];
    
}
- (void)ubilocationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
    [manager stopMonitoringForRegion:region];
    [locManager startStandardUpdates];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:@"region exit" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    //[self locationManager:manager didExitRegion:region];
    
    //    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"corn"];
    //
    //    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    //    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    //    if (localNotif == nil) return;
    //    NSDate *fireTime        = [[NSDate date] addTimeInterval:1];
    //    localNotif.fireDate     = fireTime;
    //    NSDictionary *infoDict  = [NSDictionary dictionaryWithObject:@"Region Exited" forKey:@"speedalert"];
    //    localNotif.userInfo     = infoDict;
    //    localNotif.alertBody    = @"Region Exited";
    //    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}
- (void)ubilocationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region;
{
    /*[UIApplication sharedApplication].applicationIconBadgeNumber=0;
     UILocalNotification *localNotif = [[UILocalNotification alloc] init];
     if (localNotif == nil) return;
     NSDate *fireTime        = [[NSDate date] addTimeInterval:1];
     localNotif.fireDate     = fireTime;
     NSDictionary *infoDict  = [NSDictionary dictionaryWithObject:@"Region Monitor Started" forKey:@"speedalert"];
     localNotif.userInfo     = infoDict;
     localNotif.alertBody    = @"Region Monitor Started";
     [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];*/
}

@end
