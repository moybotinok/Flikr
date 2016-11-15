//
//  MyFlickrSpeaker.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MyFlickrSpeaker.h"
#import "FlickrKit.h"

@interface MyFlickrSpeaker ()

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSMutableArray *photoURLs;
@property (strong, nonatomic) NSDictionary *all;
@end

@implementation MyFlickrSpeaker


- (void)getPhotoFromFlickr:(UIImageView *)imageView {
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"4df385f777a0ae9361158cc0a970ab67" sharedSecret:@"f1dea1e18baeb19a"];
    
    self.photoURLs = [NSMutableArray array];
    
    
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
        // Note this is not the main thread!
        if (response) {
            // NSMutableArray *photoURLs = [NSMutableArray array];
            self.all = [response copy];
            
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                //NSString *s = [photoData valueForKey:@"title"];
                [self.photoURLs addObject:url];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // Any GUI related operations here
                if (self.photoURLs.count > 0) {
                    NSURL *url = self.photoURLs[0];
                    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                    [imageView setImage:self.image];
                }
            });
        }
    }];
    
    
}


@end
