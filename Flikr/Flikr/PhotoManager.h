//
//  PhotoManager.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 21/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class myFlickrPhoto;

@interface PhotoManager : NSObject

@property (strong, nonatomic) NSArray *flickrTags;
@property (strong, nonatomic) NSMutableDictionary *allPhpotosOfAllTags;

+(PhotoManager *)sharedInstance;

-(void)addPhotoWithURL:(NSURL *)url
                 title:(NSString *)title
                   tag:(NSString *)tag
                 image:(UIImage *)image;

-(NSMutableArray *)takeAllPhotosForTag:(NSString *)tag;

-(NSMutableArray *)takeAllFavoritePhotosForTag:(NSString *)tag;

@end
