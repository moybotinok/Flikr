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

@interface MyFlickrSpeaker ()

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSMutableArray *photoURLs;
@property (strong, nonatomic) NSDictionary *all;
@property (strong, nonatomic) CollectionViewController *collectionViewController;
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

-(NSArray *)allPhotoURLs {
    NSMutableArray *photoURLs = [NSMutableArray array];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
        FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
        [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
            // Note this is not the main thread!
            if (response) {
                // NSMutableArray *photoURLs = [NSMutableArray array];
                //self.all = [response copy];
    
                for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                    NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                    //NSString *phototitle = [photoData valueForKey:@"title"];
                    
                    [photoURLs addObject:url];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Any GUI related operations here
//                    if (self.photoURLs.count > 0) {
//                        NSURL *url = self.photoURLs[0];
//                        self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                   // }
                    dispatch_semaphore_signal(sema);
                });
            }
        }];

    
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:100]];
    }
    self.photoURLs = [photoURLs copy];
    [self allPhotos];
    return photoURLs;
}

-(void)allPhotos {
    //    NSMutableArray *allPhotos = [[NSMutableArray alloc] init];
    //    int i = 0;
    //    for (NSURL *url in self.allPhotoURLs) {
    //        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //        NSLog(@"%@", NSStringFromCGSize(image.size));
    //        [allPhotos addObject:image];
    //        i++;
    //        if (i>7) break;
    //    }
    
    
        __block UIImage *photo = nil;
        dispatch_queue_t gettingPhoto = dispatch_queue_create("getphoto", NULL);
        dispatch_async(gettingPhoto, ^{
            
            for (NSURL *url in self.photoURLs) {
                photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionViewController.allPhotos addObject:photo];
                    NSLog(@"photo +");
                });
            }
        });

    
    
}



//- (void)getPhotoFromFlickr:(UIImageView *)imageView {
//    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"4df385f777a0ae9361158cc0a970ab67" sharedSecret:@"f1dea1e18baeb19a"];
//    
//    self.photoURLs = [NSMutableArray array];
//    
//    
//    FlickrKit *fk = [FlickrKit sharedFlickrKit];
//    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
//    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
//        // Note this is not the main thread!
//        if (response) {
//            // NSMutableArray *photoURLs = [NSMutableArray array];
//            self.all = [response copy];
//            
//            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
//                NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
//                //NSString *s = [photoData valueForKey:@"title"];
//                [self.photoURLs addObject:url];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // Any GUI related operations here
//                if (self.photoURLs.count > 0) {
//                    NSURL *url = self.photoURLs[0];
//                    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//                    [imageView setImage:self.image];
//                }
//            });
//        }
//    }];
//    
//    
//}


@end
