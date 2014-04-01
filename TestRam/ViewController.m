//
//  ViewController.m
//  TestRam
//
//  Created by SKYA03  on 13-12-13.
//  Copyright (c) 2013年 SKYA03 . All rights reserved.
//

#import "ViewController.h"


// 获取当前设备可用内存及所占内存的头文件
#import <sys/sysctl.h>
#import <mach/mach.h>


#import "sys/utsname.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSLog(@"globallyUniqueString=%@",[[NSProcessInfo processInfo] globallyUniqueString]);//全球唯一标识
// //   NSLog(@"uniqueIdentifie=%@",[UIDevice currentDevice].uniqueIdentifier);//唯一的标识 可用于区分设备
//    NSLog(@"name=%@",[UIDevice currentDevice].name);//设备的名称  李四的 iPad、王五的 iPad .。。
//    NSLog(@"systemName=%@",[UIDevice currentDevice].systemName);//系统的名称  iPhone OS
//    NSLog(@"systemVersion=%@",[UIDevice currentDevice].systemVersion);//设备系统的版本号  5.1.1、6.0
//    NSLog(@"model=%@",[UIDevice currentDevice].model);//设备的型号   iPad、iphone、ipod touch。。。
//    NSLog(@"localizedModel=%@",[UIDevice currentDevice].localizedModel);//本地化的模型  iPad
//    NSLog(@"batteryLevel=%lf",[UIDevice currentDevice].batteryLevel);//电池电量
    
    
//    //手机序列号
////    NSString* identifierNumber = [[UIDevice currentDevice] uniqueIdentifier];
////    NSLog(@"手机序列号: %@",identifierNumber);
//    //手机别名： 用户定义的名称
//    NSString* userPhoneName = [[UIDevice currentDevice] name];
//    NSLog(@"手机别名: %@", userPhoneName);
//    //设备名称
//    NSString* deviceName = [[UIDevice currentDevice] systemName];
//    NSLog(@"设备名称: %@",deviceName );
//    //手机系统版本
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"手机系统版本: %@", phoneVersion);
//    //手机型号
//    NSString* phoneModel = [[UIDevice currentDevice] model];
//    NSLog(@"手机型号: %@",phoneModel );
//    //地方型号  （国际化区域名称）
//    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
//    NSLog(@"国际化区域名称: %@",localPhoneModel );
//        
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    // 当前应用名称
//    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    NSLog(@"当前应用名称：%@",appCurName);
//    // 当前应用软件版本  比如：1.0.1
//    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"当前应用软件版本:%@",appCurVersion);
//    // 当前应用版本号码   int类型
//    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
//    NSLog(@"当前应用版本号码：%@",appCurVersionNum);

    
    
    
}
// 获取当前设备可用内存(单位：MB）
- (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

- (NSString *)getDeviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    //get the device model and the system version
    
//    NSLog(@"%@",[NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding]);
//    NSLog(@"%@",[NSString stringWithCString:systemInfo.nodename encoding:NSUTF8StringEncoding]);
//    NSLog(@"%@",[NSString stringWithCString:systemInfo.version encoding:NSUTF8StringEncoding]);
//    NSLog(@"%@",[NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding]);
    
    NSString *machine =[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return machine;
}

//struct	utsname {
//	char	sysname[_SYS_NAMELEN];	/* [XSI] Name of OS */
//	char	nodename[_SYS_NAMELEN];	/* [XSI] Name of this network node */
//	char	release[_SYS_NAMELEN];	/* [XSI] Release level */
//	char	version[_SYS_NAMELEN];	/* [XSI] Version level */
//	char	machine[_SYS_NAMELEN];	/* [XSI] Hardware type */
//};

- (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad air (WiFi)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn1:(id)sender {
    self.label1.text = [NSString stringWithFormat:@"%lfM",[self availableMemory]];
}

- (IBAction)btn2:(id)sender {
//    NSLog(@"%@",[sender titleForState:UIControlStateNormal]);
    self.label2.text = [NSString stringWithFormat:@"%lfM",[self usedMemory]];
}

- (IBAction)btn3:(id)sender {
    self.label3.text = [self deviceString];
}
@end
