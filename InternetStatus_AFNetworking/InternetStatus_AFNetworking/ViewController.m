//
//  ViewController.m
//  InternetStatus_AFNetworking
//
//  Created by MAC on 16/5/31.
//  Copyright © 2016年 JackYang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetStatus.h"

@interface ViewController () <AFNetStatusProtocol>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AFNetStatus SharedInstance] addDelegate:self];
    [[AFNetStatus SharedInstance] MonitorInternet];
}

-(void)CurrentNetStatus:(NetStatus_Type)currentType{
    switch (currentType) {
        case NetStatus_Type_Unknown:
            self.statusLabel.text = @"Unknown";
            break;
            
        case NetStatus_Type_MobNet:
            self.statusLabel.text = @"MobNet";
            break;
        
        case NetStatus_Type_WiFi:
            self.statusLabel.text = @"WiFi";
            break;
            
        case NetStatus_Type_DisConnect:
            self.statusLabel.text = @"DisConnect";
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
