//
//  MyCustomSegueToImage.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 16/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "MyCustomSegueToImage.h"
#import "ImageViewController.h"


@interface MyCustomSegueToImage ()

@property (strong, nonatomic) UIImageView *transitionImageView;

@end

@implementation MyCustomSegueToImage

- (id) initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        _unwinding = NO;
        _destinationRect = CGRectZero;
    }
    return self;
}

- (UIImageView *) transitionImageView {
    if (! _transitionImageView) {
        _transitionImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _transitionImageView;
}

- (void) perform {
    
    CGFloat duraction = 0.5f;
    
    UIViewController *destinationController = (UIViewController *)[self destinationViewController];
    UIViewController *sourceViewController = (UIViewController *)[self sourceViewController];
    self.destinationViewController.view.hidden = YES;
    
    //      ctreate View for background
    UIViewController *parentViewController =  self.sourceViewController.parentViewController;
    CGRect rectForBackImage = self.sourceViewController.view.frame;
    UIView *imageForBack = [[UIView alloc] initWithFrame:rectForBackImage];
    imageForBack.backgroundColor = destinationController.view.backgroundColor;
    [parentViewController.view addSubview:imageForBack];
    [parentViewController.view sendSubviewToBack:imageForBack];
    
    //      create image moving
    UIWindow *mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    CGRect sourceRectInWindow = [mainWindow convertRect:self.sourceRect fromView:sourceViewController.view];
    UIImageView *imageView = self.transitionImageView;
    imageView.image = self.transitionImage;
    imageView.frame = sourceRectInWindow;
    [mainWindow addSubview:imageView];
    
    //      prepare destination rect
    CGRect dest = self.destinationRect;
    if (CGRectEqualToRect(dest, CGRectZero)) {
        
        CGSize transitionSize = self.transitionImage.size;
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        
        CGFloat factor = fminf(
                               CGRectGetWidth(screenBounds) / self.transitionImage.size.width,
                               CGRectGetHeight(screenBounds) / self.transitionImage.size.height
                               );
        
        dest.size = CGSizeMake(transitionSize.width * factor, transitionSize.height * factor);
        dest.origin = CGPointMake(
                                  roundf((CGRectGetWidth(screenBounds) - CGRectGetWidth(dest)) / 2.0f),
                                  roundf((CGRectGetHeight(screenBounds) - CGRectGetHeight(dest)) / 2.0f)
                                  );
    } else {
        UIView *sourceView = sourceViewController.view;
        dest = [sourceView convertRect:dest toView:sourceView.window];
    }
    //      animation for source controller
    CATransition* transition = [CATransition animation];
    transition.duration = duraction;
    transition.type = kCATransitionFade;
    [sourceViewController.view.layer addAnimation:transition forKey:kCATransitionFromTop];
    [sourceViewController.navigationController.view.layer addAnimation:transition forKey:kCATransitionFromTop];
    
    //      animation for moving image
    [UIView animateWithDuration:duraction delay:.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.frame = dest;
        //  something strange for unwind OR if there is no navigation controller
        //        if (self.unwinding) {
        //            [self.destinationViewController dismissViewControllerAnimated:YES completion:nil];
        //        } else {
        //            ((UIViewController *)self.destinationViewController).modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //            [self.sourceViewController presentViewController:self.destinationViewController animated:YES completion:nil];
        //        }
    } completion:^(BOOL completed) {
        //delete temporary views
        [imageView removeFromSuperview];
        [imageForBack removeFromSuperview];
        destinationController.view.hidden = NO;
    }];
    
    //      play with animation
    
    //    [UIView animateWithDuration:1.f
    //                          delay:0.f
    //         usingSpringWithDamping:2.f
    //          initialSpringVelocity:12.1f
    //                        options:0
    //                     animations:^{
    //                         imageView.frame = dest;
    //
    //                     } completion:^(BOOL completed) {
    //                         imageView.hidden = YES;
    //                         [imageView removeFromSuperview];
    //
    //                         UIViewController *destinationController = (UIViewController *)[self destinationViewController];
    //                         [self.sourceViewController.navigationController pushViewController:destinationController animated:NO];
    //
    //                     }];
    
    //      for navigation controller;
    [self.sourceViewController.navigationController pushViewController:destinationController animated:NO];
}

//      play with segue

//-(void)perform {
//    UIViewController *sourceViewController = (UIViewController *)[self sourceViewController];
//    UIViewController *destinationController = (UIViewController *)[self destinationViewController];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 2.25;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    //kCATransitionPush - выезжает снизу, вытесняя предыдущий наврех
//    //kCATransitionMoveIn - выезжает снизу, заезжая на нижний и постепенно теряет прозрачность
//    //kCATransitionReveal - нижний уезжает наверх, постепенно преобретая прозрачность
//    //kCATransitionFade - появляется на нижнем и постепеено теряет прозрачность
//    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    [sourceViewController.navigationController.view.layer addAnimation:transition
//                                                                forKey:kCATransition];
//    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
//}

@end
