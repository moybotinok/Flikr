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

@property (strong, nonatomic) myFlickrPhoto *photo;

@end
