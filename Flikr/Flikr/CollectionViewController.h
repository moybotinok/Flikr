//
//  CollectionViewController.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myFlickrPhoto;

#define COUNT_OF_PHOTOS_IN_VIEW 100

@interface CollectionViewController : UICollectionViewController

//@property (strong, nonatomic) NSMutableArray *allPhotos;
@property (strong, nonatomic) NSString *flickrTag;

-(void)addNewPhoto:(myFlickrPhoto *)photo withTag:(NSString *)tag;

@end
