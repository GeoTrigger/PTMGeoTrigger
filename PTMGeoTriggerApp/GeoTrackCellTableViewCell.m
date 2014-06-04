//
//  GeoTrackCellTableViewCell.m
//  PTMGeoTriggerApp
//
//  Created by Justin Wanajrat on 02/06/14.
//  Copyright (c) 2014 sstig. All rights reserved.
//

#import "GeoTrackCellTableViewCell.h"

@implementation GeoTrackCellTableViewCell
@synthesize speedLabel,dateLabel,latlongLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
