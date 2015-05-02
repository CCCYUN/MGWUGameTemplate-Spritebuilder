//
//  WinPopup.h
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface WinPopup : CCNode
@property (nonatomic, assign) CCLabelTTF *winPopScore;
-(void) setPoints: (int) score;
-(void) setLevel: (int) levelInGame;

@end
