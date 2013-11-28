//
//  XXDataManagerBase.m
//  DiscuzDevelopAssistor
//
//  Created by Broche Xu on 6/25/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXDataManagerBase.h"
#import "FMDatabase.h"
#import "XXSystem.h"

@implementation XXDataManagerBase {
    FMDatabase *db;
}

- (id)init {
    self = [super init];
    if (self) {
        
        NSFileManager *fManager = [NSFileManager defaultManager];
        NSString *srcCachePath = [[XXSystem ResourcePath] stringByAppendingPathComponent:XXDatabasePath];
        NSString *destCachePath = [[XXSystem DocumentsPath] stringByAppendingPathComponent:XXDatabasePath];
        if (![fManager fileExistsAtPath:destCachePath]) {
            [fManager copyItemAtPath:srcCachePath toPath:destCachePath error:nil];
        }
        
        db = [FMDatabase databaseWithPath:destCachePath];
        if (![db open]) {
            exit(0);
        }
    }
    return self;
}

- (void)dealloc {
    [db close];
}

- (NSMutableArray *)query:(NSString *)sql {
#ifdef XXDEBUG_DATAMANAGER
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:sql];
    while([rs next]) {
        [result addObject:[rs resultDictionary]];
    }
    [rs close];
    return result;
}

- (NSDictionary *)fetch:(NSString *)sql {
#ifdef XXDEBUG_DATAMANAGER
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    FMResultSet *rs = [db executeQuery:sql];
    NSDictionary *result = nil;
    if ([rs next]) {
        result = [rs resultDictionary];
    }
    [rs close];
    return result;
}

- (id)scalar:(NSString *)sql {
#ifdef XXDEBUG_DATAMANAGER
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    FMResultSet *rs = [db executeQuery:sql];
    id result;
    if ([rs next]) {
        result = [rs objectForColumnIndex:0];
    } else {
        result = nil;
    }
    [rs close];
    return result;
}

- (BOOL)execute:(NSString *)sql {
#ifdef XXDEBUG_DATAMANAGER
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    return [db executeUpdate:sql];
}

- (void)beginTransaction {
    [db beginTransaction];
}

- (void)commit {
    [db commit];
}

- (void)initTable:(NSString *)tableName withData:(NSMutableArray *)data {
    [self beginTransaction];
    [self execute:[NSString stringWithFormat:@"delete from %@",tableName]];
    for (NSMutableDictionary *row in data) {
        NSString *fields = [[NSString alloc] init];
        NSString *values = [[NSString alloc] init];
        for (NSString *key in [row allKeys]) {
            fields = [fields stringByAppendingFormat:@"%@,",key];
            values = [values stringByAppendingFormat:@"'%@',",[row objectForKey:key]];
        }
        fields = [fields substringToIndex:[fields length]-1];
        values = [values substringToIndex:[values length]-1];
        NSString *sql = [NSString stringWithFormat:@"insert into %@(%@) values(%@)",tableName,fields,values];
        [self execute:sql];
    }
    [self commit];
}
@end
