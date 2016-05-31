//
//  InternetStatus.m
//  NetTest
//
//  Created by MAC on 16/1/21.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "InternetStatus.h"
#import "Reachability.h"

@interface InternetStatus (){
    Reachability *hostReach;
}

@end

@implementation InternetStatus

+(InternetStatus *)SharedInstance{
    static InternetStatus *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)addDelegate:(id)delegate{
    self.delegate = delegate;
}

-(void)StartMonitorInternet{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        if ([self.delegate respondsToSelector:@selector(CurrentInternetStatus:)]) {
            [self.delegate CurrentInternetStatus:InterStatus_type_DisConnect];
        }
    }
    if (status == ReachableViaWiFi) {
        if ([self.delegate respondsToSelector:@selector(CurrentInternetStatus:)]) {
            [self.delegate CurrentInternetStatus:InterStatus_type_WiFi];
        }
    }
    if (status == ReachableViaWWAN) {
        if ([self.delegate respondsToSelector:@selector(CurrentInternetStatus:)]) {
            [self.delegate CurrentInternetStatus:InterStatus_type_MobNet];
        }
    }
}

@end
