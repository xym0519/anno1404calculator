//
//  XXSystem.m
//  DiscuzDevelopAssistor
//
//  Created by Broche Xu on 6/25/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXSystem.h"

@implementation XXSystem

#pragma mark System Path
+ (NSString *)HomePath {
    return NSHomeDirectory();
}

+ (NSString *)DocumentsPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)ResourcePath {
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)ResourcePath:(NSString *)name withExtension:(NSString *)ext {
    return [[NSBundle mainBundle] pathForResource:name ofType:ext];
}

#pragma mark Time
+ (int)timeStamp {
    return [[NSDate new] timeIntervalSince1970];
}

@end
