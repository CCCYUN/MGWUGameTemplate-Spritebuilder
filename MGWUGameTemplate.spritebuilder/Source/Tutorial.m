//
//  Tutorial.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/5/2.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Tutorial.h"
#import "GameScene.h"

@implementation Tutorial

-(void) ToSecond
{
    CCScene *tScene = [CCBReader loadAsScene:@"Tutorial2"];
    [[CCDirector sharedDirector] replaceScene:tScene];
    
}

-(void) ToThird
{
    CCScene *tScene = [CCBReader loadAsScene:@"Tutorial3"];
    [[CCDirector sharedDirector] replaceScene:tScene];
    
}

-(void) Begin
{
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameScene"];
    // Set the level by getting the gameplay from scene and setting level property
    ((GameScene *)[gameplayScene children][0]).level = 1;
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
}

@end
