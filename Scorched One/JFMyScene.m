//
//  JFMyScene.m
//  Scorched One
//
//  Created by Florentine, Justin F. on 6/13/13.
//  Copyright (c) 2013 Florentine, Justin F. All rights reserved.
//

#import "JFMyScene.h"

@implementation JFMyScene

- (SKShapeNode *)createTerrain {
    SKShapeNode *ground = [[SKShapeNode alloc] init];
    
    ground.position = CGPointMake(self.frame.origin.x,self.frame.origin.y);
    
    CGMutablePathRef groundPath = CGPathCreateMutable();
    
    CGPathAddRect(groundPath, NULL, CGRectMake(0.0, 0.0, CGRectGetMaxX(self.frame), 200));
    ground.path = groundPath;
    ground.lineWidth = 0.0;
    ground.fillColor = [SKColor brownColor];
    
    ground.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:groundPath];
    ground.physicsBody.dynamic = FALSE;
    
    return ground;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        SKShapeNode *ground;
        ground = [self createTerrain];
        
        [self addChild:ground];
//        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"mortar"];
        sprite.xScale = 0.1;
        sprite.yScale = 0.1;
        
        sprite.position = location;
        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
        sprite.physicsBody.dynamic = TRUE;
        sprite.physicsBody.mass = 20;
        sprite.physicsBody.affectedByGravity = TRUE;
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
