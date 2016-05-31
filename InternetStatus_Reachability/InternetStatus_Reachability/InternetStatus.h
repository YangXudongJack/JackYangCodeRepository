//
//  InternetStatus.h
//  NetTest
//
//  Created by MAC on 16/1/21.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    InterStatus_type_DisConnect = 0,
    InterStatus_type_MobNet,
    InterStatus_type_WiFi
}InterStatus_type;

@protocol InternetStatusProtocol <NSObject>

-(void)CurrentInternetStatus:(InterStatus_type)CurrentType;

@end

@interface InternetStatus : NSObject

@property (nonatomic, weak) id <InternetStatusProtocol> delegate;

+(InternetStatus *)SharedInstance;

-(void)addDelegate:(id)delegate;

-(void)StartMonitorInternet;

@end
