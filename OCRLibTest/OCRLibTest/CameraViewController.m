//
//  CameraViewController.m
//  OCR-LKTest
//
//  Created by linkiing on 2017/3/31.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import "CameraViewController.h"
#import <ImageOCR/ImageOCR.h>

@interface CameraViewController ()<Get_OCRImageCheck_Event_Delegate>

@property (nonatomic, strong) OcrDeviceView *deviceView;
@property (nonatomic, strong) OcrOverLayerView *overlayView;

@end

@implementation CameraViewController

- (CGRect)rectForPreviewLayer {
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height -= 64;
    return rect;
}
- (OcrDeviceView *)deviceView{
    if (!_deviceView) {
        CGRect rect = [self rectForPreviewLayer];
        _deviceView = [[OcrDeviceView alloc] initWithFrame:rect];
        _deviceView.delegate = self;
    }
    return _deviceView;
}
- (OcrOverLayerView *)overlayView {
    if(!_overlayView) {
        CGRect rect = [OcrOverLayerView getOverlayFrame:[self rectForPreviewLayer]];
        _overlayView = [[OcrOverLayerView alloc] initWithFrame:rect];
    }
    return _overlayView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.deviceView];
    //OcrOverLayerView可以隐藏 客户可自定义UI但Rect不能变动
    [self.view addSubview:self.overlayView];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启识别
    [self.deviceView beginCaptureDevice];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //结束识别
    [self.deviceView stopCaptureDevice];
}
#pragma mark - Get_OCRImageCheck_Event_Delegate
- (void)get_OcrImageCheck_Event:(UIImage *)ocrImage{
    NSArray *ocrArray = NULL;
    NSString *ocrTitle = NULL;
    if (_imageOcrTypeIndex == 0) {
        //金色血压器OCR检测
        ocrArray = [ImageOCRLib ImageOCRlib_Gold_Identify:ocrImage];
        if (ocrArray.count == 0) {
            ocrTitle = @"检测识别异常-无效区域";
        } else {
            if ([ocrArray.firstObject count] == 8) {
                ocrTitle = [NSString stringWithFormat:
                            @"高压：%@\n低压：%@\n脉搏：%@\nAVI：%@\nAPI：%@\nCSBP：%@\nCAPP：%@\n单位：%@",
                            [ocrArray.firstObject objectAtIndex:0],[ocrArray.firstObject objectAtIndex:1],
                            [ocrArray.firstObject objectAtIndex:2],[ocrArray.firstObject objectAtIndex:3],
                            [ocrArray.firstObject objectAtIndex:4],[ocrArray.firstObject objectAtIndex:5],
                            [ocrArray.firstObject objectAtIndex:6],[ocrArray.firstObject objectAtIndex:7]];
            }
        }
    } else {
        //白色血压器OCR检测
        ocrArray = [ImageOCRLib ImageOCRlib_White_Identify:ocrImage];
        if (ocrArray.count == 0) {
            ocrTitle = @"检测识别异常-无效区域";
        } else {
            if ([ocrArray.firstObject count] == 6) {
                ocrTitle = [NSString stringWithFormat:
                            @"高压：%@\n低压：%@\n脉搏：%@\nAVI：%@\nAPI：%@\n单位：%@",
                            [ocrArray.firstObject objectAtIndex:0],[ocrArray.firstObject objectAtIndex:1],
                            [ocrArray.firstObject objectAtIndex:2],[ocrArray.firstObject objectAtIndex:3],
                            [ocrArray.firstObject objectAtIndex:4],[ocrArray.firstObject objectAtIndex:5]];
            }
        }
    }
    
    UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"检测结果" message:ocrTitle preferredStyle:UIAlertControllerStyleAlert];
    [alertctl addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //识别复位
        [self.deviceView resetCaptureDevice];
    }]];
    [self presentViewController:alertctl animated:YES completion:nil];
}

@end
