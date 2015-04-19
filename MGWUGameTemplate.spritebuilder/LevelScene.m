//
//  LevelScene.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene


-(void) level1
{
    CCScene* scene = [CCBReader loadAsScene:@"GameScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
    
}

@end
