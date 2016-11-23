//
//  CollectionViewController.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "CollectionViewController.h"
#import "ImageViewController.h"
#import "MyFlickrSpeaker.h"
#import "PhotoCell.h"
#import "SWRevealViewController.h"
#import "MyCustomSegueToImage.h"
#import "myFlickrPhoto.h"
#import "PhotoManager.h"
#import "myFlickrPhoto.h"

@interface CollectionViewController ()


@property (nonatomic) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revialButton;
@property (strong, nonatomic) MyFlickrSpeaker *myFlickerSpeaker;
@property (strong, nonatomic) PhotoManager *photoManager;
@property (nonatomic) BOOL isFavorute;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFavorute = FALSE;
    [self setRevialButtonOn];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.allPhotos = [NSMutableArray array];
    self.myFlickerSpeaker = [[MyFlickrSpeaker alloc] initWithViewController:self];
    self.flickrTag = @"cat";
    self.photoManager = [PhotoManager sharedInstance];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addToolbar];
}


-(void)setRevialButtonOn {
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revialButton setTarget: self.revealViewController];
        [self.revialButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

-(void)setFlickrTag:(NSString *)flickrTag {
    self.isFavorute = NO;
    if (_flickrTag != flickrTag) {
        _flickrTag = flickrTag;
        [self.allPhotos removeAllObjects];
        [self.collectionView reloadData];
        NSMutableArray *allPhotosForCurrentTag = [self.photoManager.allPhpotosOfAllTags objectForKey:flickrTag];
        if (allPhotosForCurrentTag.count == 0) {
            [self.myFlickerSpeaker allPhotoForTag:flickrTag];
        } else {
            self.allPhotos = [allPhotosForCurrentTag mutableCopy];
        }
    }
    NSLog(@"TAG = %@", self.flickrTag);
    
}

-(void)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    NSMutableArray *items = [NSMutableArray new];
    UIBarButtonItem *itemPhoto = [[UIBarButtonItem alloc] initWithTitle:@"Photo"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(toolBarDidSelectItemPhoto:)];

    UIBarButtonItem *itemFavorite = [[UIBarButtonItem alloc] initWithTitle:@"Faivorite"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(toolBarDidSelectItemFaivorite:)];
    [itemPhoto setWidth:self.view.frame.size.width / 2];
    [itemFavorite setWidth:self.view.frame.size.width / 2];
    [items addObject:itemPhoto];
    [items addObject:itemFavorite];
    [toolbar setItems:items animated:NO];
    [self.view addSubview:toolbar];
}

-(void)toolBarDidSelectItemPhoto:(id)sender {
    
    self.isFavorute = NO;
    self.allPhotos = [[self.photoManager takeAllPhotosForTag:self.flickrTag] mutableCopy];
    [self.collectionView reloadData];
    
}

-(void)toolBarDidSelectItemFaivorite:(id)sender {
    self.isFavorute = YES;
    self.allPhotos = [[self.photoManager takeAllFavoritePhotosForTag:self.flickrTag] mutableCopy];
    [self.collectionView reloadData];
}

-(void)addNewPhoto:(myFlickrPhoto *)photo withTag:(NSString *)tag {
    if (tag == self.flickrTag && !self.isFavorute ) {
        [self.allPhotos addObject:photo];
        NSInteger x = self.allPhotos.count-1;
        if ([self.collectionView numberOfItemsInSection:0] > x) {
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:x inSection:0]]];
        } else {
            [self.collectionView reloadData];
        }
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.allPhotos.count < 100 && self.isFavorute == NO) {
        return 100;
    } else {
        return self.allPhotos.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    UIImage *image = [UIImage new];
    if (indexPath.row < self.allPhotos.count) {
        myFlickrPhoto *photo = self.allPhotos[indexPath.row];
        image =photo.image;
        
        imageView.image = image;
        imageView = [self prepareImageView:imageView withImage:image];
        
    } else {
        imageView.image = [UIImage imageNamed:@"questionMark"];
    }
    
    if (cell.subviews.count == 2) {
        ((UIImageView *)cell.subviews[1]).image = image;
        [[cell.subviews lastObject] removeFromSuperview];
    }
    [cell addSubview:imageView];
    
    return cell;
}

-(UIImageView *)prepareImageView:(UIImageView *)imageView withImage:(UIImage *)image {
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toImage"]) {
        if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
            ImageViewController *vc = segue.destinationViewController;
            myFlickrPhoto *photo = self.allPhotos[self.currentIndex];
            
            UIImage *sendingImage = photo.image;
            vc.image = sendingImage;
            
            vc.photo = photo;
            
            if ([segue isKindOfClass:[MyCustomSegueToImage class]]) {
                MyCustomSegueToImage *myCustomSegueToImage = (MyCustomSegueToImage *)segue;

                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath: [NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
                CGRect cellFrame = cell.frame;
                CGRect cellframeInSuperView = [self.collectionView convertRect:cellFrame toView:[self.collectionView superview]];
                
                CGFloat k = self.view.frame.size.width / sendingImage.size.width ;
                CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
                
                myCustomSegueToImage.transitionImage =  photo.image;
                myCustomSegueToImage.sourceRect = cellframeInSuperView;
                myCustomSegueToImage.destinationRect = CGRectMake(0.f, y, self.view.frame.size.width, sendingImage.size.height * k);
            }
        }
    }
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.allPhotos.count > indexPath.item)
    {
        self.currentIndex = indexPath.item;
        [self performSegueWithIdentifier:@"toImage" sender:self];
    }
}

@end
