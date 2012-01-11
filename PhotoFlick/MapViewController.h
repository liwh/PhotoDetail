//
//  MapViewController.h
//  PhotoFlick
//
//  Created by liwh on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class MapViewController;

@protocol MapViewControllerDelegate <NSObject>
-(UIImage *) mapViewController:(MapViewController *) sender imageForAnnotation: (id <MKAnnotation>) annotation;
@end

@interface MapViewController : UIViewController
@property(nonatomic,strong) NSArray *annotations;  // id <MKAnnotation>
@property(nonatomic,strong) id <MapViewControllerDelegate> delegate;
@end
