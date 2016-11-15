//
//  AppDelegate.h
//  Flikr
//
//  Created by Татьяна Бочарникова on 14/11/2016.
//  Copyright © 2016 Татьяна Бочарникова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

