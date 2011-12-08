//
//  Minijuego.m
//  CocosEp2
//
//  Created by Víctor Baro on 07/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Minijuego.h"
#import "HelloWorldLayer.h"

@implementation Minijuego

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Minijuego *layer = [Minijuego node];
	
	// add layer as a child to scene
	[scene addChild: layer];

	// return the scene
	return scene;
}


- (void) returnToMenu{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[HelloWorldLayer node]]];
}

- (void) finishedMovement {
    float x = arc4random()%320;
    float y = arc4random()%480;
    
    id moveTo = [CCMoveTo actionWithDuration:2 position:ccp(x,y)];
    id easeTest = [CCEaseExponentialIn actionWithAction:moveTo];
    [person runAction:easeTest];
    
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
        
        CCMenuItemImage *homeButton = [CCMenuItemImage itemFromNormalImage:@"home.png" selectedImage:@"home.png" target:self selector:@selector(returnToMenu)];
				
        CCMenu *menu = [CCMenu menuWithItems: homeButton, nil];
        menu.position = ccp(30, 450);
        [self addChild:menu];
        
        person = [CCSprite spriteWithFile:@"personaje.png"];
        person.anchorPoint = ccp(0.5,0.5);
        person.position = ccp(160, 240);
        [self addChild:person];
        
        /*
        id moveTo = [CCMoveTo actionWithDuration:2 position:ccp(100,300)];
        id rotation1 = [CCRotateBy actionWithDuration:1 angle:360];
        id moveTo2 = [CCMoveTo actionWithDuration:2 position:ccp(200,10)];
        id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishedMovement)];
        
        [person runAction:[CCSequence actions:moveTo,rotation1, moveTo2, callback, nil]];*/
        
        [self schedule:@selector(finishedMovement) interval:1]; 
        
	}
	return self;
}


- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];
    
    float distance = powf(point.x - person.position.x, 2) + powf(point.y - person.position.y, 2);
    distance = sqrtf(distance);
    
    if (distance <=20) {
        [self stopAllActions];
        id jump1 = [CCJumpTo actionWithDuration:1 position:ccp(point.x+30, point.y) height:60 jumps:1];
        //id easeTest = [CCEaseIn actionWithAction:jump1];
        [person runAction:jump1];
        
        [self unschedule:@selector(finishedMovement)];
    }
}


@end
