//
//  love.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/21.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "love.h"

@implementation love
- (void)didLoadFromCCB
{
    CCAnimationManager* animationManager = self.animationManager;
    
}

- (void)startBlinkAndJump
{
    // the animation manager of each node is stored in the 'animationManager' property
    CCAnimationManager* animationManager = self.animationManager;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"happy"];
}

@end
