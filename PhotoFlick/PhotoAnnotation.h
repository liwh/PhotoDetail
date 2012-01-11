//
//  PhotoAnnotation.h
//  PhotoFlick
//
//  Created by liwh on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PhotoAnnotation : NSObject <MKAnnotation>

+(PhotoAnnotation *) annotationForPhoto:(NSDictionary *)photo;
@property(strong,nonatomic)  NSDictionary *photo;
@end
