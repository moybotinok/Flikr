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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createPhotoImageView];
    self.title = self.photo.title;
    [self createButtonFavorite];
    [self updateView];
}

-(void)createButtonFavorite {
    
    UIBarButtonItem * itemFavorite = [[UIBarButtonItem alloc] initWithTitle:@"+add"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(didSelectButtonFavorite)];

    self.navigationController.topViewController.navigationItem.rightBarButtonItem = itemFavorite;
    self.itemFavorite = itemFavorite;
    self.itemFavorite.enabled=TRUE;
}

-(void)didSelectButtonFavorite {
    self.photo.faivorite = !self.photo.faivorite;
    [self  updateView];
    
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
    //CGFloat navigationBatHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat koefForScale = self.view.frame.size.width / self.image.size.width ;
    CGFloat yFromNavigationBarAndStatusBar = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    //CGRect i = [MyImageSize getGoodSizeForImage:self.image];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,
                                                                   yFromNavigationBarAndStatusBar,
                                                                   self.view.frame.size.width,
                                                                   self.image.size.height * koefForScale)];
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
}



// loading photo from url
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
