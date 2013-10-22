//
//  HelloWorldLayer.m
//  SNSPost
//
//  Created by masanorythm on 2013/10/23.
//  Copyright masanorythm 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "SNSPost.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        [CCMenuItemFont setFontName:@"Helvetica"];
        [CCMenuItemFont setFontSize:24];
        
        CCMenuItemFont *facebook = [CCMenuItemFont itemWithString:@"Facebook"
                                                           target:self
                                                         selector:@selector(pressedFacebook:)];
        
        CCMenuItemFont *twitter = [CCMenuItemFont itemWithString:@"Twitter"
                                                          target:self
                                                        selector:@selector(pressedTwitter:)];
        
        CCMenuItemFont *line = [CCMenuItemFont itemWithString:@"LINE"
                                                       target:self
                                                     selector:@selector(pressedLine:)];
        CCMenu *menu = [CCMenu menuWithItems:facebook, twitter, line, nil];
        [menu setPosition:ccp(winSize.width * 0.5f, winSize.height * 0.5f)];
        [menu alignItemsVertically];
        [self addChild:menu];
	}
	return self;
}


- (void) pressedFacebook:(id)sender
{
    [SNSPost postWithFacebook:@"test message"];
}

- (void) pressedTwitter:(id)sender
{
    [SNSPost postWithTwitter:@"test message"];
}

- (void) pressedLine:(id)sender
{
    [SNSPost postWithLineText:@"test message"];
}

- (void) dealloc
{
	[super dealloc];
}

@end
