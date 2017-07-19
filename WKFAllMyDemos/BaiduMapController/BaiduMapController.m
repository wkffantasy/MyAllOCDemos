//
//  BaiduMapController.m
//  WKFAllMyDemos
//
//  Created by 王孔飞 on 2017/7/17.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "BaiduMapController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <CoreLocation/CoreLocation.h>

@interface BaiduMapController ()<BMKMapViewDelegate>

@property (nonatomic,strong) BMKMapView * mapView;

@end

@implementation BaiduMapController


- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]init];
    self.view = _mapView;
    // Do any additional setup after loading the view.
    
    [self addressTo:@"软通大厦"];
    
    [self toAddress];
    
    [self twoPointDistance];
    
    
}
//计算两点之间的距离
- (void)twoPointDistance {
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(38.619992,114.704055));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(38.867657,115.482331));
    //米
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    NSLog(@"distance == %f",distance);
    
}

//to address
- (void)toAddress {
    CLLocation * newLocation = [[CLLocation alloc]initWithLatitude:38.619992 longitude:114.704055];
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
        
        NSLog(@"--array--%d---error--%@",(int)placemarks.count,error);
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *city = placemark.administrativeArea;
            
            NSLog(@"位于:%@",city);
            NSLog(@"位于：%@",placemark.subAdministrativeArea);
            NSLog(@"%@",placemark.addressDictionary[@"Name"]);
        }
    }];
}
//address to lat and lon
- (void)addressTo:(NSString *)address {
    NSAssert(address.length > 0, @"");
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError* error){
        if (!error) {
            
            for (CLPlacemark* aPlacemark in placemarks)
            {
                NSLog(@"place--%@", [aPlacemark locality]);
                NSLog(@"subplace == %@",[aPlacemark subLocality]);
                NSLog(@"省 == %@",[aPlacemark administrativeArea]);
                NSLog(@"lat--%f--lon--%f",aPlacemark.location.coordinate.latitude,aPlacemark.location.coordinate.longitude);
            }
        }
        else{
            
            NSLog(@"error--%@",[error localizedDescription]);
        }
    }];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _mapView.delegate = self;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _mapView.delegate = self;
}


@end
