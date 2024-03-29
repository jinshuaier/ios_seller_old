//
//  TCServerSecret.m
//  某某
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 moumou. All rights reserved.
//

#import "TCServerSecret.h"
#import <CommonCrypto/CommonDigest.h>

@implementation TCServerSecret

+ (NSString *)singstr
{
    TCServerSecret *tc = [[TCServerSecret alloc]init];
    NSString *s = @"m=12&mid=120&oid=291&p=3&timestamp=1513417786&token=xfsdfafsfds&secret=*G0^Z!eGOCh2Tf04";
    NSString *str = [tc sha1:s];
    NSLog(@"%@",str);
    return str;
}
//线上
+ (NSString *)loginAndRegisterSecretOnline:(NSString *)num{
    NSString *str1 = [NSString stringWithFormat:@"https://sapi.moumou001.com/interface?actionId=%@&", num];
     return str1;
}

//线下
+ (NSString *)loginAndRegisterSecretOffline:(NSString *)num
{
    //    TCServerSecret *tc = [[TCServerSecret alloc]init];
    //    NSString *s = [[NSString stringWithFormat:@"pfMXE7YQQVmaXBhr%@", num]stringByAppendingString:@"mmapi2016"];
    //    NSString *s = [NSString stringWithFormat:@"*G0^Z!eGOCh2Tf04"];
    //    NSString *str = [tc md52:[tc md5:s]];
    //当前时间戳
    //sign
    //    NSString *str = [tc sha1:s];
 
   // http://192.168.1.2/sellerapi/web/interface?actionId=%@&
    //https://sapi.moumou001.com/interface?actionId=%@&
    NSString *str1 = [NSString stringWithFormat:@"https://sapi.moumou001.com/interface?actionId=%@&", num];

    //    NSString *string = [str1 stringByAppendingFormat:@"&timestamp=%@&sign=%@",[TCGetTime getCurrentTime], str];
    
    return str1;
    NSLog(@"%@",str1);
}

+ (NSString *)loginAndRegisterSecret2:(NSString *)num{
    TCServerSecret *tc = [[TCServerSecret alloc]init];
    NSString *s = [[NSString stringWithFormat:@"pfMXE7YQQVmaXBhr%@", num]stringByAppendingString:@"mmapi2016"];
    NSString *str = [tc md52:[tc md5:s]];
    NSString *str1 = [[NSString stringWithFormat:@"https://api2.moumou001.com/interface/?actionid=%@", num]stringByAppendingString:@"&secretString="];
    return [str1 stringByAppendingString:str];
}

//一次加密
- (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",// 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
}

//二次加密
- (NSString *)md52:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",    // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
}

//sha1加密
- (NSString *)sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
    
}

//登录
+(NSString *)loginStr:(NSDictionary*)dict{
    NSMutableDictionary * mutDic2 = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSMutableString *contentString  =[NSMutableString string];
    NSString *signStr;
    NSArray *keys = [mutDic2 allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        NSString *caStr = [NSString stringWithFormat:@"%@",[mutDic2 objectForKey:categoryId]];
        if (![caStr isEqualToString:@""]
            && ![caStr isEqualToString:@"sign"]
            && ![caStr isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [mutDic2 objectForKey:categoryId]];
            NSString * jointStr= [contentString stringByAppendingString:@"secret=*G0^o}QcKGM4k2L1+%WzZf04"];
            NSLog(@"%@",jointStr);
            
            signStr = [NSString sha1:jointStr];
            NSLog(@"%@ %@",signStr,jointStr);
        }
    }
    return signStr;
}


//拼接字符串
+(NSString *)signStr:(NSDictionary*)dict
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[userDefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[userDefault valueForKey:@"userToken"]];
    NSDictionary *reportDic = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};

    NSMutableDictionary * mutDic2 = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [mutDic2 addEntriesFromDictionary:reportDic];

    
    NSMutableString *contentString  =[NSMutableString string];
    NSString *signStr;
    NSArray *keys = [mutDic2 allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if (![[mutDic2 objectForKey:categoryId] isEqualToString:@""]
            && ![[mutDic2 objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[mutDic2 objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [mutDic2 objectForKey:categoryId]];
            NSString * jointStr= [contentString stringByAppendingString:@"secret=*G0^o}QcKGM4k2L1+%WzZf04"];
            NSLog(@"%@",jointStr);
            
            signStr = [NSString sha1:jointStr];
            NSLog(@"%@ %@",signStr,jointStr);
        }
    }
    return signStr;
}

//拼接字典
+ (NSDictionary *)report:(NSDictionary *)dic{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *Timestr = [TCGetTime getCurrentTime];
    NSString *midStr = [NSString stringWithFormat:@"%@",[userDefault valueForKey:@"userID"]];
    NSString *tokenStr = [NSString stringWithFormat:@"%@",[userDefault valueForKey:@"userToken"]];
    NSDictionary *dicc = @{@"mid":midStr,@"token":tokenStr,@"timestamp":Timestr};
    NSMutableDictionary *reportDic = [[NSMutableDictionary alloc]initWithDictionary:dicc];
    [reportDic addEntriesFromDictionary:dic];
    
    NSDictionary *repDic = [reportDic copy];
    return repDic;
}
@end
