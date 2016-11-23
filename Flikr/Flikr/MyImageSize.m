//
//  MyImageSize.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 22/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "MyImageSize.h"

@implementation MyImageSize

+(CGRect)getGoodSizeForImage:(UIImage *)image {
    CGRect result = CGRectZero;
    
    
    UIWindow *firstWindow = [[UIApplication sharedApplication].windows firstObject];
    CGFloat widthOfRootWindow = firstWindow.rootViewController.view.frame.size.width;
    CGFloat yFromNavigationBarAndStatusBar = CGRectGetMaxY( firstWindow.inputViewController.navigationController.navigationBar.frame);
    CGFloat koefForScale = widthOfRootWindow / image.size.width ;
    
    result = CGRectMake(0.f,
                        yFromNavigationBarAndStatusBar,
                        widthOfRootWindow,
                        image.size.height * koefForScale);
    return result;
}

@end
