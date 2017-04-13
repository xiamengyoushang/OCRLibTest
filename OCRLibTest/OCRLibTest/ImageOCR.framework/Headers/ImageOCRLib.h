//
//  ImageOCRLib.h
//  OCR-LKTest
//
//  Created by linkiing on 2017/3/30.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageOCRLib : NSObject

//金色血压器OCR检测
+ (NSArray *)ImageOCRlib_Gold_Identify:(UIImage *)originalImage;

//白色血压器OCR检测
+ (NSArray *)ImageOCRlib_White_Identify:(UIImage *)originalImage;

@end
