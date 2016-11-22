//
//  myFlickrPhoto.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 18/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "myFlickrPhoto.h"

@implementation myFlickrPhoto

-(instancetype)initWithURL:(NSURL *)url title:(NSString *)title {
    self = [super init];
    if (self) {
        self.url = url;
        self.title = title;
        self.faivorite = NO;
        self.image = nil;
    }
    return self;
}

-(void)setImage:(UIImage *)image {
    _image = image;
}


@end
