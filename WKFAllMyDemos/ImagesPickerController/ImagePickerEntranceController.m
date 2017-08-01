//
//  ImagePickerEntranceController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "ImagePickerEntranceController.h"

//controller
#import "KFAlbumPickerController.h"

//view
#import "DemoCell.h"

//lib
#import "NavigationTitleView.h"

#define cellId @"DemoCell"

@interface ImagePickerEntranceController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,weak) UICollectionView * collectionView;

@end

@implementation ImagePickerEntranceController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self settingNaviBar];
    [self setupCollectionView];

}
#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        NSLog(@"cell是个空的玩意");
    }
    if (self.dataArray.count == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"Add_icons"];
    } else {
        if (indexPath.row == self.dataArray.count) {
            cell.imageView.image = [UIImage imageNamed:@"Add_icons"];
        } else {
            cell.imageView.image = self.dataArray[indexPath.row];
        }
    }
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat WH = (ScreenWidth - (rowCount+1) * margin)/rowCount;
    CGFloat WH = (ScreenWidth - 20) / 3;
    return CGSizeMake(WH,WH);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(0, margin, margin, margin);
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.dataArray.count) {
        [self clickSelectToChoice];
    }
}


#pragma mark UI

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[DemoCell class] forCellWithReuseIdentifier:cellId];
    _collectionView = collectionView;
    [self.view addSubview:collectionView];
    
}

- (void)settingNaviBar {
    
    NavigationTitleView * titleView = [[NavigationTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-150, 40) Text:@"Image Picker"];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"click" style:UIBarButtonItemStylePlain target:self action:@selector(clickSelectToChoice)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)clickSelectToChoice {
    
    KFAlbumPickerController * albumVC = [[KFAlbumPickerController alloc]init];
    albumVC.cancelBlock = ^(){
        NSLog(@"did cancel");
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    albumVC.completeBlock = ^(NSArray * imagesArray){
        [self dismissViewControllerAnimated:YES completion:nil];
        for (UIImage * image in imagesArray) {
            [self.dataArray addObject:image];
        }
        [self.collectionView reloadData];
    };
    UINavigationController * naviVC = [[UINavigationController alloc]initWithRootViewController:albumVC];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择照片" message:@"一张还是多张" preferredStyle:UIAlertControllerStyleActionSheet];
    
    @weakify(alertController);
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        @strongify(alertController);
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
        NSLog(@"cacel");
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(alertController);
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
        [self presentViewController:naviVC animated:YES completion:nil];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"多张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(alertController);
        [alertController dismissViewControllerAnimated:YES completion:nil];
        albumVC.maxImageCount = 3;
        [self presentViewController:naviVC animated:YES completion:nil];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc {
    
    NSLog(@"Image Picker Entrance controller dealloc");
    
}



@end
