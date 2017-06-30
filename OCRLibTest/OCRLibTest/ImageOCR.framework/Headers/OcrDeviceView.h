//
//  OcrDeviceView.h
//  OCRTest
//
//  Created by linkiing on 2017/4/13.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageOCRLib.h"

@protocol Get_OCRImageCheck_Event_Delegate <NSObject>

@optional
- (void)get_get_OcrImageCheckState:(NSInteger)state;

@required
- (void)get_OcrImageCheck_Event:(UIImage *)ocrImage andQRCode:(NSString*)messageString;

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
