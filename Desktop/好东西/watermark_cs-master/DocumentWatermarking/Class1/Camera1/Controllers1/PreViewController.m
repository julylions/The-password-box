//
//  PreViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PreViewController.h"
#import "PreViewCell.h"
//#import "ShowIMGVC.h"
//#import "BackBtn.h"
//#import "selectMainVC.h"
#define WIDTH_PIC       self.view.frame.size.width
#define HEIGHT_PIC      self.view.frame.size.height

@interface PreViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIButton *rightItemBtn;
@property (nonatomic,assign)NSInteger  nowNum;

@property (nonatomic,strong)UIView *toolBarBGView;
@property (nonatomic,strong)UIButton *toolBarRightBtn;

@end

@implementation PreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.nowNum = _pageNum;
    [self createNav];
    [self createCollectionView];
    [self createBar];
    
//    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.pageNum inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    
    
}

- (void)createBar{
    
    self.toolBarBGView = [[UIView alloc]initWithFrame:CGRectZero];
    self.toolBarBGView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:self.toolBarBGView];
    [_toolBarBGView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_offset(44);
        make.bottom.mas_equalTo(IOS11_OR_LATER?self.view.mas_safeAreaLayoutGuideBottom:self.view.mas_bottom).mas_offset(0);
        
    }];
    //    self.toolBarRightBtn = [BackBtn createBtnWithFram:CGRectMake(WIDTH_PIC - 70, 7, 60, 30) WithTitle:@"确定" andSelectTitle:@"确定" andIMG:nil andSelectIMG:nil andTitleColor:[UIColor whiteColor] andSelectColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1] andTarget:self andAction:@selector(toolBarightBtnClick)];
    self.toolBarRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.toolBarRightBtn.layer.cornerRadius     = 3;
    self.toolBarRightBtn.layer.masksToBounds    = YES;
    self.toolBarRightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.toolBarRightBtn.selected = YES;
    self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
    [self.toolBarBGView addSubview:self.toolBarRightBtn];
    [self.toolBarRightBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toolBarBGView).mas_offset(7);
        make.bottom.mas_equalTo(self.toolBarBGView).mas_offset(-7);
        make.right.mas_equalTo(self.toolBarBGView).mas_offset(-10);
        make.width.mas_offset(60);
    }];
    
    if (self.selectedArray.count) {
        self.toolBarRightBtn.selected = NO;
        [self.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
        self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
    }
}
- (void)toolBarightBtnClick{
    //    [selectMainVC shareSelectMainVC].returnArrayBlock(self.selectedArray);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark --导航栏
- (void)createNav{
    
    self.title = [NSString stringWithFormat:@"%d/%lu",self.nowNum+1,(unsigned long)self.imgModelArray.count];
    
    self.rightItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightItemBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.rightItemBtn setImage:[UIImage imageNamed:@"picSelect_SelectPIC_null"] forState:UIControlStateNormal];
    [self.rightItemBtn setImage:[UIImage imageNamed:@"moren"] forState:UIControlStateSelected];
    [self.rightItemBtn addTarget:self action:@selector(rightItemBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightItemBtn];
    ShowIMGModel *model = self.imgModelArray[self.pageNum];
    if (model.selected) {
        self.rightItemBtn.selected = YES;
    }

}

- (void)backBtnClick{
    if (self.selectedArray.count) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIButton*)createBtnWithTitle:(NSString*)title andBackIMG:(NSString*)name andTitleColor:(UIColor*)color andSelectedTitleColor:(UIColor*)selectTitleColor andTarget:(SEL)clickAction andFram:(CGRect)rect{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn addTarget:self action:clickAction forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectTitleColor forState:UIControlStateSelected];
    
    return btn;
}

#pragma mark --选择照片
- (void)rightItemBtnClick{
    
    if (self.rightItemBtn.selected) {
        self.rightItemBtn.selected = NO;
        ShowIMGModel *model = self.imgModelArray[self.nowNum];
        model.selected = NO;
        [self.selectedArray removeObject:model];
        self.selectBlock(self.selectedArray,model,NO);
        if (self.selectedArray.count) {
            self.toolBarRightBtn.selected = NO;
            self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
        }else{
            self.toolBarRightBtn.selected = YES;
            self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
        }
        [self.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
        
    }else{
        ShowIMGModel *model = self.imgModelArray[self.nowNum];
        [self.selectedArray addObject:model];
        model.selected = YES;
        self.selectBlock(self.selectedArray,model,YES);
        self.toolBarRightBtn.selected = NO;
        self.rightItemBtn.selected = YES;
        [self.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
        self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.nowNum =scrollView.contentOffset.x/self.view.bounds.size.width;
    
    ShowIMGModel *model = self.imgModelArray[self.nowNum];
    
    self.title = [NSString stringWithFormat:@"%d/%lu",self.nowNum+1,(unsigned long)self.imgModelArray.count];
    
    if (model.selected) {
        self.rightItemBtn.selected = YES;
    }else{
        self.rightItemBtn.selected = NO;
    }
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
    flowLayout.itemSize                = self.view.bounds.size;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[PreViewCell class] forCellWithReuseIdentifier:@"preView"];
    [self.view addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(IOS11_OR_LATER?self.view.mas_safeAreaLayoutGuideBottom:self.view.mas_bottom).mas_offset(0);
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgModelArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"preView" forIndexPath:indexPath];
    //    __weak  PreViewController *WeakSelf = self;
    //    cell.hiddenNAVBlock = ^(){
    //        if (WeakSelf.toolBarBGView.hidden) {
    //            WeakSelf.toolBarBGView.hidden = NO;
    //            WeakSelf.navigationController.navigationBarHidden = NO;
    //
    //        }else{
    //            WeakSelf.toolBarBGView.hidden = YES;
    //            WeakSelf.navigationController.navigationBarHidden = YES;
    //
    //        }
    //    };
    
    ShowIMGModel *model =self.imgModelArray[indexPath.row];
    
    [cell configWith:model.phAsset];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
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
