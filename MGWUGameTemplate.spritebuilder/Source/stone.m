//
//  stone.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/20.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "stone.h"

@implementation stone

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"stone";
}

@end
