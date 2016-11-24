//
//  MyImageSize.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 22/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "MyImageSize.h"

@implementation MyImageSize

+(CGRect)getGoodSizeForImage:(UIImage *)image inViewController:(UIViewController *)controller{
    CGFloat widthOfView = CGRectGetWidth(controller.view.frame);
    CGFloat heightOfNavigationBarAndStatusBar = CGRectGetMaxY(controller.navigationController.navigationBar.frame);
    CGFloat koefForScale = widthOfView / image.size.width ;
    
    CGRect result = CGRectMake(0.f,
                        heightOfNavigationBarAndStatusBar,
                        widthOfView,
                        image.size.height * koefForScale);
    return result;
}

@end
