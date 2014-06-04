//
//  AppDelegate.h
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "CustomLocationManager.h"
#import "MyPlanitLocationDataManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,MKMapViewDelegate,LocationManagerAssigneeProtocol>
{
    UIAlertView *syncAlert;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    MyPlanitLocationDataManager *dataManager;
    CustomLocationManager *locManager;
   
}
@property (strong, nonatomic) UIWindow *window;

@end
