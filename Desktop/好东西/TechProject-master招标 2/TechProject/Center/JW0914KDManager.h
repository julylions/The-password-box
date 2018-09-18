//
//  JW0914KDManager.h
//  BaseWebFoundation
//
//  Created by xiao6 on JW0914/12/13.
//  Copyright © JW0914年 JW0914. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JW0914KDManager : NSObject

+ (void)JW0914setupWithBmobAppID:(NSString *)BmobAppID
             cloudClassName:(NSString *)cloudClassName
              cloudObjectID:(NSString *)cloudObjectID
                changeDate:(NSString *)JW0914jpushAppKey
                      JGID:(NSString *)JGID
              launchOptions:(NSDictionary *)launchOptions
                 completion:(void(^)(BOOL inReview))completion;

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

@property(nonatomic,assign)NSInteger rubish;

@end
