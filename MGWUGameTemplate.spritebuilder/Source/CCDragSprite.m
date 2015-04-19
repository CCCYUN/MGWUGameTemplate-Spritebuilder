//
//  CCDragSprite.m
//  MGWUGameTemplate
//
//  Created by Yun on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCDragSprite.h"

@implementation CCDragSprite

- (void)onEnter {
    self.userInteractionEnabled = TRUE;
}
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
}
- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self.parent];
    self.position = touchLocation;
}

@end
