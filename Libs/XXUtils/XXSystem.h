//
//  XXSystem.h
//  DiscuzDevelopAssistor
//
//  Created by Broche Xu on 6/25/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXSystem : NSObject
#pragma mark System Path
+ (NSString *)DocumentsPath;
+ (NSString *)HomePath;
+ (NSString *)ResourcePath;
+ (NSString *)ResourcePath:(NSString *)name withExtension:(NSString *)ext;

#pragma mark Time
+ (int)timeStamp;
@end
