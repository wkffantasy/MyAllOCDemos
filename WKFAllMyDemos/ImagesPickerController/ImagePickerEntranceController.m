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

//lib
#import "NavigationTitleView.h"

@interface ImagePickerEntranceController ()

@end

@implementation ImagePickerEntranceController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        NSLog(@"did complete imagesArray == %@",imagesArray);
        NSLog(@"and its count == %lu",(unsigned long)imagesArray.count);
        for (UIImage * image in imagesArray) {
//            NSData * imageData = UIImageJPEGRepresentation(image, 1);
            NSData * imageData = UIImagePNGRepresentation(image);
            NSLog(@"imageData == %fKB",imageData.length / 1024.0);
        }
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
- (void)dealloc {
    
    NSLog(@"Image Picker Entrance controller dealloc");
    
}



@end
