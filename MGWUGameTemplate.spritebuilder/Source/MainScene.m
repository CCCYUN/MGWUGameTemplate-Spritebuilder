//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@implementation MainScene

-(void) play
{
    CCLOG(@"play button pressed");
    CCScene* scene = [CCBReader loadAsScene:@"LevelSelect"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:1.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}

-(void) share
{
    [[CCDirector sharedDirector] pause];
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    // this should link to FB page for your app or AppStore link if published
    // URL of image to be displayed alongside post
    content.contentURL = [NSURL URLWithString:@"http://www.andrew.cmu.edu/user/yuncao/FaceBookSharePic.jpg"];
    content.imageURL = [NSURL URLWithString:@"http://www.andrew.cmu.edu/user/yuncao/FaceBookSharePic.jpg"];
    // title of post
    content.contentTitle = @"I'm playing Cat In The Wood! Awesome game！";
    // description/body of post
    content.contentDescription = @"Check out Cat In The Wood！";
    
    [FBSDKShareDialog showFromViewController:[CCDirector sharedDirector]
                                 withContent:content
                                    delegate:nil];

}

@end
