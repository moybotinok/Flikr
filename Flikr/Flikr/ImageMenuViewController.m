//
//  ViewController.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 14/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "ImageMenuViewController.h"
#import "ImageViewController.h"
#import "FlickrKit.h"

@interface ImageMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonWithImage;

@end

@implementation ImageMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)buttonWithImagePressed:(id)sender {
    [self performSegueWithIdentifier:@"toImage" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toImage"]) {
        if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
            
        }
    }
}

@end
