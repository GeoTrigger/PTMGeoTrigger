//
//  LocationViewController.m
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mappView.showsUserLocation = YES;
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    
    // Do any additional setup after loading the view from its nib.
}
-(AppDelegate *) sharedObject
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location = [locations lastObject];
    if (location) {
        MKCoordinateRegion  region = MKCoordinateRegionMakeWithDistance(location.coordinate, 50, 50);
        region.center.latitude=[mapDetails returnLocationLatitude];
        region.center.longitude=[mapDetails returnLocationLongitude];
        region.span.latitudeDelta = 0.02;
        region.span.longitudeDelta = 0.02;
        [mappView setRegion:region animated:YES];
        
        MapsModel *temp = [[MapsModel alloc]init];
        temp.title      = [mapDetails returnMainLocation];
        temp.subtitle   = [mapDetails returnMainLocation];
        temp.coordinate = currentLocation.coordinate;
        NSArray *allAnnotations     = mappView.annotations;
        [mappView removeAnnotations:allAnnotations];
        [mappView addAnnotation:temp];
    }
    
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pin=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Location"];
    if (pin) {
        pin = nil;
    }
    if(!pin)
    {
        pin=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Location"];
    }
    pin.pinColor=MKPinAnnotationColorGreen;
    pin.canShowCallout=YES;
    pin.animatesDrop=YES;
    return pin;
    
}


#pragma mark - click events
/**
 * This method returns the custom Menu button
 *
 * @return UIBarButtonItem
 */
- (UIBarButtonItem *)leftMenuBarButtonItem
{
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    //[menuBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [menuBtn setTitle:@"Back" forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}
-(void) leftSideMenuButtonPressed:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
