//
//  LevelNode.h
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/29.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface LevelNode : CCNode
@property (nonatomic, assign) int level;
-(void)setLabels;
@end
