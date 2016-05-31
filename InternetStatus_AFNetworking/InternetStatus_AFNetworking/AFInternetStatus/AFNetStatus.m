//
//  AFNetStatus.m
//  NetTest
//
//  Created by MAC on 16/1/21.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "AFNetStatus.h"
#import "AFNetworking.h"

@interface AFNetStatus ()

@property (nonatomic, copy) void(^InternetStatusBlock)(NetStatus_Type);

@end

@implementation AFNetStatus

+(AFNetStatus *)SharedInstance{
    static AFNetStatus *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)addDelegate:(id)delegate{
    self.delegate = delegate;
}

-(void)MonitorInternet{
    static AFNetworkReachabilityStatus statusRecord = AFNetworkReachabilityStatusUnknown;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status != statusRecord) {
            statusRecord = status;
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:{
                    if ([self.delegate respondsToSelector:@selector(CurrentNetStatus:)]) {
                        [self.delegate CurrentNetStatus:NetStatus_Type_Unknown];
                    }
                    break;
                }
                    
                case AFNetworkReachabilityStatusNotReachable:{
                    if ([self.delegate respondsToSelector:@selector(CurrentNetStatus:)]) {
                        [self.delegate CurrentNetStatus:NetStatus_Type_DisConnect];
                    }
                    break;
                }
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    if ([self.delegate respondsToSelector:@selector(CurrentNetStatus:)]) {
                        [self.delegate CurrentNetStatus:NetStatus_Type_MobNet];
                    }
                    break;
                }
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    if ([self.delegate respondsToSelector:@selector(CurrentNetStatus:)]) {
                        [self.delegate CurrentNetStatus:NetStatus_Type_WiFi];
                    }
                    break;
                }
            }
        }
    }];
    [manager startMonitoring];
}

@end
