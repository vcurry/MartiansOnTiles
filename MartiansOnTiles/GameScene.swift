//
//  GameScene.swift
//  MartiansOnTiles
//
//  Created by Verónica Cordobés on 17/1/17.
//  Copyright © 2017 Verónica Cordobés. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var background: SKTileMapNode!
    var player = Player()
    var martian = Martian()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        background = childNode(withName: "landBackground") as! SKTileMapNode
    }
    
    override func didMove(to view: SKView) {
        addChild(player)
        addChild(martian)
        setUpCamera()
        setUpWorldPhysics()
    }
    
    //we take the touch location and send it to Player's move(target:)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        player.move(target: touch.location(in: self))
    }
    
    //adds the camer taht will follow the player
    func setUpCamera(){
        guard let camera = camera else {
            return
        }
        
        //we want to keep 0 distance to the player
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
        
        //we exclude the gray area around our tile map from the camara focus
        let xInset = min((view?.bounds.width)!/2 * camera.xScale, background.frame.width/2)
        let yInset = min((view?.bounds.height)!/2 * camera.yScale, background.frame.height/2)
        let constraintRect = background.frame.insetBy(dx: xInset, dy: yInset)
        let xRange = SKRange(lowerLimit: constraintRect.minX,
                             upperLimit: constraintRect.maxY)
        let yRange = SKRange(lowerLimit: constraintRect.minY,
                             upperLimit: constraintRect.maxX)
        let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        edgeConstraint.referenceNode = background
        
        camera.constraints = [playerConstraint, edgeConstraint]
    }
    
    //sets boundaries, so that the player always stays within the scene bpunds
    func setUpWorldPhysics(){
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: background.frame)
    }
    

}
