//
//  Tool.m
//  RAJSupplyManger
//
//  Created by apple on 14-9-3.
//  Copyright (c) 2014年 Reasonable. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "Tool.h"

@implementation Tool

+ (id)StringTojosn:(NSString *)stringdata
{
    NSData *data= [stringdata dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id weatherDic=nil;
    if (data!=nil) {
          weatherDic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
     }
    return weatherDic;
}

+ (NSString *) GetDate:(NSString *) famate
{
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:famate];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
    
}

+ (NSString *) GetOnlyString
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;

}

+ (NSData *) NSDataToBS64Data:(NSData *) data
{
   NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    return base64Data;
}

+ (NSString *) NSdatatoBSString:(NSData *) data
{
    return [data base64EncodedStringWithOptions:0];

}

+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        
        return YES;
        
    }
    
    if (string == NULL) {
        
        return YES;
        
    }
    return NO;
    
}


+ (NSString *)intToString:(int )data
{
   return  [NSString stringWithFormat:@"%ld",(long)data];
}
+ (NSString *)Append:(NSString * )data witnstring:(NSString *) data2
{
    
    return  [NSString stringWithFormat:@"%@%@",data,data2];
}


+ (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


+ (NSString *) GetFemate:(NSString *) str
{
    if(![str isEqualToString:@""])
    {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray  * array= [str componentsSeparatedByString:@"/"];
    NSString * year=[array[2] substringWithRange:NSMakeRange(0, 4)];
  
    NSString *dateStr=[NSString stringWithFormat:@"%@年%@月%@日",
                       year,
                       array[0],
                       array[1]];
         return dateStr;
    }else{
    
        
        return str;
    }
    
   

}

+ (NSString *) GetFemate2:(NSString *) str
{
    if(![str isEqualToString:@""])
    {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray  * array= [str componentsSeparatedByString:@"/"];
        NSString * year=[array[2] substringWithRange:NSMakeRange(0, 4)];
        
        NSString *dateStr=[NSString stringWithFormat:@"%@-%@-%@",
                           year,
                           array[0],
                           array[1]];
        return dateStr;
    }else{
        
        
        return str;
    }
    
    
    
}
+ (void) alert:(NSString *) msg
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil    otherButtonTitles:@"确定", nil];
    [alert show];
}


+ (NSString *) md5HexDigest:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end
