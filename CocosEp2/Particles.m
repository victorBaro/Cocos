//
//  Particles.m
//  CocosEp2
//
//  Created by Víctor Baro on 16/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Particles.h"
#import "HelloWorldLayer.h"


@implementation Particles

//@synthesize particles1;

+(CCScene *) particles1
{
	// 'scene' is an autorelease object.
	CCScene *particles1 = [CCScene node];
	
	// 'layer' is an autorelease object.
	Particles *layer = [Particles node];
	
	// add layer as a child to scene
	[particles1 addChild: layer];
    
    CCSprite *background = [CCSprite spriteWithFile:@"fondo1.png"];
	background.anchorPoint = ccp(0,0);
    
    [layer addChild:background z:-1];
    
	// return the scene
	return particles1;
}


-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        self.isTouchEnabled = YES;
        
        emitter = [[CCParticleMeteor alloc]init];
        emitter.texture = [[CCTextureCache sharedTextureCache] addImage:@"star.png"];
        emitter.position = ccp(240, 160);
        [self addChild:emitter];
		
        
        homeButton = [CCSprite spriteWithFile:@"home.png"];
        homeButton.anchorPoint = ccp(0.5,0.5);
        homeButton.position = ccp(30,450);
        [self addChild:homeButton];
        
	}
	return self;
}





- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];
    emitter.position = ccp(point.x, point.y);
    
}




- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];
    emitter.position = ccp(point.x, point.y);
}



- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];
    
    float distance = powf(point.x - homeButton.position.x, 2) + powf(point.y - homeButton.position.y, 2);
    distance = sqrtf(distance);
    
    if (distance <=20) {
         [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[HelloWorldLayer node]]];
    }
    
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    emitter = nil;
    [emitter release];
}


@end
