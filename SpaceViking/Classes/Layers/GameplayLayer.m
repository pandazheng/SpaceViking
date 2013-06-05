//
//  GameplayLayer.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/2/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "GameplayLayer.h"
@implementation GameplayLayer

-(void)initJoystickAndButtons
{
    //Gets the screenSize from the Cocos2D Director. The screenSize is used to calculate the positioning of the joystick and buttons.
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    //Sets up the touch dimensions for the joystick and buttons. The joystick touch dimensions are a rectangle of size 128 × 128 pixels. The jump and attack buttons dimensions are a rectangle of size 64 × 64 pixels.
    CGRect joystickBaseDimensions =
    CGRectMake(0, 0, 128.0f, 128.0f);                      
    CGRect jumpButtonDimensions =
    CGRectMake(0, 0, 64.0f, 64.0f);
    CGRect attackButtonDimensions =
    CGRectMake(0, 0, 64.0f, 64.0f);
    
    //Creates the three CGPoint variables that are used to position the joystick and buttons.
    CGPoint joystickBasePosition;                                 
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    
    //This if/else block uses a calculation for the values so that if the iPad dimensions change, the joystick and buttons will still be in their proper place.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // The device is an iPad running iPhone 3.2 or later.
        CCLOG(@"Positioning Joystick and Buttons for iPad");
        joystickBasePosition = ccp(screenSize.width*0.0625f,
                                   screenSize.height*0.052f);
        
        jumpButtonPosition = ccp(screenSize.width*0.946f,
                                 screenSize.height*0.052f);
        
        attackButtonPosition = ccp(screenSize.width*0.947f,
                                   screenSize.height*0.169f);
    }
    else
    {
        // The device is an iPhone or iPod touch.
        CCLOG(@"Positioning Joystick and Buttons for iPhone");
        joystickBasePosition = ccp(screenSize.width*0.07f,
                                   screenSize.height*0.11f);
        
        jumpButtonPosition = ccp(screenSize.width*0.93f,
                                 screenSize.height*0.11f);
        
        attackButtonPosition = ccp(screenSize.width*0.93f,
                                   screenSize.height*0.35f);
    }
    
    //Allocates and initializes a joystick base. The joystick base will contain the actual joystick and the sprites used to show the static joystick directional pad (DPAD) and the moveable thumb portion of the joystick.
    SneakyJoystickSkinnedBase *joystickBase =
    [[SneakyJoystickSkinnedBase alloc] init];
    
    //Sets the position of the joystick base to the value corresponding to either iPad or iPhone dimensions.
    joystickBase.position = joystickBasePosition;
    
    //Sets the background image of the joystick to the dpadDown.png image. In Space Viking this is a Viking rune–styled directional pad.
    joystickBase.backgroundSprite =
    [CCSprite spriteWithFile:@"dpadDown.png"];
    
    //Sets the thumb portion of the joystick to the joystickDown.png image. This is the image players will move around with their thumbs or fingers.
    joystickBase.thumbSprite =
    [CCSprite spriteWithFile:@"joystickDown.png"];
    
    //Sets the joystick touch area to be a rectangle of 128 × 128 pixels, based on the value of joystickBaseDimensions variable.
    joystickBase.joystick = [[SneakyJoystick alloc]
                             initWithRect:joystickBaseDimensions];
    
    //Assigns the joystick component of the joystick base to the GameplayLayer leftJoystick instance variable.
    leftJoystick = joystickBase.joystick;
    
    //Adds the joystick base to the GameplayLayer instance, making it visible on the lower-left portion of the screen.
    [self addChild:joystickBase];                                 
    
    //Allocates and initializes the jump button base.
    SneakyButtonSkinnedBase *jumpButtonBase =
    [[SneakyButtonSkinnedBase alloc] init];
    
    //Sets the base position onscreen.
    jumpButtonBase.position = jumpButtonPosition;
    
    //Sets the up position of the jump button base to the jumpUp.png image. This is the state of the button if it is not being pressed.
    jumpButtonBase.defaultSprite =
    [CCSprite spriteWithFile:@"jumpUp.png"];
    
    //Sets the activated position of the jump button base to the jumpDown.png image. This is the state of the button if it is toggled to on or down.
    jumpButtonBase.activatedSprite =
    [CCSprite spriteWithFile:@"jumpDown.png"];                    
    
    //Sets the down position of the jump button base. This is the state of the button when the player presses it. Cocos2D textures are cached, so having the same image for the down and activated states of this button loads the jumpDown.png image only once in memory.
    jumpButtonBase.pressSprite =
    [CCSprite spriteWithFile:@"jumpDown.png"];                    
    
    //Sets the touch area of the button to a rectangle of 64 × 64 pixels.
    jumpButtonBase.button = [[SneakyButton alloc]
                             initWithRect:jumpButtonDimensions];
    
    //Assigns the button component of the jump button base to the GameplayLayer jumpButton instance variable.
    jumpButton = jumpButtonBase.button;                
    
    //Sets this button to not act as a toggle. If a button has isToggleable set to YES, pressing it alternates the button state from ON to OFF. If the button has isToggleable set to NO, it turns OFF as soon as the player lifts his or her finger from it.
    jumpButton.isToggleable = NO;                                 
    
    //Adds the jump button base to the GameplayLayer instance, making it visible on the lower-right portion of the screen.
    [self addChild:jumpButtonBase];                               
    
    //Similar process as above, but for the attack and jump buttons
    SneakyButtonSkinnedBase *attackButtonBase =
    
    [[SneakyButtonSkinnedBase alloc] init];             
    attackButtonBase.position = attackButtonPosition;
    
    attackButtonBase.defaultSprite = [CCSprite
                                      spriteWithFile:@"handUp.png"];
    
    attackButtonBase.activatedSprite = [CCSprite
                                        spriteWithFile:@"handDown.png"];
    
    attackButtonBase.pressSprite = [CCSprite
                                    spriteWithFile:@"handDown.png"];
    
    attackButtonBase.button = [[SneakyButton alloc]
                               initWithRect:attackButtonDimensions];
    
    attackButton = attackButtonBase.button;
    
    attackButton.isToggleable = NO;
    
    [self addChild:attackButtonBase];                             
}

#pragma mark –
#pragma mark Update Method
-(void) update:(ccTime)deltaTime
{
    //Gets the list of all of the children CCSprites rendered by the CCSpriteBatchNode. In Space Viking this is a list of all of the GameCharacters, including the Viking and his enemies.
    CCArray *listOfGameObjects =
    [sceneSpriteBatchNode children];
    
    //Iterates through each of the Game Characters, calls their updateStateWithDeltaTime method, and passes a pointer to the list of all Game Characters.
    for (GameCharacter *tempChar in listOfGameObjects)
    {
        //Calls the updateStateWithDeltaTime method on each of the Game Characters. This call allows for all of the characters to update their individual states to determine if they are colliding with any other objects in the game.
        [tempChar updateStateWithDeltaTime:deltaTime andListOfGameObjects:
         listOfGameObjects];                         
    }
}

#pragma mark -
//The createObjectOfType method sets up the enemies using the CCSpriteBatchNode and adds it to the layer.
-(void)createObjectOfType:(GameObjectType)objectType
               withHealth:(int)initialHealth
               atLocation:(CGPoint)spawnLocation
               withZValue:(int)ZValue
{
    if (objectType == kEnemyTypeRadarDish)
    {
        CCLOG(@"Creating the Radar Enemy");
        RadarDish *radarDish = [[RadarDish alloc] initWithSpriteFrameName:
                                @"radar_1.png"];
        [radarDish setCharacterHealth:initialHealth];
        [radarDish setPosition:spawnLocation];
        
        [sceneSpriteBatchNode addChild:radarDish
                                     z:ZValue
                                   tag:kRadarDishTagValue];
    }
}

-(void)createPhaserWithDirection:(PhaserDirection)phaserDirection
                     andPosition:(CGPoint)spawnPosition
{
    CCLOG(@"Placeholder for Chapter 5, see below");
    return;
}

-(void)applyJoystick:(SneakyJoystick *)aJoystick toNode:(CCNode
                                                         *)tempNode forTimeDelta:(float)deltaTime
{
    //Gets the screen size from the Cocos2D Director. On the iPad, this returns 1024 × 768 pixels.
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    //Gets the velocity from the joystick object and multiplies it by 1024, which is used here because it is the size of the iPad screen. The velocity can be multiplied by different factors to make Ole the Viking move faster or slower in relation to the movement of the joystick.
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, screenSize.width); 
    
    //Creates a new position based on the current tempNode position, the joystick velocity, and how much time has elapsed between the last time this method was called and now.
    CGPoint newPosition =
    ccp(tempNode.position.x + scaledVelocity.x * deltaTime,
        tempNode.position.y + scaledVelocity.y * deltaTime);       
    
    //Sets the tempNode position to the newly calculated position. Here tempNode is really a reference to vikingSprite, so this call is placing Ole the Viking at a new position.
    [tempNode setPosition:newPosition];                            
    
    //Checks if the jump button is pressed, and if so, prints a message to the Console.
    if (jumpButton.active == YES)
    {
        CCLOG(@"Jump button is pressed.");
    }
    
    //Checks if the attack button is pressed, and if so, prints a message to the Console.
    if (attackButton.active == YES)
    {
        CCLOG(@"Attack button is pressed.");                       
    }
}

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        //Gets the screen size from the Cocos2D Director. On the iPad, this returns 1024 × 768 pixels.
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        //Informs Cocos2D that the gameplayLayer will receive touch events.
        self.touchEnabled = YES;
        
        srandom(time(NULL)); // Seeds the random number generator
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            //Adds all of the frame dimensions specified in scene1atlas.plist to the Cocos2D Sprite Frame Cache. This will allow any CCSprite to be created by referencing one of the frames/images in the texture atlas. This line is also key in loading up the animations, since they reference spriteFrames loaded by the CCSpriteFrameCache here.
            [[CCSpriteFrameCache sharedSpriteFrameCache]
             addSpriteFramesWithFile:@"scene1atlas.plist"];
            
            //Initializes the CCSpriteBatchNode with the texture atlas image. The image scene1atlas.png becomes the master texture used by all of the CCSprites under the CCSpriteBatchNode. In Space Viking these are all of the GameObjects in the game, from the Viking to the Mallet power-up and the enemies.
            sceneSpriteBatchNode =
            [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"]; 
        }
        else
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache]
             addSpriteFramesWithFile:@"scene1atlasiPhone.plist"];
            sceneSpriteBatchNode =
            [CCSpriteBatchNode
             batchNodeWithFile:@"scene1atlasiPhone.png"];
        }
        
        //Adds the CCSpriteBatchNode to the layer so it and all of its children (the GameObjects) are rendered onscreen.
        [self addChild:sceneSpriteBatchNode z:0];
        
        //Initializes the Joystick DPad and buttons.
        [self initJoystickAndButtons];
        
        //Creates the Viking character using the already cached sprite frame of the Viking standing.
        Viking *viking = [[Viking alloc]
                          initWithSpriteFrameName:@"sv_anim_1.png"];
        
        [viking setJoystick:leftJoystick];
        [viking setJumpButton:jumpButton];
        [viking setAttackButton:attackButton];
        [viking setPosition:ccp(screenSize.width * 0.35f,
                                screenSize.height * 0.14f)];
        [viking setCharacterHealth:100];
        
        //Adds the Viking to the CCSpriteBatchNode. The CCSpriteBatchNode does all of the rendering for the GameObjects. Therefore, the objects have to be added to the CCSpriteBatchNode and not to the layer. It is important to remember that the objects drawn from the texture atlas are added to the CCSpriteBatchNode and only the CCSpriteBatchNode is added to the CCLayer.
        [sceneSpriteBatchNode
         addChild:viking
         z:kVikingSpriteZValue
         tag:kVikingSpriteTagValue];                      
        
        //Adds the RadarDish to the CCSpriteBatchNode. The RadarDish health is set to 100 and the location as 87% of the screen width to the right (900 pixels from the left of the screen on the iPad) and 13% of the screen height (100 pixels from the bottom).
        [self createObjectOfType:kEnemyTypeRadarDish
                      withHealth:100
                      atLocation:ccp(screenSize.width * 0.878f,
                                     screenSize.height * 0.13f)
                      withZValue:10];                            
        
        //Sets up a scheduler call that will fire the update method in GameplayLayer.m on every frame.
        [self scheduleUpdate];
    }
    return self;
}

///////////////////////////Example Animation////////////////////////////////
//Create the animation
//CCAnimation *vikingAnim = [CCAnimation animation];
//
//Load the frames (flip book pages) into the animation
//[vikingAnim addSpriteFrame:
// [[CCSpriteFrameCache sharedSpriteFrameCache]
//  spriteFrameByName:@"sv_anim_2.png"]];
//
//[vikingAnim addSpriteFrame:
// [[CCSpriteFrameCache sharedSpriteFrameCache]
//  spriteFrameByName:@"sv_anim_3.png"]];
//
//[vikingAnim addSpriteFrame:
// [[CCSpriteFrameCache sharedSpriteFrameCache]
//  spriteFrameByName:@"sv_anim_4.png"]];
//
//Set the delay between frames
//[vikingAnim setDelayPerUnit:0.5f];
//
//Create an action that repeats the animation forever
//CCAction *vikingAction = [CCRepeatForever actionWithAction:
// [CCAnimate actionWithAnimation:vikingAnim]];
//
//Run the action
//[vikingSprite runAction:vikingAction];
///////////////////////////////////////////////////////////////////////////

@end