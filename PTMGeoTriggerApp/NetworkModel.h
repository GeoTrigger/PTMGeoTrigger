//
//  NetworkModel.h
//  Tutor
//
//  Created by Justin Wanajrat on 25/01/13.
//  Copyright (c) 2013 SSTIG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "CustomLocationManager.h"

@interface NetworkModel : NSObject
{
   
    
}
 -(void)sendCornStopMessage;
-(void)sendcornStartMessage;
-(void)sendTerminateMessage;
+(NetworkModel *)sharedNetworkModel;
@end

