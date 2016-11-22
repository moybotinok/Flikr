//
//  PhotoManager.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 21/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "PhotoManager.h"
#import "myFlickrPhoto.h"

@interface PhotoManager()


@end

@implementation PhotoManager

+(instancetype)sharedInstance {
    static PhotoManager *_photoManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _photoManager = [[PhotoManager alloc] init];
    });
    return _photoManager;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.flickrTags = @[@"cat",
                            @"dog",
                            @"spring"];
        self.allPhpotosOfAllTags = [[NSMutableDictionary alloc] init];
        for (NSString *tag in self.flickrTags) {
            [self.allPhpotosOfAllTags setObject:[NSMutableArray new] forKey:tag];
        }
    }
    return self;
}

-(void)addPhotoWithURL:(NSURL *)url
                 title:(NSString *)title
                   tag:(NSString *)tag
                 image:(UIImage *)image{
    
    myFlickrPhoto *photo = [[myFlickrPhoto alloc] initWithURL:url title:title];
    photo.image = image;
    [[self.allPhpotosOfAllTags objectForKey:tag] addObject:photo];

}

-(NSMutableArray *)takeAllPhotosForTag:(NSString *)tag {
    return [self.allPhpotosOfAllTags objectForKey:tag];
}
-(NSMutableArray *)takeAllFavoritePhotosForTag:(NSString *)tag {
    NSMutableArray *allPhotosForTag = [self.allPhpotosOfAllTags objectForKey:tag];
    NSMutableArray *result = [NSMutableArray new];
    for (myFlickrPhoto *photo in allPhotosForTag) {
        if (photo.faivorite) {
        [result addObject:photo];
        }
    }
    return result;
}

@end




