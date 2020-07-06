//
//  talkListModel.m
//  firstProject
//
//  Created by apple on 2020/6/5.
//  Copyright © 2020 ap. All rights reserved.
//

#import "talkListModel.h"

@implementation talkListModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{
        @"list" :@"ListModel"
    };
}
@end

@implementation ListModel
-(NSString *)content{
    if (_content && [_content containsString:@"%E"]) {
        _content = @"此评论被系统屏蔽";
    }
    return _content;
}

@end
