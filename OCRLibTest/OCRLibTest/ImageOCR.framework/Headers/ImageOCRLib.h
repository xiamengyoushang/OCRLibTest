//
//  ImageOCRLib.h
//  OCR-LKTest
//
//  Created by linkiing on 2017/3/30.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageOCRLib : NSObject

+ (NSArray *)ImageOCRlib_Result_Identify:(UIImage *)originalImage;

+ (BOOL) whetherTheImageBlurry:(UIImage*)originalImage;

@end
