//
//  TPProjectDetailModel.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/15.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "TPBase4Model.h"
#import "TPProjectModel.h"
@interface TPProjectInfoItem: NSObject
@property (nonatomic, strong) TPProjectModel *model;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSAttributedString *info;
@property (nonatomic, assign) CGFloat height;

- (void)setInfoString:(NSString *)info;
@end

@interface TPProjectInfoNameItem: NSObject
@property (nonatomic, strong) TPProjectModel *model;
@property (nonatomic, copy)NSString *title;
@end

@interface TPProjectDetailModel : TPBase4Model

@end
