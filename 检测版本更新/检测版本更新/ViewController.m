//
//  ViewController.m
//  检测版本更新
//
//  Created by 张晨晖 on 2018/3/20.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "CHVersionDetection.h"
#import <StoreKit/StoreKit.h>

@interface ViewController () <UIAlertViewDelegate>

@property (nonatomic ,strong) NSURL *trackViewUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    /**
     版本号检测调用方法

     @param hasNewVersion 是否有新版本
     @param infoDic 回调整体信息
     @param trackViewUrl 下载地址
     @param version 版本号
     @param releaseNotes 更新信息
     */
    [CHVersionDetection versionDetctionWithAppIDString:@"444934666" andresultBlock:^(BOOL hasNewVersion, NSDictionary *infoDic, NSURL *trackViewUrl, NSString *version, NSString *releaseNotes) {
        NSLog(@"%@",hasNewVersion == YES? @"有新版本":@"没有新版本");
        NSLog(@"infoDic:%@",infoDic);
        NSLog(@"Store下载地址:%@",trackViewUrl);
        NSLog(@"Store上版本号:%@",version);
        NSLog(@"Store更新内容:%@",releaseNotes);

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"最新版本:%@",version] message:[NSString stringWithFormat:@"更新内容:%@",releaseNotes] delegate:self cancelButtonTitle:@"暂时不更新" otherButtonTitles:@"立即更新", nil];
        self.trackViewUrl = trackViewUrl;
        [alertView show];

//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"最新版本:%@",version] message:[NSString stringWithFormat:@"更新内容:%@",releaseNotes] preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"暂时不更新" style:UIAlertActionStyleCancel handler:nil]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //jump to AppStore
//            //1.jump
//            [[UIApplication sharedApplication] openURL:trackViewUrl];
//
//            ////
////            //2.modal
////            SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
////            storeViewController.delegate = self;
////            NSDictionary *parametersDic = @{SKStoreProductParameterITunesItemIdentifier:[userDefault objectForKey:TRACK_ID]};
////            [storeViewController loadProductWithParameters:parametersDic completionBlock:^(BOOL result, NSError * _Nullable error) {
////
////                if (result) {
////                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:storeViewController animated:YES completion:^{
////
////                    }];
////                }
////            }];
//            ////
//
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];

    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.firstOtherButtonIndex == buttonIndex) {
        [[UIApplication sharedApplication] openURL:self.trackViewUrl];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
