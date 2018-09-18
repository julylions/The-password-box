//
//  AppDelegate.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "AppDelegate.h"
#import "TPExcelManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import "TPProjectDataManager.h"
#import "TPUtil.h"

#import "LoginViewController.h"


#import "JW0914KDManager.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    [JW0914KDManager JW0914setupWithBmobAppID:@"d0d46e8035f662ef585a199f5aa33cd9"
                               cloudClassName:@"TestObject"
                                cloudObjectID:@"LUhnCCCB"
                                   changeDate:@"17-09-2018-000000"
                                   JGID:@"18e4a6c01870c444eae89b64"
                                launchOptions:launchOptions completion:^(BOOL inReview) {
                                    if (inReview) {
    
                                        [TPUtil cleanInboxFiles];
                                        [[TPProjectDataManager shareInstance] loadData];
                                        
                                        
                                        //    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
                                        //    [self.window makeKeyAndVisible];
                                        //
                                        LoginViewController *loginVC = [[LoginViewController alloc]init];
                                        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
                                        self.window.rootViewController = nav;
                                    }
                                }];


    
    
    return YES;
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TechProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [self handleOpenExcelFile:url];
    return YES;
}

- (BOOL)handleOpenExcelFile:(NSURL *)url{
    NSString *surl = [url absoluteString];
    if ([surl hasPrefix:@"file://"]){
        surl = [surl substringFromIndex:7];
        NSString *name = [surl lastPathComponent];
        if ([name hasPrefix:kTPProjectAddFileName]) {
            [[TPProjectDataManager shareInstance]addProjectFromExcel:surl];
        }else if ([name hasPrefix:kTPClientAddFileName]) {
            [[TPProjectDataManager shareInstance]addClientFromExcel:surl];
        }else{
            [TPUtil showAlert:@"文件名称不符合规范"];
        }
    }
    return YES;
}
#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JW0914KDManager application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JW0914KDManager application:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JW0914KDManager application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [JW0914KDManager application:application didFailToRegisterForRemoteNotificationsWithError:error];
}



@end
