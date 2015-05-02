//
//  GroundNode.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "GroundNode.h"

@implementation GroundNode

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"ground";
}

@end
