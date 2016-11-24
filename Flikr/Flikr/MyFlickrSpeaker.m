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
#import "CollectionViewController.h"
#import "PhotoManager.h"

@interface MyFlickrSpeaker ()

@property (weak, nonatomic) CollectionViewController *collectionViewController;

@end

@implementation MyFlickrSpeaker

-(instancetype)initWithViewController:(CollectionViewController *)vc {
    self = [super init];
    if (self) {
        [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"4df385f777a0ae9361158cc0a970ab67" sharedSecret:@"f1dea1e18baeb19a"];
        self.collectionViewController = vc;
    }
    return self;
}

-(void)allPhotoForTag:(NSString *)tag {
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    if (!tag) {
        tag = [[PhotoManager sharedInstance].flickrTags firstObject];
        if (!tag) {
            tag = @"cat"; // that would not have happened, load cats!
        }
    }
    NSString *per_page = [NSString stringWithFormat:@"%d",COUNT_OF_PHOTOS_IN_VIEW];
    NSMutableDictionary *uploadArgs = [[NSMutableDictionary alloc] initWithDictionary:  @{@"tags": tag, @"per_page": per_page}];
    [[FlickrKit sharedFlickrKit] call:@"flickr.photos.search"
                                 args:uploadArgs
                          maxCacheAge:FKDUMaxAgeOneHour
                           completion:^(NSDictionary *response, NSError *error) {
        if (response) {
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                NSURL * url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                NSString * photoTitle = [photoData valueForKey:@"title"];
                UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    PhotoManager *photoManager = [PhotoManager sharedInstance];
                    [photoManager addPhotoWithURL:url
                                            title:photoTitle
                                              tag:tag
                                            image:image];
                    NSArray *array = [photoManager takeAllPhotosForTag:tag];
                    [self.collectionViewController addNewPhoto:array.lastObject withTag:tag];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        } else {
            NSLog(@"Error with Flickr response");
        }
    }];
}

@end
