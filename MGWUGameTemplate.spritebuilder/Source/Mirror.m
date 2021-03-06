//
//  Mirror.m
//  MGWUGameTemplate
//
//  Created by Yun on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Mirror.h"

@implementation Mirror

- (id)init {
    self = [super init];
    
    if (self) {
        CCLOG(@"Mirror created");
    }
    
    // enable touch events
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES; // required for tracking multiple touches

    
    return self;
}

@end
