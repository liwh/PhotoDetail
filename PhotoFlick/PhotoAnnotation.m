//
//  PhotoAnnotation.m
//  PhotoFlick
//
//  Created by liwh on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhotoAnnotation.h"
#import "FlickrFetcher.h"

@implementation PhotoAnnotation
@synthesize photo = _photo;
+(PhotoAnnotation *) annotationForPhoto:(NSDictionary *)photo
{
    PhotoAnnotation *annotation = [[PhotoAnnotation alloc] init];
    annotation.photo = photo;
    return annotation;
}

-(NSString *) title
{
    return [self.photo objectForKey:FLICKR_PHOTO_TITLE];
}

-(NSString *)subtitle
{
    return [self.photo objectForKey:FLICKR_PHOTO_OWNER];
}

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.photo objectForKey:FLICKR_LATITUDE] doubleValue];
    coordinate.longitude  = [[self.photo objectForKey:FLICKR_LONGITUDE] doubleValue];
    return coordinate;
}
@end
