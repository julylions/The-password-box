//
//  MJTouchId.h
//  MJAccount
//
//  Created by YXCZ on 17/8/11.
//  Copyright © 2017年 JingJing_Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用户是否 想使用touchID解锁，这个配置，保存在NSUserDefaults。
 */
#ifndef KEY_UserDefaults_isTouchIdEnabledOrNotByUser

     #define KEY_UserDefaults_isTouchIdEnabledOrNotByUser @"KEY_UserDefaults_isTouchIdEnabledOrNotByUser"
#endif

/// 指纹解锁
@interface MJTouchId : NSObject{
    ///应用程序名字
    @private NSString * _appName;
}
///解释校验指纹的原因
@property (nonatomic,strong) NSString * reasonThatExplainAuthentication;
///如果用户拒绝使用touchID解锁，则 显示提醒。
@property (nonatomic, strong) NSString * alertMessageToShowWhenUserDisableTouchID;

/// 单例
+ (instancetype)sharedInstance;

/**
 保存用户配置：用户是否 想使用touchID解锁
 */
- (void)save_TouchIdEnabledOrNotByUser_InUserDefaults:(BOOL)isEnabled;
/**
 读取用户配置：用户是否 想使用touchID解锁
 */
- (BOOL)isTouchIdEnabledOrNotByUser;
/**
 iOS 操作系统：是否 能够使用touchID解锁
 */
- (BOOL)isTouchIdEnabledOrNotBySystem;



/**
 能否 进行校验指纹(即，指纹解锁)
 内部逻辑：isTouchIdEnabledOrNotByUser && isTouchIdEnabledOrNotBySystem
 */
- (BOOL)canVerifyTouchID;

/**
 *  校验指纹(即，指纹解锁)
 *  canVerifyTouchID 返回YES，才能调用 startVerifyTouchID。
 *
 *  @param completionBlock 块，当校验手势密码成功之后，在主线程执行。
 */
- (void)startVerifyTouchID:(void (^)(void))completionBlock;
@end
