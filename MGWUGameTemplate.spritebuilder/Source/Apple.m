//
//  Apple.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/20.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Apple.h"

@implementation Apple
{
    int test;
}

- (id)init {
    self = [super init];
    
    if (self) {
        CCLOG(@"Apple created");
    }
    test = 0;
    _name = @"apple";
    
    return self;
}

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"apple";
}

@end
