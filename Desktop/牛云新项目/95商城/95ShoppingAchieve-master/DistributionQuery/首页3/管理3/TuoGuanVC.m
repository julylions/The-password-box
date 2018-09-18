//
//  TuoGuanVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "TuoGuanVC.h"
#import "GuanLiCell.h"
#import "DaShangJingJiRenVC.h"
@interface TuoGuanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@end

@implementation TuoGuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
     [self CreatTableView];
}

#pragma mark --接口
-(void)jiekouPage:(NSString*)page{
    [Enginejw0803 guanLiLieBiaoYeShu:page Stype:@"1" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * item3Arr =[dic objectForKey:@"Item3"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in item3Arr) {
                GuanLiModel * md =[[GuanLiModel alloc]initWithGuanLiDic:dicc];
                [array2 addObject:md];
            }
            if (self.myRefreshView == _tableView.header) {
                _dataArray = array2;
                _tableView.footer.hidden = _dataArray.count==0?YES:NO;
            }else if(self.myRefreshView == _tableView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            
            
        
        [_tableView reloadData];
        [_myRefreshView  endRefreshing];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
             [_myRefreshView  endRefreshing];
        }
    } error:^(NSError *error) {
        
    }];
}



#pragma mark --创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44+5, ScreenWidth, ScreenHeight-64-44-5) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
         [self jiekouPage:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
       
        [self jiekouPage:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    _tableView.footer.hidden = YES;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    GuanLiCell * cell =[GuanLiCell cellWithTableView:tableView CellID:CellIdentifier];
     cell.indexPath=indexPath;
    cell.xiugaiBtn.tag=indexPath.row;
    cell.tejiaBtn.tag=indexPath.row;
    [self btnAddDianJi:cell];
    cell.model=_dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 190;
}
#pragma mark --4个按钮点击状态
-(void)btnAddDianJi:(GuanLiCell*)cell{
   
    
    if (!cell.moreButtonClickedBlock) {
        __block GuanLiCell* cell2=cell;
        [cell setMoreButtonClickedBlock:^(UIButton *btn,NSIndexPath *indexPath) {
             GuanLiModel * md=_dataArray[indexPath.row];
            [Enginejw0803 gengXinChanPinStypeMessageID:md.messageID State:[NSString stringWithFormat:@"%d",btn.tag+1] success:^(NSDictionary *dic) {
                
                if (btn.tag==3) {
                    UIAlertController * actionview =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"自己成交 " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                        if ([item1 isEqualToString:@"1"]) {
                            cell2.lastBtn.selected=NO;
                            btn.selected=YES;
                            cell2.lastBtn=btn;
                            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                        }else{
                            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                        }
                        
                    }];
                    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"托管成交 " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                        if ([item1 isEqualToString:@"1"]) {
                            cell2.lastBtn.selected=NO;
                            btn.selected=YES;
                            cell2.lastBtn=btn;
                            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                            DaShangJingJiRenVC * vc =[DaShangJingJiRenVC new];
                            vc.peopleID=md.jingjiID;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else{
                            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                        }
                        
                       
                    }];
                    [actionview addAction:action1];
                    [actionview addAction:action2];
                    [self presentViewController:actionview animated:YES completion:nil];
                }else{
                    
                    NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                    if ([item1 isEqualToString:@"1"]) {
                        cell2.lastBtn.selected=NO;
                        btn.selected=YES;
                        cell2.lastBtn=btn;
                        [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                    }else{
                        [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                    }
                }
            } error:^(NSError *error) {
                
            }];
            
        
        
        
        
        
        
        
        }];
        
    }
    //修改
    [cell.xiugaiBtn addTarget:self action:@selector(xiuGaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    //特价
    [cell.tejiaBtn addTarget:self action:@selector(teJiaBtnn:) forControlEvents:UIControlEventTouchUpInside];

}




//修改
-(void)xiuGaiBtn:(UIButton*)btn{
    GuanLiModel * md =_dataArray[btn.tag];
    ScanCodeVC * vc =[ScanCodeVC new];
    vc.tagg=2;
    vc.model=md;
    [self.navigationController pushViewController:vc animated:YES];


}
//特价
-(void)teJiaBtnn:(UIButton*)btn{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
