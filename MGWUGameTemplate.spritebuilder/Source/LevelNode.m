//
//  LevelNode.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/29.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "LevelNode.h"
#import "Level.h"
#import "GameScene.h"
#import "CCTransition.h"


@implementation LevelNode
{
    CCLabelTTF *_title;
    int *_highScore;
}


-(void)setLabels {
    //Level *level = (Level*)[CCBReader load:[NSString stringWithFormat:@"Levels/Level%i", self.level]];
    
    //set title
    _title.string = [NSString stringWithFormat:@"%d",self.level];
    CCLOG(@"level %d", self.level);
}

-(void)loadLevel
{
    CCLOG(@"Button pushed Node %i", self.level);
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameScene"];
    // Set the level by getting the gameplay from scene and setting level property
    ((GameScene *)[gameplayScene children][0]).level = self.level;
    ////////////////
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
}


@end
