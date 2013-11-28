//
//  XXLog.h
//  DiscuzDevelopAssistor
//
//  Created by Broche Xu on 6/22/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#ifdef XXDEBUG_LOG
#define XXLog(f,...) NSLog(@"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(f), ##__VA_ARGS__] )
#else
#define XXLog(f,...)
#endif