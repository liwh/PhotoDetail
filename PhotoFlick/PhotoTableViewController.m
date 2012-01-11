//
//  PhotoTableViewController.m
//  PhotoFlick
//
//  Created by liwh on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhotoTableViewController.h"
#import "FlickrFetcher.h"
#import "MapViewController.h"
#import "PhotoAnnotation.h"

@implementation PhotoTableViewController
@synthesize photos = _photos;

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL );
    dispatch_async(downloadQueue, ^{
        NSArray *photos = [FlickrFetcher recentGeoreferencedPhotos];  
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem = sender;
            self.photos = photos;
        });
    });
}

-(NSArray *) mapAnnotations
{
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:[self.photos count]];
    for (NSDictionary *photo in self.photos) {
        [annotations addObject:[PhotoAnnotation annotationForPhoto:photo]];
    }
         return annotations;
}
-(void)updateSplitViewDetail
{
    id detail = [self.splitViewController.viewControllers lastObject];
    if ([detail isKindOfClass:[MapViewController class]]) {
        MapViewController *mapVC = (MapViewController *)detail;
        mapVC.annotations = [self mapAnnotations];
    }
}
-(void)setPhotos:(NSArray *)photos
{
    if (_photos != photos) {
        _photos = photos ;
        [self updateSplitViewDetail];
        if(self.tableView.window) [self.tableView reloadData];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *photos = [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text  = [photos objectForKey:FLICKR_PHOTO_TITLE]; //设置行的标题
    cell.detailTextLabel.text = [photos objectForKey:FLICKR_PHOTO_OWNER]; //设置行的副标题
    return cell;
}



@end
