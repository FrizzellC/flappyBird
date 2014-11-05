//
//  GameScene.swift
//  FloppyFish
//
//  Created by chantel Frizzell on 10/23/14.
//  Copyright (c) 2014 myApps. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
    var skyColor = SKColor()
    var verticalPipeGap = 130.0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        
        skyColor = SKColor(red: 113.0/225.0, green: 197.0/225.0, blue: 207.0/225.0, alpha: 1.0)
        self.backgroundColor = skyColor
    
        //bird
        var birdTexture1 = SKTexture(imageNamed: "bird1")
        birdTexture1.filteringMode = SKTextureFilteringMode.Nearest
        var birdTexture2 = SKTexture(imageNamed: "bird2")
        birdTexture1.filteringMode = SKTextureFilteringMode.Nearest
        
        /* animate the bird*/
        var animation = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.2)
        var flap = SKAction.repeatActionForever(animation)
        
        /* set the bird's position relative to the frame: */
        bird = SKSpriteNode(texture:birdTexture1)
        bird.setScale(0.5)
        bird.position = CGPoint(x: self.frame.size.width * 0.35, y: self.frame.size.height * 0.6)
        bird.runAction(flap)
        
        /* add bird's physics */
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2.0)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = false
        
        /* add bird to the scene: */
        self.addChild(bird)
        
        //ground
        var groundTexture = SKTexture(imageNamed: "ground")
        groundTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        /*move the ground*/
        var moveGroundSprite = SKAction.moveByX(-groundTexture.size().width, y: 0 , duration: NSTimeInterval(0.01 * groundTexture.size().width))
        var resetGroundSprite = SKAction.moveByX(groundTexture.size().width, y: 0, duration: 0.0)
        var moveGroundSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite,resetGroundSprite]))
        
        for var i:CGFloat = 0; i<2 + self.frame.size.width / (groundTexture.size().width); ++i {
            var sprite = SKSpriteNode(texture: groundTexture)
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2)
            sprite.runAction(moveGroundSpritesForever)
            self.addChild(sprite)
            
            var dummyGround = SKNode()
            dummyGround.position = CGPointMake(0, groundTexture.size().height / 2)
            dummyGround.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height))
            dummyGround.physicsBody?.dynamic = false
            self.addChild(dummyGround)
            
            }
        
        //sky
       var skyLineTexture = SKTexture(imageNamed: "sky")
        skyLineTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        /* move the skyline */
       var moveSkylineSprite = SKAction.moveByX(-skyLineTexture.size().width, y: 0 , duration: NSTimeInterval(0.1 * skyLineTexture.size().width))
        var resetSkylineSprite = SKAction.moveByX(skyLineTexture.size().width, y: 0, duration: 0.0)
        var moveSkylineSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveSkylineSprite, resetSkylineSprite]))
        
        
        for var i:CGFloat = 0; i<2 + self.frame.size.width / (skyLineTexture.size().width); ++i {
            var sprite = SKSpriteNode(texture: skyLineTexture)
            sprite.zPosition = -20;
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2 + groundTexture.size().height)
            sprite.runAction(moveGroundSpritesForever)
            self.addChild(sprite)
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
          let location = touch.locationInNode(self)
            
          bird.physicsBody?.velocity = CGVectorMake(0, 0)
          bird.physicsBody?.applyImpulse(CGVectorMake(0, 25))
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {}
        /* Called before each frame is rendered */
        
}