//
//  Berry.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/20.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Berry.h"

@implementation Berry

- (id)init {
    self = [super init];
    
    if (self) {
        CCLOG(@"Berry created");
    }
    
    return self;
}

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"berry";
}

@end
