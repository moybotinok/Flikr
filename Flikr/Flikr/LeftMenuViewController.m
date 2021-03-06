//
//  LeftMenuViewController.m
//  Flikr
//
//  Created by Татьяна Бочарникова on 15/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SWRevealViewController.h"
#import "CollectionViewController.h"
#import "PhotoManager.h"


@interface LeftMenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (strong, nonatomic) NSArray *flickrTags;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flickrTags = [[PhotoManager sharedInstance] flickrTags];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.flickrTags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    cell.textLabel.text = self.flickrTags[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.revealViewController.frontViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self.revealViewController.frontViewController;
        if ([navigationController.viewControllers.firstObject isKindOfClass:[CollectionViewController class]]) {
            CollectionViewController *cvc = navigationController.viewControllers.firstObject;
            cvc.flickrTag = self.flickrTags[indexPath.row];
        }
    }
    [self.revealViewController revealToggleAnimated:YES];
}

@end
