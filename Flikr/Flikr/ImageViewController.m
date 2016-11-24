//
//  ImageViewController.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "ImageViewController.h"
#import "myFlickrPhoto.h"
#import "MyImageSize.h"

@interface ImageViewController ()

@property (weak, nonatomic) UIBarButtonItem *itemFavorite;

@end

@implementation ImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createButtonFavorite];
    [self createPhotoImageView];
    [self updateView];
    self.title = self.photo.title;
}

-(void)createButtonFavorite {
    
    UIBarButtonItem * itemFavorite = [[UIBarButtonItem alloc] initWithTitle:@"+add"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(didSelectButtonFavorite)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = itemFavorite;
    self.itemFavorite = itemFavorite;
}

-(void)didSelectButtonFavorite {
    self.photo.faivorite = !self.photo.faivorite;
    [self updateView];
}

-(void)updateView {
    if (self.photo.faivorite) {
        self.view.backgroundColor = [UIColor yellowColor];
        self.itemFavorite.title = @"-del";
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.itemFavorite.title = @"+add";
    }
}

-(void)createPhotoImageView {
    UIImage *image = self.photo.image;
    CGRect rectForImage = [MyImageSize getGoodSizeForImage:image
                                          inViewController:self];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:rectForImage];
    imageView.image = image;
    [self.view addSubview:imageView];
}


//      loading photo from url
//-(void)startDownloadImage {
//    self.photoImage = nil;
//    if (self.photoURL) {
//        NSURLRequest *request = [NSURLRequest requestWithURL:self.photoURL];
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            if (!error) {
//                if ([request.URL isEqual:self.photoURL]) {
//                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.photoImage = image;
//                    });
//                }
//            }
//        }];
//        [task resume];
//    }
//}

@end
