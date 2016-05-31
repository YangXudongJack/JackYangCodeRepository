//
//  ViewController.m
//  InternetStatus_Reachability
//
//  Created by MAC on 16/5/31.
//  Copyright © 2016年 JackYang. All rights reserved.
//

#import "ViewController.h"
#import "InternetStatus.h"

@interface ViewController () <InternetStatusProtocol>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[InternetStatus SharedInstance] addDelegate:self];
    [[InternetStatus SharedInstance] StartMonitorInternet];
}

-(void)CurrentInternetStatus:(InterStatus_type)CurrentType{
    switch (CurrentType) {
        case InterStatus_type_MobNet:
            self.statusLabel.text = @"MobNet";
            break;
            
        case InterStatus_type_WiFi:
            self.statusLabel.text = @"WiFi";
            break;
            
        case InterStatus_type_DisConnect:
            self.statusLabel.text = @"DisConnect";
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
