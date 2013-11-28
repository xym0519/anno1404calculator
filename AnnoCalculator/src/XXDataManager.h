//
//  XXDataManager.h
//  AnnoCalculator
//
//  Created by Broche Xu on 8/20/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXDataManagerBase.h"

@interface XXDataManager : XXDataManagerBase
+ (XXDataManager *)instance;
- (NSMutableArray *)getUsers;
- (NSMutableArray *)getResult;
- (void)saveUsers:(NSDictionary *)users houseFlag:(BOOL)flag;
@end
