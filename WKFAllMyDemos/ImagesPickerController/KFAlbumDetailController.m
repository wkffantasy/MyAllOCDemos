//
//  KFAlbumDetailController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "KFAlbumDetailController.h"

//view
#import "KFSelectImageCell.h"

//model
#import "KFAsset.h"

#define cellId @"KFSelectImageCell"

#define margin 5
#define rowCount 3

@interface KFAlbumDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray * selectImagesArray;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) int currentSelectImageCount;

@property (nonatomic,weak) UICollectionView * collectionView;

@end

@implementation KFAlbumDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self settingNaviBar];
    [self setupCollectionView];
    
    [self getData];
    
}

- (void)getData{
    
    NSAssert(self.assetsGroup != nil, @"");
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            if (result != nil) {
                
                KFAsset * a = [[KFAsset alloc]init];
                a.asset = result;
                a.selected = NO;
                [self.dataArray insertObject:a atIndex:0];
                
            }
        }];
        
        [self.collectionView reloadData];
        
    });
    
}

#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KFSelectImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        NSLog(@"cell是个空的玩意");
    }
    cell.asset = self.dataArray[indexPath.row];
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
    KFAsset * a = self.dataArray[indexPath.row];
    a.selected = !a.selected;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
#pragma mark UI

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[KFSelectImageCell class] forCellWithReuseIdentifier:cellId];
    _collectionView = collectionView;
    [self.view addSubview:collectionView];

}

- (void)settingNaviBar {
    
    self.title = @"Select Images";
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickDone)];
    
    self.navigationItem.rightBarButtonItem = right;
}

- (void)clickDone {
    
    if (self.completeBlock) {
        self.completeBlock(self.selectImagesArray);
    }
    
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)selectImagesArray {
    if (_selectImagesArray == nil) {
        _selectImagesArray = [NSMutableArray array];
    }
    return _selectImagesArray;
}
- (void)dealloc {
    NSLog(@"Album detail dealloc");
}
@end
