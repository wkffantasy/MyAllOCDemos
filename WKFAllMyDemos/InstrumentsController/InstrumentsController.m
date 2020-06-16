//
//  InstrumentsController.m
//  WKFAllMyDemos
//
//  Created by fantasy on 2020/6/14.
//  Copyright © 2020 fantasy. All rights reserved.
//

#import "InstrumentsController.h"

// views
#import "TestRetainCircleView.h"

// manager
#import "UserAccountManager.h"

@interface InstrumentsController ()

@end

@implementation InstrumentsController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"Instruments";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createRetainCircle];
    [UserAccountManager shareInstance];
}

- (void)createRetainCircle {
    TestRetainCircleView *view = [[TestRetainCircleView alloc] init];
    view.didClickBlock = ^{
        [self doSomething];
    };
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(100, 100, 100, 100);
}

- (void)doSomething {
    
}
- (void)dealloc {
    NSLog(@"InstrumentsController dealloc");
}



@end
