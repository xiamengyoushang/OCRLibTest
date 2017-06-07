//
//  OcrDeviceView.h
//  OCRTest
//
//  Created by linkiing on 2017/4/13.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OcrOverLayerView.h"
#import "ImageOCRLib.h"

#define OCRDEVICETITLE1  @"未检测到边框"
#define OCRDEVICETITLE2  @"检测到无效区域"
#define OCRDEVICETITLE3  @"请对齐边框边缘"
#define OCRDEVICETITLE4  @"设备当前正在对焦"

@protocol Get_OCRImageCheck_Event_Delegate <NSObject>

- (void)get_OcrImageCheck_Event:(UIImage *)ocrImage;

@end
@interface OcrDeviceView : UIView

//开启OCR扫描
- (void)beginCaptureDevice;
//终止OCR扫描
- (void)stopCaptureDevice;
//复位OCR扫描
- (void)resetCaptureDevice;

@property (nonatomic, weak)id<Get_OCRImageCheck_Event_Delegate>delegate;

@end
