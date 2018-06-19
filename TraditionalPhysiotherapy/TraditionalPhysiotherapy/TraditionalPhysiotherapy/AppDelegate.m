//
//  AppDelegate.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2017/11/17.
//  Copyright © 2017年 Gu GuiJun. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    [self createDir];
    [DataBaseQueue createAllTable];
//    
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames )
//    {
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames )
//        {
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainViewController *mainVC = [[MainViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    [self.window setRootViewController:nav];
    
//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}
-(void)createDir
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:userDocumentPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:userDocumentPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:userHeadPicPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:userHeadPicPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:projectPicPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:projectPicPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:userSignPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:userSignPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:recordImagePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:recordImagePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:tempFilePath withIntermediateDirectories:NO attributes:nil error:nil];

    NSLog(@"userDocumentPath__path:%@",userDocumentPath);
    NSLog(@"userHeadPicPath__path:%@",userHeadPicPath);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
