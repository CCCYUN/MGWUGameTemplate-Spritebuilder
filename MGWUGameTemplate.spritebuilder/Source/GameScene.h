//
//  GameScene.h
//  MGWUGameTemplate
//
//  Created by Yun on 2/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface GameScene : CCNode <CCPhysicsCollisionDelegate>
@property (nonatomic, assign) int level;
- (void) retry;
@end
