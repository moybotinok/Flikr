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

@interface LeftMenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menuTable;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    
    cell.textLabel.text = @"Interesting";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        
//   //     [revealViewController performSelector:@selector(revealToggle:)];
//        
////        [self.revialButton setTarget: self.revealViewController];
////        [self.revialButton setAction: @selector( revealToggle: )];
////        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    

//

//    CollectionViewController *vc = self.revealViewController.frontViewController ;
//    vc.title = @"Interesting";
//    [self.revealViewController pushFrontViewController:vc animated:YES];
    
    [self.revealViewController revealToggleAnimated:YES];
    
}




@end
