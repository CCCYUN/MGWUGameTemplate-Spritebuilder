//
//  GameScene.m
//  MGWUGameTemplate
//
//  Created by Yun on 2/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
{
    //declares private variables
    __weak CCNode* _levelNode;
    __weak CCPhysicsNode* _physicsNode;
    __weak CCNode* _playerNode;
    __weak CCNode* _backgroundNode;
}

-(void) didLoadFromCCB
{
    NSLog(@"GameScene created");
    
    // enabe receiving input events
    self.userInteractionEnabled = YES;
    
    // load the current level
    [self loadLevelNamed:nil];
}

-(void) loadLevelNamed:(NSString*)levelCCB
{
    // get the current level's player in the scene by searching for it recursively
    _playerNode = [self getChildByName:@"player" recursively:YES];
    NSAssert1(_playerNode, @"player node not found in level: %@", levelCCB);
};

-(void) touchBegan:(UITouch*)touch withEvent:(UIEvent*)event
{
    _playerNode.position = [touch locationInView:self];
}


-(void) exitButtonPressed
{
    NSLog(@"Get me outa here");
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

@end