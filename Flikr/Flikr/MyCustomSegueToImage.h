//
//  MyCustomSegueToImage.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 16/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomSegueToImage : UIStoryboardSegue

@property(assign, nonatomic) BOOL unwinding;

@property(assign, nonatomic) CGRect sourceRect;
@property(assign, nonatomic) CGRect destinationRect;

@property(strong, nonatomic) UIImage *transitionImage;

@end
