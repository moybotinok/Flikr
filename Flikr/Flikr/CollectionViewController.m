//
//  CollectionViewController.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "CollectionViewController.h"
#import "ImageViewController.h"
//#import "FlickrKit.h"
#import "MyFlickrSpeaker.h"
#import "PhotoCell.h"
#import "SWRevealViewController.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSArray *photoURLs;
@property (nonatomic) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revialButton;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"FlickrCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    MyFlickrSpeaker *myFlickerSpeaker = [[MyFlickrSpeaker alloc] init];
    self.photoURLs = [[myFlickerSpeaker allPhotoURLs] copy];
    [self setRevialButtonOn];
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
    // Configure the cell
    NSURL *imageURL = self.photoURLs[indexPath.row];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    [imageView setImage:image];
    
    cell.backgroundColor = [UIColor redColor];
    [cell addSubview:imageView];
    //cell.photoImageView.image = image;
    
    //cell.backgroundView = imageView;
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toImage"]) {
        if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
            ImageViewController *vc = segue.destinationViewController;
            vc.photoURL = self.photoURLs[self.currentIndex];
                
        }
    }
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.item;
    [self performSegueWithIdentifier:@"toImage" sender:self];
}




@end
