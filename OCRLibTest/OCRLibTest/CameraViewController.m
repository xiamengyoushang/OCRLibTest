//
//  CameraViewController.m
//  OCR-LKTest
//
//  Created by linkiing on 2017/3/31.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import "CameraViewController.h"
#import <ImageOCR/ImageOCR.h>

//https://github.com/xiamengyoushang/OCRLibTest

#define OCRDEVICETITLE1  @"未检测到边框"
#define OCRDEVICETITLE2  @"检测到无效区域"
#define OCRDEVICETITLE3  @"设备当前正在对焦"
#define OCRDEVICETITLE4  @"识别区域清晰度差"

@interface CameraViewController ()<Get_OCRImageCheck_Event_Delegate>

@property (strong, nonatomic) IBOutlet UILabel *showLabel;
@property (nonatomic, strong) OcrDeviceView *deviceView;

@end

@implementation CameraViewController

- (OcrDeviceView *)deviceView{
    if (!_deviceView) {
        _deviceView = [[OcrDeviceView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _deviceView.delegate = self;
    }
    return _deviceView;
}
- (void)creatShadeView{
    if (DEVICE_ISIPAD) {
        //iPad识别需要新增取景框(iphone也适用但可隐藏)
        UIView *shaderview = [UIView new];
        shaderview.frame = [_deviceView getOverlayFrame:_deviceView.frame];
        shaderview.layer.borderWidth = 2;
        shaderview.layer.borderColor = [UIColor orangeColor].CGColor;
        shaderview.layer.cornerRadius = 2;
        [self.view addSubview:shaderview];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.deviceView atIndex:0];
    [self creatShadeView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.deviceView beginCaptureDevice];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.deviceView stopCaptureDevice];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark - UIButton
- (IBAction)clickBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Get_OCRImageCheck_Event_Delegate
- (void)get_get_OcrImageCheckState:(NSInteger)state{
    switch (state) {
        case 0:
            _showLabel.text = OCRDEVICETITLE1;
            break;
        case 1:
            _showLabel.text = OCRDEVICETITLE2;
            break;
        case 2:
            _showLabel.text = OCRDEVICETITLE3;
            break;
        case 3:
            _showLabel.text = OCRDEVICETITLE4;
            break;
    }
}
- (void)get_OcrImageCheck_Event:(UIImage *)ocrImage andQRCode:(NSString *)messageString{
    if (ocrImage) {
        NSString *ocrTitle = NULL;
        NSArray *ocrArray = [ImageOCRLib ImageOCRlib_Result_Identify:ocrImage];
        if (ocrArray.count == 0) {
            ocrTitle = @"检测识别异常-无效区域";
            /**新增:直接复位重新识别**/
            [self.deviceView resetCaptureDevice];
            return;
        } else {
            NSString *deviceType = [ocrArray.firstObject lastObject];
            if ([deviceType containsString:@"BP04"]) {
                if ([ocrArray.firstObject count] == 9) {
                    ocrTitle = [NSString stringWithFormat:
                                @"高压：%@\n低压：%@\n脉搏：%@\nAVI：%@\nAPI：%@\nCSBP：%@\nCAPP：%@\n单位：%@\n仪器：%@",
                                [ocrArray.firstObject objectAtIndex:0],[ocrArray.firstObject objectAtIndex:1],
                                [ocrArray.firstObject objectAtIndex:2],[ocrArray.firstObject objectAtIndex:3],
                                [ocrArray.firstObject objectAtIndex:4],[ocrArray.firstObject objectAtIndex:5],
                                [ocrArray.firstObject objectAtIndex:6],[ocrArray.firstObject objectAtIndex:7],[ocrArray.firstObject objectAtIndex:8]];
                }
            } else {
                if ([ocrArray.firstObject count] == 7) {
                    ocrTitle = [NSString stringWithFormat:
                                @"高压：%@\n低压：%@\n脉搏：%@\nAVI：%@\nAPI：%@\n单位：%@\n仪器：%@",
                                [ocrArray.firstObject objectAtIndex:0],[ocrArray.firstObject objectAtIndex:1],
                                [ocrArray.firstObject objectAtIndex:2],[ocrArray.firstObject objectAtIndex:3],
                                [ocrArray.firstObject objectAtIndex:4],[ocrArray.firstObject objectAtIndex:5],[ocrArray.firstObject objectAtIndex:6]];
                }
            }
        }
        UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"检测结果" message:ocrTitle preferredStyle:UIAlertControllerStyleAlert];
        [alertctl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.deviceView resetCaptureDevice];
        }]];
        [self presentViewController:alertctl animated:YES completion:nil];
    } else {
        UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"检测到二维码" message:messageString preferredStyle:UIAlertControllerStyleAlert];
        [alertctl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.deviceView resetCaptureDevice];
        }]];
        [self presentViewController:alertctl animated:YES completion:nil];
    }
}

@end
