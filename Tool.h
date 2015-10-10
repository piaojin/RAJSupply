//
//  Tool.h
//  RAJSupplyManger
//
//  Created by apple on 14-9-3.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject
+ (id)StringTojosn:(NSString *)stringdata;
+ (NSString *) GetDate:(NSString *) femate;
+ (NSData *) NSDataToBS64Data:(NSData *) data;
+ (NSString *) GetOnlyString;
+ (NSString *) NSdatatoBSString:(NSData *) data;
+ (BOOL)isBlankString:(NSString *)string;
+ (NSString *)intToString:(int )data;
+ (NSString *)Append:(NSString * )data witnstring:(NSString *) data2;
+ (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+ (NSString *) GetFemate:(NSString *) str;
+ (NSString *) GetFemate2:(NSString *) str;
+ (void) alert:(NSString *) msg;
+ (NSString *) md5HexDigest:(NSString *)str;
@end
