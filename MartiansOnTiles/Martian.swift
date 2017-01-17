//
//  Martian.swift
//  MartiansOnTiles
//
//  Created by Verónica Cordobés on 17/1/17.
//  Copyright © 2017 Verónica Cordobés. All rights reserved.
//

import Foundation

import SpriteKit



class Martian: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "mapTile_136");
        super.init(texture: texture, color: .white, size: CGSize(width:40, height: 55))
        name = "Martian"
        zPosition = 50
        position = CGPoint(x: 60, y: 0)
        
        //Comprobar si size.width/2 = 40/2
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 0.5
        physicsBody?.linearDamping = 0.5
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    //moves the martian randomly
    func move(target: CGPoint){
        guard physicsBody != nil else{
            return
        }
        
        let newVelocity = (target - position).normalized() * PlayerSettings.playerSpeed
        physicsBody?.velocity = CGVector(point: newVelocity)
    }
}
