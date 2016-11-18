//
//  MyFlickrSpeaker.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CollectionViewController;

@interface MyFlickrSpeaker : NSObject

-(instancetype)initWithViewController:(CollectionViewController *)vc;
    -(NSArray *)allPhotoURLs;

@end
