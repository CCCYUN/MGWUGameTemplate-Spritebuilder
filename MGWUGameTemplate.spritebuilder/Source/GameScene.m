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
    CCPhysicsNode *_physicsNode;
    CCNode *_catNode;
    
}

-(void) didLoadFromCCB
{
    NSLog(@"GameScene created");
    
    // enabe receiving input events
    self.userInteractionEnabled = YES;

}


// called on every touch in this scene
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    [self launchLaser];
}

- (void)launchLaser{
    // loads the Penguin.ccb we have set up in Spritebuilder
    CCNode* laser = [CCBReader load:@"Laser"];
    // position the penguin at the bowl of the catapult
    laser.position = ccpAdd(_catNode.position, ccp(0, 0));
    
    // add the penguin to the physicsNode of this scene (because it has physics enabled)
    [_physicsNode addChild:laser];
    
    // manually create & apply a force to launch the penguin
     CGPoint launchDirection = ccp(1, 0);
     CGPoint force = ccpMult(launchDirection, 80000);
     [laser.physicsBody applyForce:force];
}




-(void) exitButtonPressed
{
    NSLog(@"Get me outa here");
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

@end