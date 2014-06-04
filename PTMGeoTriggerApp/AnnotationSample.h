//
//  AnnotationSample.h
//  MapSample
//
//  Created by Justin Wanajrat on 15/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface AnnotationSample : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy)  	NSString *title;
@property (nonatomic, copy) 	NSString *subtitle;

-(void)addAnotation:(NSString*)title1 andSubTitle:(NSString*)subTitle1;



	

@end
