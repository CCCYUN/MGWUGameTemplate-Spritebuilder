//
//  WinPopup.m
//  MGWUGameTemplate
//
//  Created by Yun on 15/4/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "WinPopup.h"
#import "GameScene.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation WinPopup
{
    int points;
    int level;
    CCNode *_starone;
    CCNode *_startwo;
    CCNode *_starthree;
}

-(void) setPoints: (int) score
{
    points = score;
}

-(void) setLevel: (int) levelInGame
{
    level = levelInGame;
}


-(void) share {
    
    [[CCDirector sharedDirector] pause];
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    // this should link to FB page for your app or AppStore link if published
    // URL of image to be displayed alongside post
    content.contentURL = [NSURL URLWithString:@"http://www.andrew.cmu.edu/user/yuncao/FaceBookSharePic.jpg"];
    content.imageURL = [NSURL URLWithString:@"http://www.andrew.cmu.edu/user/yuncao/FaceBookSharePic.jpg"];
    // title of post
    content.contentTitle = [NSString stringWithFormat:@"My Cat In The Wood Score is %d on Level %d! ", points, level];
    // description/body of post
    content.contentDescription = @"Check out Cat In The Wood and See if you can beat me!";
    
    [FBSDKShareDialog showFromViewController:[CCDirector sharedDirector]
                                 withContent:content
                                    delegate:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
    [[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
    [[CCDirector sharedDirector] startAnimation];
}

@end
