//
//  TPBaseViewController.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCommon1ViewHelper.h"
#import "TPCommonDefine.h"
#import <YYCategories.h>
#import "UIScrollView+TPRefresh.h"
@interface TPBaseViewController : UIViewController
- (void)showLoading;

- (void)hideLoading;

- (void)showNoDataView;

- (void)hideNoDataView;
@end
