//
//  AFNetStatus.h
//  NetTest
//
//  Created by MAC on 16/1/21.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    NetStatus_Type_Unknown = 0,
    NetStatus_Type_DisConnect,
    NetStatus_Type_WiFi,
    NetStatus_Type_MobNet
}NetStatus_Type;

@protocol AFNetStatusProtocol <NSObject>

-(void)CurrentNetStatus:(NetStatus_Type)currentType;

@end

@interface AFNetStatus : NSObject

@property (nonatomic, weak) id <AFNetStatusProtocol> delegate;

/**
 *  代理返回当前网络状态
 *
 *  @return AFNetStatus的实例
 */
+(AFNetStatus *)SharedInstance;

-(void)addDelegate:(id)delegate;

-(void)MonitorInternet;

/**
 *  回调当前网络状态
 *
 *  @param statusBlock 网络状态
 *
 *  @return AFNetStatus的实例
 */
+(AFNetStatus *)SharedInstanceWithCurrentInternetStatus:(void(^)(NetStatus_Type netStatus))statusBlock;

@end
