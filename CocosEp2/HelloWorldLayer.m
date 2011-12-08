//
//  HelloWorldLayer.m
//  CocosEp2
//
//  Created by Víctor Baro on 11/11/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "Particles.h"
#import "Minijuego.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    
    
	// return the scene
	return scene;
}

- (void) loadParticles{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionJumpZoom transitionWithDuration:1 scene:[Particles node]]];
    
}


- (void) loadMiniJuego{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Minijuego node]]];
}

- (void) loadFisicas{
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
		CCSprite *background = [CCSprite spriteWithFile:@"fondo1.png"];
        background.anchorPoint = ccp(0,0);
        
        [self addChild:background z:-1];
		// ask director the the window size
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
	
        //Por si queremos crear menús a partir de imágenes
        //CCMenuItemImage *menu1 = [CCMenuItemImage itemFromNormalImage:@"icon.png" selectedImage:@"icon.png" target:self selector:@selector(loadParticles)];
        
        CCMenuItemFont *menu1 = [CCMenuItemFont itemFromString:@"Particles" target:self selector:@selector(loadParticles)];
        //Por si queremos cambiarle el color a las fuentes del texto
        //menu1.color = ccc3(0, 0, 0); 
        
        CCMenuItemFont *menu2 = [CCMenuItemFont itemFromString:@"Mini Juego 1" target:self selector:@selector(loadMiniJuego)];
        
        CCMenuItemFont *menu3 = [CCMenuItemFont itemFromString:@"Juego Físicas" target:self selector:@selector(loadFisicas)];
        
        CCMenu *menu = [CCMenu menuWithItems:menu1, menu2, menu3, nil];
        
        menu.position = ccp(windowSize.width/2, windowSize.height/2);
        
        [menu alignItemsVerticallyWithPadding:50];
        [self addChild:menu];
		
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
