//
//  GameScene.m
//  MGWUGameTemplate
//
//  Created by Yun on 2/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "Block.h"
#import "Level.h"
#import "CCDragSprite.h"
#import "WinPopup.h"
#import "LostPopup.h"
#import "CCPhysics+ObjectiveChipmunk.h"

#define M_PI   3.14159265358979323846264338327950288
#define APPLE_POINT 100
#define BERRY_POINT 200
#define GRAPE_POINT 150

@implementation GameScene
{
    //declares private variables
    CCPhysicsNode *_physicsNode;
    CCNode *_catNode;
    CCNode *_levelNode;
    CCNode *_ccNode;  // top level node
    CCLabelTTF *_scoreLabel; // show current score
    Level *_loadedLevel; // container for level
    NSMutableArray * _blockArray;
    Block *_blockNode;
    CCNode* love;
    int _score;   // record score of current level
    int _currentLevel;   // current level
    int _numLevels;   // total number of levels
    CCNode *_onboardNode;
    
    CCTimer *_levelTimer;
    CCTime _timeLimit;
    CCTime _timeTaken;
    CCLabelTTF *_timerLabel;
    
    BOOL appleDetact;
    BOOL grapeDetact;
    BOOL berryDetact;
}

-(void) didLoadFromCCB
{
    // enabe receiving input events
    self.userInteractionEnabled = YES;
    _physicsNode.collisionDelegate = self;
    //_physicsNode.debugDraw = TRUE;
}

-(void) onEnter{
    [super onEnter];
     _blockArray = [[NSMutableArray alloc] init];
    _currentLevel = self.level;
    _numLevels = 8;
    [self loadLevel:(_currentLevel)];
}

-(void)loadLevel:(int)currentLevel{

    
    // Load level from storage
    [self resetWorld];

    CCLOG(@"Load level %i", currentLevel);
    Level *level = (Level*)[CCBReader load:[NSString stringWithFormat:@"Levels/Level%i", currentLevel]];
    
    [_levelNode addChild:level];
    
    // Add all the block _blockArray
    NSArray *levelitems = [level.children copy];
    CCLOG(@"%li children in this level", (long)levelitems.count);

    for(int i = 0; i<levelitems.count; i++)
    {
        CCNode *node = levelitems[i];
        
        if([node isKindOfClass:[Block class]])
        {
            CCLOG(@"get one block");
            Block *block = (Block*) node;
            [_blockArray addObject: block];
            [block setRefs: self physics:_physicsNode];
        }
    }
    _timeLimit = 45.0;
    
    //if(currentLevel == 1)
    //{
    //    CCLOG(@"load onboard 1");
        //Load Onboarding #1
      //  Onboard *_onOne = (Onboard*) [CCBReader load:@"Onboard1" owner:self];
       // _onOne.position = ccp(0,0);
       // [_onboardNode addChild:_onOne];
        //[self setPaused:true];
    //}
    
    love = [CCBReader load:@"love"];
    love.visible = FALSE;
    [_ccNode addChild:love];
    
    //Schedule Timer
    [self schedule:@selector(updateTimer:) interval: 1.0];
    _timeTaken = 0;
    
    appleDetact = FALSE;
    grapeDetact = FALSE;
    berryDetact = FALSE;

}


-(void)updateTimer:(CCTime)delta{
    //this is called every second
    CCLOG(@"update timer");
    if((_timeLimit - _timeTaken) >= 0){
        //CCLOG(@"updateTimer: %f", _timeTaken);
        if((_timeLimit - _timeTaken) <= 3.0){
            _timerLabel.color = CCColor.redColor;
        }
        _timerLabel.string = [NSString stringWithFormat:@"0:%.0f", _timeLimit - (_timeTaken++)];
    }else{
        //ran out of time
        if((appleDetact == FALSE)&&(grapeDetact == FALSE) && (berryDetact == FALSE))
        {
            CCLOG(@"you lost");
            self.paused = YES;
            [self setFinalScore];
            LostPopup *popup = (LostPopup *)[CCBReader load:@"LostPopup" owner:self];
            popup.positionType = CCPositionTypeNormalized;
            popup.anchorPoint = ccp(0.5,0.5);
            popup.position = ccp(0.5, 0.5);
            [self addChild:popup];
        }
        else
        {
            self.paused = YES;
            [self setFinalScore];
            WinPopup *popup = (WinPopup *)[CCBReader load:@"WinPopup" owner:self];
            popup.winPopScore.string = [NSString stringWithFormat:@"%d", _score];
            [popup setPoints:_score];
            [popup setLevel:_currentLevel];
            popup.positionType = CCPositionTypeNormalized;
            popup.anchorPoint = ccp(0.5,0.5);
            popup.position = ccp(0.5, 0.5);
            [self addChild:popup];
        }
    }
    
}


- (void) setFinalScore{
    // Close the lid, displaying the results for the level
    CCTime timeLeft = _timeLimit - _timeTaken;
    _score = _score + timeLeft * 100;
}



-(void)resetWorld
{
    [_levelNode removeAllChildren];
    [_ccNode removeChildByName:@"love"];
    [_ccNode removeChildByName:@"WinPopup"];
    [_ccNode removeChildByName:@"LostPopup"];
    //[_onboardNode removeAllChildren];
    
    [_physicsNode removeChildByName:@"block"];
    [_physicsNode removeChildByName: @"stone"];

    //[_blockArray init];
    _score = 0;
    _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
    
    _timerLabel.color = CCColor.whiteColor;
}

- (void)update:(CCTime)delta
{
    if([self checkForWin]){
        self.paused = YES;
        [self setFinalScore];
        WinPopup *popup = (WinPopup *)[CCBReader load:@"WinPopup" owner:self];
        popup.winPopScore.string = [NSString stringWithFormat:@"%d", _score];
        [popup setPoints:_score];
        [popup setLevel:_currentLevel];
        popup.positionType = CCPositionTypeNormalized;
        popup.anchorPoint = ccp(0.5,0.5);
        popup.position = ccp(0.5, 0.5);
        [self addChild:popup];
    }
}

-(BOOL)checkForWin{
    // Leaving this wrapper in case I want to add more win conditions
    if((appleDetact == TRUE) && (berryDetact == TRUE) && (grapeDetact == TRUE) )
        return TRUE;
    else
        return FALSE;
}

-(void)gameOverWithStatus: (BOOL) won {
    CCLOG(@"Win level %i", _currentLevel);
}

- (void)loadNextLevel {
    CCLOG(@"load next level");
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameScene"];
    // Set the level by getting the gameplay from scene and setting level property
    ((GameScene *)[gameplayScene children][0]).level = (_currentLevel%_numLevels)+1;
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)loadThisLevel {
    CCLOG(@"load this level");
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameScene"];
    // Set the level by getting the gameplay from scene and setting level property
    ((GameScene *)[gameplayScene children][0]).level = (_currentLevel%_numLevels);
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

// apple collision handling
- (void)appleRemoved:(CCNode *)apple {
    [apple removeFromParent];
}
- (void)appleJointRemoved: (CCNode *)apple
{
    CCLOG(@"remove apple joint node!");
    CCNode* parent =apple.parent;
    [parent removeChildByName: @"applejoint"];
}

// apple hit cat
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair apple:(CCNode *)nodeA cat:(CCNode *)nodeB
{
    CCLOG(@"I eat apple!");
    [[_physicsNode space] addPostStepBlock:^{
        [self appleRemoved:nodeA];
    } key:nodeA];
    
    if(appleDetact == FALSE)
    {
        _score = _score + APPLE_POINT;
        _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
        appleDetact = TRUE;
    }
    
    love.visible = TRUE;
    love.position = _catNode.position;
    CCAnimationManager* animationManager = love.animationManager;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"happy"];

    if([self checkForWin]){
        [self gameOverWithStatus: YES];
    }
    return YES;
}

// apple hit stone
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair apple:(CCNode *)nodeA stone:(CCNode *)nodeB
{
    CCLOG(@"stone hit apple!");
    [[_physicsNode space] addPostStepBlock:^{
        [self appleJointRemoved:nodeA];
    } key:nodeA];
    
    return YES;
}

// berry collision handling
- (void)berryRemoved:(CCNode *)berry {
    [berry removeFromParent];
}
- (void)berryJointRemoved: (CCNode *)berry
{
    CCLOG(@"remove berry joint node!");
    CCNode* parent =berry.parent;
    [parent removeChildByName: @"berryjoint"];
}
// berry hit cat
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair berry:(CCNode *)nodeA cat:(CCNode *)nodeB
{
    CCLOG(@"I eat berry!");
    //float energy = [pair totalKineticEnergy];
    // if energy is large enough, remove the seal
    [[_physicsNode space] addPostStepBlock:^{
        [self berryRemoved:nodeA];
    } key:nodeA];
    
    if(berryDetact == FALSE)
    {
        _score = _score + BERRY_POINT;
        _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
        berryDetact = TRUE;
    }
    
    love.visible = TRUE;
    love.position = _catNode.position;
    CCAnimationManager* animationManager = love.animationManager;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"happy"];
    
    if([self checkForWin]){
        [self gameOverWithStatus: YES];
    }
    
    return YES;
}
// berry hit stone
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair berry:(CCNode *)nodeA stone:(CCNode *)nodeB
{
    CCLOG(@"stone hit berry!");
    [[_physicsNode space] addPostStepBlock:^{
        [self berryJointRemoved:nodeA];
    } key:nodeA];
    
    return YES;
}

// grape collision handling
- (void)grapeRemoved:(CCNode *)grape {
    [grape removeFromParent];
}
- (void)grapeJointRemoved: (CCNode *)grape
{
    CCLOG(@"remove grape joint node!");
    CCNode* parent =grape.parent;
    [parent removeChildByName: @"grapejoint"];
}

// grape hit cat
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair grape:(CCNode *)nodeA cat:(CCNode *)nodeB
{
    CCLOG(@"I eat grape!");
    [[_physicsNode space] addPostStepBlock:^{
        [self grapeRemoved:nodeA];
    } key:nodeA];
    
    if(grapeDetact == FALSE)
    {
        _score = _score + GRAPE_POINT;
        _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
        grapeDetact = TRUE;
    }
    
    love.visible = TRUE;
    love.position = _catNode.position;
    CCAnimationManager* animationManager = love.animationManager;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"happy"];
    
    if([self checkForWin]){
        [self gameOverWithStatus: YES];
    }
    
    return YES;
}
// grape hit stone
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair grape:(CCNode *)nodeA stone:(CCNode *)nodeB
{
    CCLOG(@"stone hit grape!");
    [[_physicsNode space] addPostStepBlock:^{
        [self grapeJointRemoved:nodeA];
    } key:nodeA];
    
    return YES;
}
// stone hit ground
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair stone:(CCNode *)nodeA ground:(CCNode *)nodeB
{
    CCLOG(@"stone hit ground!");
    [[_physicsNode space] addPostStepBlock:^{
        [self stoneRemoved:nodeA];
    } key:nodeA];
    
    return YES;
}
// stone hit cat
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair stone:(CCNode *)nodeA cat:(CCNode *)nodeB
{
    CCLOG(@"stone hit cat!");
    [[_physicsNode space] addPostStepBlock:^{
        [self stoneRemoved:nodeA];
    } key:nodeA];
    
    return YES;
}
- (void)stoneRemoved:(CCNode *)stone {
    [stone removeFromParent];
}


// called on every touch in this scene
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInNode: _levelNode];
    //CCLOG(@"the block origin is %f, %f" ,[_blockNode boundingBox].origin.x, [_blockNode boundingBox].origin.y);
    //CCLOG(@"the block size is %f, %f" ,[_blockNode boundingBox].size.height, [_blockNode boundingBox].size.width);
    //CCLOG(@"touch location is %f, %f", touchLocation.x, touchLocation.y);
    BOOL pointInBlock = 0;
    for(int i = 0; i < _blockArray.count; i++)
    {
        Block *block = _blockArray[i];
        if (CGRectContainsPoint([block boundingBox], touchLocation))
        {
            [block BlocktouchBegan: touch withEvent: event];
            pointInBlock = 1;
            _blockNode = block;
            CCLOG(@"Gameplay touch - move block");
        }
    }
    if(!pointInBlock)
    {
        [self launchStone: touchLocation];
        _blockNode = NULL;
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
    [self resetWorld];
    [self loadLevel:(_currentLevel)];
}

- (void)launchStone: (CGPoint)targetPosition{
    
    double launchAngel, rotationAngel;
    
    CCLOG(@"target position is %f, %f", targetPosition.x, targetPosition.y);
    //CCLOG(@"cat position is %f, %f", _catNode.position.x, _catNode.position.y);
    if (targetPosition.x == self.boundingBox.size.width/2){
        launchAngel = M_PI/2;
        rotationAngel = 0;
    }
    else if(targetPosition.x < self.boundingBox.size.width/2) {
        launchAngel = atan(targetPosition.y/(self.boundingBox.size.width/2 - targetPosition.x));
        launchAngel = atan((targetPosition.y - _catNode.position.y)/(-targetPosition.x + _catNode.position.x));
        rotationAngel = launchAngel*180/M_PI - 90;
    }
    else {
        launchAngel = atan(targetPosition.y/(targetPosition.x - self.boundingBox.size.width/2));
        launchAngel = atan((targetPosition.y - _catNode.position.y)/(targetPosition.x - _catNode.position.x));
        rotationAngel = 90 - launchAngel*180/M_PI;
    }
    
    
    // launch laser
    CCNode* stone = [CCBReader load:@"stone"];
    stone.position = ccpAdd(_catNode.position, ccp(0, 0));
    //stone.position = ccp(0, 0);
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
    
    double SPEED = 300;
    CGPoint force = ccpMult(launchDirection, SPEED);
    CCLOG(@"%@", NSStringFromCGPoint(force));
    
    [stone.physicsBody applyImpulse:force];


}




-(void) exitButtonPressed
{
    NSLog(@"Get me outa here");
    CCScene* scene = [CCBReader loadAsScene:@"LevelSelect"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

@end