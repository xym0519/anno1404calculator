//
//  XXDataManager.m
//  AnnoCalculator
//
//  Created by Broche Xu on 8/20/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXDataManager.h"
#import "XXLog.h"

@implementation XXDataManager
+ (XXDataManager *)instance {
    static XXDataManager *dm;
    if (!dm) {
        dm = [[XXDataManager alloc] init:@"data.sqlite"];
    }
    return dm;
}

- (NSMutableArray *)getUsers {
    return [self query:@"select * from user order by sort"];
}


- (NSMutableArray *)getResult {
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"select item.id id, item.name name, sum(user1.count/supply.itemcount) tcount"];
    [sql appendString:@" from supply, user user1, user user2, item"];
    [sql appendString:@" where supply.userid=user1.id and supply.itemid=item.id"];
    [sql appendString:@" and supply.limitid=user2.id and user2.count>=supply.limitcount"];
    [sql appendString:@" group by item.id order by item.sort"];
    return [self query:sql];
}

- (void)saveUsers:(NSDictionary *)users houseFlag:(BOOL)flag {
    [self beginTransaction];
    for (NSNumber *uid in users.keyEnumerator) {
        NSNumber *ucount = [users objectForKey:uid];
        if (!flag) {
            [self execute:[NSString stringWithFormat:@"update user set count=%@ where id=%@", ucount, uid]];
        } else {
            [self execute:[NSString stringWithFormat:@"update user set count=%@*capability where id=%@", ucount, uid]];
        }
    }
    [self commit];
}
@end
