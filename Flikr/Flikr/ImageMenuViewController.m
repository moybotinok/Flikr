//
//  ViewController.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 14/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "ImageMenuViewController.h"
#import "FlickrKit.h"

@interface ImageMenuViewController ()

@end

@implementation ImageMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"4df385f777a0ae9361158cc0a970ab67" sharedSecret:@"f1dea1e18baeb19a"];
}




@end
