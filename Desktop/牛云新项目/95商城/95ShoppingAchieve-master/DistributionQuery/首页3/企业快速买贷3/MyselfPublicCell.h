//
//  MyselfPublicCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyselfPublicCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UIButton * yuYinBtn;
@end
