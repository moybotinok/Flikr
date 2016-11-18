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

@interface CollectionViewController ()

@property (strong, nonatomic) NSArray *photoURLs;
@property (nonatomic) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revialButton;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRevialButtonOn];
    
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.allPhotos = [NSMutableArray array];
    MyFlickrSpeaker *myFlickerSpeaker = [[MyFlickrSpeaker alloc] initWithViewController:self];
    self.photoURLs = [[myFlickerSpeaker allPhotoURLs] copy];
    //self.allPhotos = [[myFlickerSpeaker allPhotos] copy];
    // Uncomment the following line to preserve selection between presentations
    //self.clearsSelectionOnViewWillAppear = NO;
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
-(NSMutableArray *)allPhotos {
//    if (self) {
//        [self.collectionView reloadData];
//    }
    return _allPhotos;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoURLs.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[PhotoCell alloc] init];
    }
    // Configure the cell
    
    //UIActivityIndicatorView *spiner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //spiner.hidden = NO;
    

    
//    NSURL *url = self.photoURLs[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
//    __block UIImage *photo = nil;
//    dispatch_queue_t gettingPhoto = dispatch_queue_create("getphoto", NULL);
//    dispatch_async(gettingPhoto, ^{
//        photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [imageView setImage:photo];
//            [cell addSubview:imageView];
//            //spiner.hidden = YES;
//        });
//        
//    });
    

//
    UIImage *image = [UIImage new];
    if (indexPath.row < self.allPhotos.count) {
        image = self.allPhotos[indexPath.row]; //[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        imageView.image = image;
    } else {
        image = [UIImage imageNamed:@"menu"];
    }
    
    if (cell.subviews.count == 2) {
        ((UIImageView *)cell.subviews[1]).image = image;
    } else {
        [cell addSubview:imageView];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toImage"]) {
        if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
            ImageViewController *vc = segue.destinationViewController;
            UIImage *sendingImage = self.allPhotos[self.currentIndex];
            vc.image = sendingImage;//self.allPhotos[self.currentIndex];
            ///
            if (![segue isKindOfClass:[MyCustomSegueToImage class]]) {
                return;
            }
            MyCustomSegueToImage *imageSegue = (MyCustomSegueToImage *)segue;

            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath: [NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
            imageSegue.transitionImage =  self.allPhotos[self.currentIndex];
            
            CGFloat navigationBatHeight = self.navigationController.navigationBar.frame.size.height;
            CGFloat k = self.view.frame.size.width / sendingImage.size.width ;
            CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
            CGRect cellFrame = cell.frame;
            CGRect frameInSuperView = [self.collectionView convertRect:cellFrame toView:[self.collectionView superview]];
            
            imageSegue.sourceRect = frameInSuperView;
            imageSegue.destinationRect = CGRectMake(0.f, y, self.view.frame.size.width, navigationBatHeight + sendingImage.size.height * k);
        }
    }
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.item;
    
    [self performSegueWithIdentifier:@"toImage" sender:self];
}

@end
