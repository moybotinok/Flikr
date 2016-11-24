//
//  MyCustomSegueToImage.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 16/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "MyCustomSegueToImage.h"
#import "ImageViewController.h"


@implementation MyCustomSegueToImage

- (id) initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        _destinationRect = CGRectZero;
        _sourceRect = CGRectZero;
    }
    return self;
}

- (void) perform {
    
    CGFloat duraction = 0.3f;
    UIViewController *destinationController = (UIViewController *)[self destinationViewController];
    UIViewController *sourceViewController = (UIViewController *)[self sourceViewController];
    self.destinationViewController.view.hidden = YES;
    
    //      ctreate View for background
    UIViewController *parentViewController =  self.sourceViewController.parentViewController;
    CGRect rectForBackImage = self.sourceViewController.view.frame;
    UIView *imageForBack = [[UIView alloc] initWithFrame:rectForBackImage];
    imageForBack.backgroundColor = destinationController.view.backgroundColor;
    [parentViewController.view addSubview:imageForBack];
    
    //      create image moving
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.sourceRect];
    imageView.image = self.transitionImage;
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [mainWindow addSubview:imageView];
    
    //      animation for source controller
    CATransition* transition = [CATransition animation];
    transition.duration = duraction;
    transition.type = kCATransitionFade;
    [sourceViewController.view.layer addAnimation:transition forKey:kCATransitionFromTop];
    [sourceViewController.navigationController.view.layer addAnimation:transition forKey:kCATransitionFromTop];
    
    //      animation for moving image
    [UIView animateWithDuration:duraction
                          delay:.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        imageView.frame = self.destinationRect;
    } completion:^(BOOL completed) {
        //delete temporary views
        [imageView removeFromSuperview];
        [imageForBack removeFromSuperview];
        destinationController.view.hidden = NO;
    }];

    [self.sourceViewController.navigationController pushViewController:destinationController animated:NO];
}

@end
