//
//  ImageViewController.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <UIKit/UIKit.h>

@class myFlickrPhoto;

@interface ImageViewController : UIViewController

//@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) myFlickrPhoto *photo;

@end
