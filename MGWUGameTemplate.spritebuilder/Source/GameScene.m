//
//  GameScene.m
//  MGWUGameTemplate
//
//  Created by Yun on 2/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "CCDragSprite.h"


@implementation GameScene
{
    //declares private variables
    CCPhysicsNode *_physicsNode;
    CCNode *_catNode;
    CCNode *_slingShot;
    CCNode *_levelNode;
    CCSprite *currentMirror;
}



-(void) didLoadFromCCB
{
    NSLog(@"GameScene created");
    
    // enabe receiving input events
    self.userInteractionEnabled = YES;
    
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild: level];
    _physicsNode.collisionDelegate = self;
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair nest:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    CCLOG(@"Something collided with a nest!");
    float energy = [pair totalKineticEnergy];
    // if energy is large enough, remove the seal
    if (energy > 5000.f) {
        [self nestRemoved:nodeA];
    }
    
}

- (void)nestRemoved:(CCNode *)nest {
    [nest removeFromParent];
}




// called on every touch in this scene
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    // the location of touch in the scene
    CGPoint touchLocation = [touch locationInView:nil];
    [self launchLaser:touchLocation];
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    //currentMirror = [CCDragSprite spriteWithImageNamed:@"Gem-Blue"];
    //currentHero.position = touchLocation;
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    currentMirror = nil;
}
- (void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    currentMirror = nil;
}



- (void) retry {
    // reload this level
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"GameScene"]];
}

- (void)launchLaser: (CGPoint)targetPosition{
   
    
    
    
    //float MIN_OFFSET = 10;
    
    //if (ccpLength(offset) < MIN_OFFSET) return;
    //CGPoint _shootVector = ccpNormalize(offset);
    
    //CGFloat angle = ccpToAngle(_shootVector);
    
    // _catNode.rotation = (1 * CC_RADIANS_TO_DEGREES(angle));
    
    //CGSize _levelSize = [CCDirector sharedDirector].viewSize;
    
    //float mapMax = MAX(_levelSize.width , _levelSize.height );
    //CGPoint actualVector = ccpMult(_shootVector, mapMax);
    
    //float POINTS_PER_SECOND = 300;
    //float duration = mapMax / POINTS_PER_SECOND;
    
    // CGFloat speed = 4.5;
    // CGFloat distance = ccpDistance(node.position, targetPosition);
    // CGFloat duration = distance / speed;
    
    
    // loads the Laser we have set up in Spritebuilder
    CCNode* laser = [CCBReader load:@"Laser"];
    
    // position the penguin at the bowl of the catapult
    laser.position = ccpAdd(_slingShot.position, ccp(0, 0));
    //laser.rotation = (1 * CC_RADIANS_TO_DEGREES(angle));
    CGPoint offset = ccpSub(targetPosition, laser.position);
    CGPoint _shootVector = ccpNormalize(offset);
    CGFloat angle = ccpToAngle(_shootVector);
    
    //CCActionMoveBy * move = [CCActionMoveBy actionWithDuration:duration position:actualVector];
    
    //CCActionCallBlock *call = [CCActionCallBlock actionWithBlock:^{
       // [laser removeFromParentAndCleanup:YES];
    //}];
    
    //[laser runAction:[CCActionSequence actions:move, nil]];
    //[self addChild:laser];
    //[_physicsNode addChild:laser];

    
    
    // add the penguin to the physicsNode of this scene (because it has physics enabled)
    [_physicsNode addChild:laser];
    
    // manually create & apply a force to launch the penguin
     CGPoint launchDirection = _shootVector;
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