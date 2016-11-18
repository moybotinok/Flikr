//
//  myFlickrPhoto.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 18/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface myFlickrPhoto : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) BOOL faivorite;

-(instancetype)initWithTitle:(NSString *)title;

@end
