//
//  BackgroundLayer.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/2/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

-(id)init
{
    //Creates an initialized instance of the superclass of the BackgroundLayer class, which in this case is CCLayer.
    self = [super init];

    //Checks to make sure this instance is not nil.
    if (self != nil)
    {                                             
        //Checks to see if Space Viking is running on the iPad or the iPhone.
        CCSprite *backgroundImage;
        
        //The spriteWithFile method call creates a texture from the image file and associates it with the CCSprite object. The sprite’s dimensions and corresponding geometry are set to the image dimensions.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // Indicates game is running on iPad
            backgroundImage = [CCSprite
                               spriteWithFile:@"background.png"];
        }
        else
        {
            backgroundImage = [CCSprite
                               spriteWithFile:@"backgroundiPhone.png"];
        }
        
        //Gets the screen size from the Cocos2D Director. On the iPad, this returns 1024 × 768 pixels.
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //Sets the position of the backgroundImage sprite to the center of the screen.
        [backgroundImage setPosition:
         CGPointMake(screenSize.width/2, screenSize.height/2)];    
        
        //Adds the backgroundImage to the backgroundLayer with the z and tag values set to zero. The z values are used by Cocos2D to composite the sprites and layers onscreen. The higher the z value, the closer to the front of the screen an object is. For sprites, you need to keep track of which layer the sprite is in, as well. If a sprite has a z value of 100 but is still in the backmost layer (with the lowest z value), it will be rendered behind other sprites in layers with a higher z value.
        [self addChild:backgroundImage z:0 tag:0];                 
    }
    //Returns the newly initialized BackgroundLayer class.
    return self;                                                  
}

@end
