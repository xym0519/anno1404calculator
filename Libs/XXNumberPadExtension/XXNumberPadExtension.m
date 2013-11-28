//
//  XXNumberPadExtension.m
//  AnnoCalculator
//
//  Created by Broche Xu on 8/22/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXNumberPadExtension.h"


@implementation XXNumberPadExtension
+ (void)loadExtension {
    static XXNumberPadExtension *instance;
    if (!instance) {
        instance = [[XXNumberPadExtension alloc] init];
    }
    [instance loadButton];
}

- (void)loadButton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addButton) name:UIKeyboardDidShowNotification object:nil];
}

- (void)addButton {
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [doneButton setTitleColor:[UIColor colorWithRed:77.0f/255 green:84.0/255 blue:98.0/255 alpha:1] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    for(int i=0; i<=[tempWindow.subviews count]-1; i++) {
        UIView *keyboard = [tempWindow.subviews objectAtIndex:i];
        if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES) {
            [keyboard addSubview:doneButton];
        }
    }
}

- (void)done {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


+ (void)unloadExtension {
    static XXNumberPadExtension *instance;
    if (instance) {
        [instance unloadButton];
    }
}

- (void)unloadButton {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
