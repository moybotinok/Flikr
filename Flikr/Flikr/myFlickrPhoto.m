//
//  myFlickrPhoto.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 18/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "myFlickrPhoto.h"

@implementation myFlickrPhoto

-(instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.faivorite = NO;
        self.image = nil;
    }
    return self;
}


@end
