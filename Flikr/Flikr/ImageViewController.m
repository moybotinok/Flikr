//
//  ImageViewController.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (strong, nonatomic) UIImage *photoImage;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *downloadIndicator;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPhotoImageView];
    //self.photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    [self startDownloadImage];
}

-(void)setPhotoImage:(UIImage *)photoImage {
    _photoImage = photoImage;
    self.imageView.image = self.photoImage;
    [self.downloadIndicator stopAnimating];
}


-(void)createPhotoImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height / 2.0)];
    self.imageView.image = self.photoImage;
    [self.view addSubview:self.imageView];
}

-(void)startDownloadImage {
    
    self.photoImage = nil;
    if (self.photoURL) {
        [self.downloadIndicator startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.photoURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                if ([request.URL isEqual:self.photoURL]) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.photoImage = image;
                    });
                }
            }
        }];
        [task resume];
    }
    
}


@end
