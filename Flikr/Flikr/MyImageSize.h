//
//  MyImageSize.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 22/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyImageSize : NSObject

+(CGRect)getGoodSizeForImage:(UIImage *)image inViewController:(UIViewController *)controller;

@end
