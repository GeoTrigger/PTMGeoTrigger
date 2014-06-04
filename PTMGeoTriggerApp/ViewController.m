//
//  ViewController.m
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];

//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(reloadTable:) userInfo:nil repeats:YES];
//    [timer fire];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"locationSaved" object:nil];
}
/**
 * This methos returns the custom Phone button
 *
 * @return UIBarButtoItem
 */
- (UIBarButtonItem *)rightBarButtonItem
{
    UIButton *callButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [callButton setImage:[UIImage imageNamed:@"phone.jpg"] forState:UIControlStateNormal];
    [callButton setTitle:@"Location" forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(callButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:callButton];
}
-(void) callButtonPressed:(id) sender
{
    LocationViewController *location = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    [self.navigationController pushViewController:location animated:YES];
}
-(void) reloadTable:(id) sender
{
    [self getDetailsFromDatabase];
    [geoFenceTable reloadData];
}
-(void) reloadTableContents
{
    [self getDetailsFromDatabase];
    [geoFenceTable reloadData];
}

-(void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableContents) name:@"locationSaved" object:nil];
    [self getDetailsFromDatabase];
    [geoFenceTable reloadData];
}
-(void) getDetailsFromDatabase
{
    datesArray = [[NSMutableArray alloc] init];
    DataModel *model = [DataModel sharedModel];
    locationsArray = [model getLocationDetails];
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"GeofenceCell";
    GeoTrackCellTableViewCell *cell = (GeoTrackCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GeoTrackCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    LocationParams *loc = [locationsArray objectAtIndex:indexPath.row];
    cell.dateLabel.text = loc.dateString;
    cell.latlongLabel.text = [NSString stringWithFormat:@"%f,%f",loc.latitude,loc.longitude];
    cell.speedLabel.text = [NSString stringWithFormat:@"%d mph",2*loc.speed];
    return cell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return locationsArray.count;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
