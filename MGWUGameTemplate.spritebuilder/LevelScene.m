//
//  LevelScene.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "LevelScene.h"
#import "LevelNode.h"

@implementation LevelScene
{
    CCLayoutBox *_LevelBox;
}


//-(void) level1
//{
//    CCScene* scene = [CCBReader loadAsScene:@"GameScene"];
//    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
//    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
    
//}

-(void) didLoadFromCCB
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *publishedPath = [resourcePath stringByAppendingPathComponent:@"Published-iOS"];
    NSString *levelsPath = [publishedPath stringByAppendingPathComponent:@"Levels"];
    NSError *error;
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:levelsPath error:&error];
    
    for(NSString *levelName in directoryContents)
    {
        CCLOG(@"levelName: %@", levelName);
        LevelNode *levelnode =(LevelNode *)[CCBReader load:@"levelnode"];
        int levelindex = [[levelName stringByReplacingOccurrencesOfString:@"Level" withString:@""] intValue];
        levelnode.level = levelindex;
        [levelnode setLabels];
        [_LevelBox addChild: levelnode];
    }
}

-(void) back
{
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

-(void) tutorial
{
    CCScene *tScene = [CCBReader loadAsScene:@"Tutorial1"];
    [[CCDirector sharedDirector] replaceScene:tScene];
    
}

@end
