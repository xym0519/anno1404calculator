//
//  XXDataManagerBase.h
//  DiscuzDevelopAssistor
//
//  Created by Broche Xu on 6/25/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef XXDatabasePath
#else
#define XXDatabasePath @"data.sqlite"
#endif

@interface XXDataManagerBase : NSObject
- (void)initTable:(NSString *)tableName withData:(NSMutableArray *)data;

- (NSMutableArray *)query:(NSString *)sql;
- (NSDictionary *)fetch:(NSString *)sql;
- (id)scalar:(NSString *)sql;
- (BOOL)execute:(NSString *)sql;
- (void)beginTransaction;
- (void)commit;
@end
