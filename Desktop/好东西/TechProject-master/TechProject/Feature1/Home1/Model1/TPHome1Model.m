//
//  TPHome1Model.m
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import "TPHome1Model.h"
#import "TPExcelManager.h"
#import "TPProjectDataManager.h"

@implementation TPHomeRegionItem

@end

@implementation TPHome1Model

- (void)loadItems:(NSDictionary *)dict completion:(void (^)(NSDictionary *))completion failure:(void (^)(NSError *))failure{
    NSArray *regionArr = [TPProjectDataManager shareInstance].regionArr;
    NSMutableArray *arr = [NSMutableArray array];
    for (TPProjectRegionModel *model in regionArr) {
        TPHomeRegionItem *item = [TPHomeRegionItem new];
        item.regionName = model.name;
        item.region = model;
        [arr addObject:item];
    }
    self.items = arr;
    completion(nil);
}

@end
