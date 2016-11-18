//
//  CollectionViewController.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSMutableArray *photoURLs;
@property (strong, nonatomic) NSMutableArray *allPhotos;

-(void)addNewPhoto:(UIImage *)photo;
-(void)updateURLs: (NSArray *)newURLs;

@end
