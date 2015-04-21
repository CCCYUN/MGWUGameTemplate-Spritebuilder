//
//  Laser.m
//  MGWUGameTemplate
//
//  Created by Yun on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Laser.h"

@implementation Laser

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"laser";
    self.physicsBody.sensor = TRUE;
}

@end
