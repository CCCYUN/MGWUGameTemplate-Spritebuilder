//
//  Cat.m
//  MGWUGameTemplate
//
//  Created by Yun on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cat.h"

@implementation Cat

- (id)init {
    self = [super init];
    
    if (self) {
        CCLOG(@"Cat created");
    }
    
    return self;
}

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"cat";
}

@end
