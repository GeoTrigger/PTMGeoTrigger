//
//  GeoTrackCellTableViewCell.h
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeoTrackCellTableViewCell : UITableViewCell
@property(nonatomic,retain) IBOutlet UILabel *dateLabel;
@property(nonatomic,retain) IBOutlet UILabel *latlongLabel;
@property(nonatomic,retain) IBOutlet UILabel *speedLabel;
@end
