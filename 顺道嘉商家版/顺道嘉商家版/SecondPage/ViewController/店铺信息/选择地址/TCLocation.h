//
//  TCLocation.h
//  顺道嘉(新)
//
//  Created by 某某 on 16/9/24.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^addBlock)(NSString *address, NSString *lon, NSString *lat);
typedef void(^errorBlock)(void);

@interface TCLocation : NSObject

@property (nonatomic, copy) addBlock addblock;
@property (nonatomic, copy) errorBlock errorblock;

- (void)getadds:(addBlock)blocks andMayBeError:(errorBlock)errorblock;

@end
