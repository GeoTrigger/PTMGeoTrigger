//
//  ViewController.h
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoTrackCellTableViewCell.h"
#import "DataModel.h"
#import "LocationViewController.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *geoFenceTable;
    NSMutableArray *locationsArray;
    NSMutableArray *datesArray;
    NSArray *sortedArray;
    NSMutableArray *sortedDatesArray;
    NSMutableDictionary *locDict;
}
-(void) reloadTableContents;
@end
