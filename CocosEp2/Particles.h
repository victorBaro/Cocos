//
//  Particles.h
//  CocosEp2
//
//  Created by Víctor Baro on 16/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Particles : CCLayer{
    CCParticleMeteor *emitter;
    CCSprite *homeButton;
    
}

//@property (nonatomic, retain) CCScene *particles1;

+(CCScene *) particles1;

@end
