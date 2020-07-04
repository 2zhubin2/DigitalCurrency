//
//  ZBNewInformationModel.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/4.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBNewInformationModel.h"

@implementation ZBNewInformationModel

+(instancetype)ZBNewInformationModelWithDict:(NSDictionary *)dict{
    ZBNewInformationModel *model = [ZBNewInformationModel new];
    model.content = dict[@"content"];
    model.time = dict[@"time"];
    return model;
}


@end
