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
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.deviceView];
    [self.view addSubview:self.overlayView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.deviceView beginCaptureDevice];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.deviceView stopCaptureDevice];
}
#pragma mark - Get_OCRImageCheck_Event_Delegate
- (void)get_OcrImageCheck_Event:(UIImage *)ocrImage{
    NSArray *ocrArray = NULL;
    NSString *ocrTitle = NULL;
    if (_imageOcrTypeIndex == 0) {
        //金色血压器OCR检测
        ocrArray = [ImageOCRLib ImageOCRlib_Gold_Identify:ocrImage];
        if (ocrArray.count == 7) {
            ocrTitle = [NSString stringWithFormat:
                        @"高压：%@\n低压：%@\n脉搏：%@\nAVI：%@\nAPI：%@\nCSBP：%@\nCAPP：%@",
                        [ocrArray objectAtIndex:0],[ocrArray objectAtIndex:1],
                        [ocrArray objectAtIndex:2],[ocrArray objectAtIndex:3],
                        [ocrArray objectAtIndex:4],[ocrArray objectAtIndex:5],
                        [ocrArray objectAtIndex:6]];
        }
    } else {
        //白色血压器OCR检测
        ocrArray = [ImageOCRLib ImageOCRlib_White_Identify:ocrImage];
        if (ocrArray.count == 5) {
            ocrTitle = [NSString stringWithFormat:
                        @"高压：%@\n低压：%@\n脉搏：%@\nAVI：%@\nAPI：%@",
                        [ocrArray objectAtIndex:0],[ocrArray objectAtIndex:1],
                        [ocrArray objectAtIndex:2],[ocrArray objectAtIndex:3],
                        [ocrArray objectAtIndex:4]];
        }
    }
    UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"检测结果" message:ocrTitle preferredStyle:UIAlertControllerStyleAlert];
    [alertctl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.deviceView resetCaptureDevice];
    }]];
    [self presentViewController:alertctl animated:YES completion:nil];
}

@end
