//
//  ShangXinModel.m
//  DistributionQuery
//
//  Created by Macx on 16/12/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShangXinModel.h"

@implementation ShangXinModel
-(id)initWithShangXinDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _title=[Tooljw0803Class isString:[dic objectForKey:@"N_Title"]];
        _time=[Tooljw0803Class isString:[dic objectForKey:@"N_Edit"]];
    }
    
    return self;
}
@end
