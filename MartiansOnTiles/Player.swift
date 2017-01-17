//
//  Player.swift
//  MartiansOnTiles
//
//  Created by Verónica Cordobés on 17/1/17.
//  Copyright © 2017 Verónica Cordobés. All rights reserved.
//

import Foundation
import SpriteKit

enum PlayerSettings {
    static let playerSpeed: CGFloat = 280.0
}

class Player: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "female_stand");
        super.init(texture: texture, color: .white, size: CGSize(width:40, height: 55))
        name = "Player"
        zPosition = 50
        
        //Comprobar si size.width/2 = 40/2
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 1.0
        physicsBody?.linearDamping = 0.5
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    //moves the player to the target. Direction = desired new location - current position
    func move(target: CGPoint){
        guard physicsBody != nil else{
            return
        }
        
        let newVelocity = (target - position).normalized() * PlayerSettings.playerSpeed
        physicsBody?.velocity = CGVector(point: newVelocity)
        createAnimations()
    }
    
    //creates the walking animation for the player
    func createAnimations(){
       self.run(
        SKAction.repeatForever(
        SKAction.animate(with: [SKTexture(imageNamed: "female_walk1"),
                                SKTexture(imageNamed: "female_walk2")],
                        timePerFrame: 0.2)))
    }
    
}
