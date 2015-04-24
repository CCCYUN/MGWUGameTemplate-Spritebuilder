//
//  AppleJoint.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/22.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "AppleJoint.h"

@implementation AppleJoint
{
    CCNode *_AppleJointNode;
}

- (void)appleJointRemoved
{
    [_AppleJointNode removeFromParent];
    CCLOG(@"joint removed");
}


@end
