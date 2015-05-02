//
//  Block.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/23.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Block.h"

@implementation Block
{
    CGPoint _originalPos;
    CCNode* _gameplay;
    CCPhysicsNode *_physicsNode;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = YES;
    _originalPos = self.positionInPoints;
}

-(void)setRefs:(CCNode *)gameplay physics:(CCPhysicsNode *)physicsNode;
{
    _gameplay = gameplay;
    _physicsNode = physicsNode;
    CCLOG(@"Set gameplay");
}

- (void) onEnter{
    [super onEnter];
    CCLOG(@"ON_ENTER");
    CCLOG(@"_parent set to %@", self.parent.class);
}
    

- (void)BlocktouchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
    CCLOG(@"TOUCH_BEGAN");
    
    // First check to see if the touch hits board
    CGPoint touchLocationInSelf = [touch locationInNode:self];
    CCLOG(@"Touch location in self: %f, %f", touchLocationInSelf.x, touchLocationInSelf.y);
    
    // Remove from current parent (either level or bag)
    //CCLOG(@"Removing from %@", self.parent.class);
    CGPoint posInGameplay = [_gameplay convertToNodeSpace:[self.parent convertToWorldSpace:self.positionInPoints]];
    //[self removeFromParentAndCleanup:NO];
    
    // Add to Gameplay and preserve previous position
    //[_physicsNode addChild :self];
    //[_physicsNode addChild:self];

    [self setPositionInPoints:posInGameplay];
    CCLOG(@"Added to %@", self.parent);
    CCLOG(@"Position before rotate: %f, %f", self.positionInPoints.x, self.positionInPoints.y);
}


- (void)BlocktouchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self.parent];
    // make the tile follow the touch
    self.positionInPoints = touchLocation;
    //CCLOG(@"Position after  rotate: %f, %f", self.positionInPoints.x, self.positionInPoints.y);
    
}

- (void)BlocktouchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CCLOG(@"TOUCH_ENDED");
    [self drop];
}

- (void)BlocktouchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CCLOG(@"TOUCH_CANCELLED");
    [self drop];
}

- (void)drop{
    //Do the whole drop algorithm here
    CCLOG(@"Item dropped. Checking to see if the position is valid..");
    
}


@end
