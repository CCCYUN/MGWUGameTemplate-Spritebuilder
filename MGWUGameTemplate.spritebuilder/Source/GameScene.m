//
//  GameScene.m
//  MGWUGameTemplate
//
//  Created by Yun on 2/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "Block.h"
#import "CCDragSprite.h"
#import "CCPhysics+ObjectiveChipmunk.h"

#define M_PI   3.14159265358979323846264338327950288

@implementation GameScene
{
    //declares private variables
    CCPhysicsNode *_physicsNode;
    CCNode *_catNode;
    CCNode *_levelNode;
    CCNode *_ccNode;
    CCNode *_groundNode;
    CCSprite *currentMirror;
    
    CCNode *_AppleJointNode;
    Block *_blockNode;
}

-(void) didLoadFromCCB
{
    // enabe receiving input events
    self.userInteractionEnabled = YES;
    
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild: level];
    
    NSArray *levelnodes = [level.children copy];
    CCNode *nodeA = levelnodes[0];
    NSArray *childnodes = [nodeA.children copy];
    for (int i = 0; i < childnodes.count; i++) {
        CCNode *nodeB= childnodes[i];
        if([nodeB isKindOfClass:[Block class]])
        {
            CCLOG(@"I'm a block");
            _blockNode = (Block*)nodeB;
            [_blockNode setRefs: self];
        }
    }
    
    _physicsNode.debugDraw = TRUE;
    _physicsNode.collisionDelegate = self;


}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair apple:(CCNode *)nodeA cat:(CCNode *)nodeB
{
    CCLOG(@"I eat apple!");
    //float energy = [pair totalKineticEnergy];
    // if energy is large enough, remove the seal
    [[_physicsNode space] addPostStepBlock:^{
        [self appleRemoved:nodeA];
    } key:nodeA];
    
    CCNode* love = [CCBReader load:@"love"];
    love.position = ccpAdd(_catNode.position, ccp(0, 0));
    [_ccNode addChild:love];
    
}


- (void)appleRemoved:(CCNode *)apple {
    [apple removeFromParent];
}

- (void)appleJointRemoved: (CCNode *)apple
{
    CCLOG(@"remove apple joint node!");
    CCNode* parent =apple.parent;
    [parent removeChildByName: @"applejoint"];
}


-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair apple:(CCNode *)nodeA stone:(CCNode *)nodeB
{
    CCLOG(@"stone hit apple!");
    [[_physicsNode space] addPostStepBlock:^{
        [self appleJointRemoved:nodeA];
    } key:nodeA];
}

- (void)berryRemoved:(CCNode *)berry {
    [berry removeFromParent];
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair grape:(CCNode *)nodeA cat:(CCNode *)nodeB
{
    CCLOG(@"I eat grape!");
    //float energy = [pair totalKineticEnergy];
    // if energy is large enough, remove the seal
    [[_physicsNode space] addPostStepBlock:^{
        [self grapeRemoved:nodeA];
    } key:nodeA];
    
    CCNode* love = [CCBReader load:@"love"];
    love.position = ccpAdd(_catNode.position, ccp(0, 0));
    [_ccNode addChild:love];

}

- (void)grapeRemoved:(CCNode *)grape {
    [grape removeFromParent];
}

- (void)stoneRemoved:(CCNode *)stone {
    [stone removeFromParent];
}


// called on every touch in this scene
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInNode: _ccNode];
    
    CCLOG(@"block size %@", _blockNode.boundingBox.size.width);
    
    
    if (CGRectContainsPoint([_blockNode boundingBox], touchLocation))
    {
        [_blockNode BlocktouchBegan: touch withEvent: event];
        CCLOG(@"Gameplay touch - move block");
    }
    else
    {
        [self launchStone: touchLocation];
        CCLOG(@"Gameplay touch - shoot");
    }
}


- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [_blockNode BlocktouchMoved: touch withEvent: event];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
    [_blockNode BlocktouchEnded: touch withEvent: event];
}
- (void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [_blockNode BlocktouchCancelled: touch withEvent: event];
}



- (void) retry {
    // reload this level
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"GameScene"]];
}

- (void)launchStone: (CGPoint)targetPosition{
    
    double launchAngel, rotationAngel;
    
    if (targetPosition.x == self.boundingBox.size.width/2){
        launchAngel = M_PI/2;
        rotationAngel = 0;
    }
    else if(targetPosition.x < self.boundingBox.size.width/2) {
        launchAngel = atan(targetPosition.y/(self.boundingBox.size.width/2 - targetPosition.x));
        rotationAngel = launchAngel*180/M_PI - 90;
    }
    else {
        launchAngel = atan(targetPosition.y/(targetPosition.x - self.boundingBox.size.width/2));
        rotationAngel = 90 - launchAngel*180/M_PI;
    }
    
    
    // launch laser
    CCNode* stone = [CCBReader load:@"stone"];
    stone.position = ccpAdd(_catNode.position, ccp(0, 0));
    stone.rotation = rotationAngel;
    
    [_physicsNode addChild:stone];
    
    CGPoint launchDirection;
    
    if (targetPosition.x < self.boundingBox.size.width/2) {
        launchDirection.x = -cos(launchAngel);
        launchDirection.y = sin(launchAngel) ;
    }
    else {
        launchDirection.x = cos(launchAngel);
        launchDirection.y = sin(launchAngel);
    }
    
    double SPEED = 800;
    CGPoint force = ccpMult(launchDirection, SPEED);
    CCLOG(@"%@", NSStringFromCGPoint(force));
    
    [stone.physicsBody applyImpulse:force];


}




-(void) exitButtonPressed
{
    NSLog(@"Get me outa here");
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

@end