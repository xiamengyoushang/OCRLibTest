//
//  OcrOverLayerView.h
//  OCR-LKTest
//
//  Created by linkiing on 2017/3/31.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OcrOverLayerView : UIView

+ (CGRect)getOverlayFrame:(CGRect)rect;

+ (void)showOcrOverTitle:(NSString *)ocrTitle;

+ (void)showScanAnimation:(BOOL)isScanAnimation;

@end
