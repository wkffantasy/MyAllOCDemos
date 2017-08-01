//
//  KFAlbumPickerController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/8/1.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "KFAlbumPickerController.h"

#import <AssetsLibrary/AssetsLibrary.h>

//controller
#import "KFAlbumDetailController.h"

@interface KFAlbumPickerController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;


@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation KFAlbumPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self settingNaviBar];
    [self setupViews];
    [self getDataFromLibrary];
    
    // Do any additional setup after loading the view.
}
- (void)getDataFromLibrary {
    
    self.library = [[ALAssetsLibrary alloc]init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        void (^assetGroupEnumerator)(ALAssetsGroup *,BOOL *) = ^(ALAssetsGroup * group,BOOL *stop){
            
            if (group != nil) {
                [self.dataArray addObject:group];
                [self.tableView reloadData];
            }
        };
        void (^assetGroupEnumeratorFailure)(NSError *) = ^(NSError *error){
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"Error Occured" message:[NSString stringWithFormat:@"error == %@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            @weakify(alertVC);
            [alertVC addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                @strongify(alertVC);
                [alertVC dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];
        };
        [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetGroupEnumerator failureBlock:assetGroupEnumeratorFailure];
    });
    
}
#pragma UI
- (void)setupViews {
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 57;
    
    [self.view addSubview:tableView];
}
- (void)settingNaviBar {
    
    self.title = @"Select Album";
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:@"cancel" style:UIBarButtonItemStyleDone target:self action:@selector(clickCancel)];
    
    self.navigationItem.leftBarButtonItem = left;
}
#pragma UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    ALAssetsGroup *group = self.dataArray[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",[group valueForProperty:ALAssetsGroupPropertyName], group.numberOfAssets];
    
    cell.imageView.image = [UIImage imageWithCGImage:group.posterImage];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KFAlbumDetailController * albumDetailVc = [[KFAlbumDetailController alloc]init];
    albumDetailVc.assetsGroup = self.dataArray[indexPath.row];
    albumDetailVc.maxImageCount = self.maxImageCount == 0 ? 1 :self.maxImageCount;
    @weakify(self);
    albumDetailVc.completeBlock = ^(NSArray * imagesArray){
        @strongify(self);
        if (self.completeBlock) {
            self.completeBlock(imagesArray);
        }
    };
    [self.navigationController pushViewController:albumDetailVc animated:YES];
    
}

#pragma others

- (void)clickCancel {
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc {
    NSLog(@"album picker vc dealloc");
}

@end
