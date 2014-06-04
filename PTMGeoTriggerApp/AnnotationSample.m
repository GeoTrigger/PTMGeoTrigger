//
//  AnnotationSample.m
//  MapSample
//
//  Created by Justin Wanajrat on 15/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnnotationSample.h"

@implementation AnnotationSample
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
- (NSString *)title

{
	return title;

}
-(NSString*)subtitle
{
	return subtitle;
}
	
-(void)addAnotation:(NSString*)title1 andSubTitle:(NSString*)subTitle1
{
	title = title1;
	subtitle=subTitle1;
}


@end
