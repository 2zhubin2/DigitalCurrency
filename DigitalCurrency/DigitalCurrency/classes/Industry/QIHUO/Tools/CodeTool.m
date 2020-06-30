//
//  CodeTool.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/26.
//  Copyright © 2019 zdh. All rights reserved.
//

#import "CodeTool.h"

@implementation CodeTool
+ (BOOL)isIPhoneXSeries{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
+ (BOOL)isNumText:(NSString *)str{
    
    NSString * regex        = @"(/^[0-9]*$/)";
    
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch            = [pred evaluateWithObject:str];
    
    if (isMatch) {
        
        return YES;
        
    }else{
        
        return NO;
        
    }
    
}

+(void)archiveOJBC:(nullable id)objc saveKey:(NSString *)key{
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:objc];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:key];
    
}
+(id)getOBJCWithSavekey:(NSString *)key{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id objc = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return objc;
}
@end
