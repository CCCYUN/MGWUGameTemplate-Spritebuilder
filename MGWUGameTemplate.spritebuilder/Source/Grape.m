//
//  Grape.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/20.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Grape.h"

@implementation Grape

- (id)init {
    self = [super init];
    
    if (self) {
        CCLOG(@"Grape created");
    }
    
    return self;
}

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"grape";
}

@end
