//
//  Block.h
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/23.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Block : CCNode
- (void) setRefs: (CCNode*) gameplay physics:(CCPhysicsNode *)physicsNode;
- (void)BlocktouchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event;
- (void)BlocktouchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event;
- (void)BlocktouchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event;
- (void)BlocktouchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event;

@end
