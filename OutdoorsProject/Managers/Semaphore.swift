//
//  Semaphore.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import SpriteKit

enum SemaphoreType {
    case vehicle
    case pedestrian
}

class Semaphore: SKNode {
    private var background: SKSpriteNode!
    private var redLight: SKSpriteNode!
    private var yellowLight: SKSpriteNode!
    private var greenLight: SKSpriteNode!
    private var pRedLight: SKSpriteNode!
    private var pGreenLight: SKSpriteNode!
    
    enum SemaphoreType {
        case front, back
    }
    
    let semaphoreType: SemaphoreType
    let inverted: Bool
    
    init(type: SemaphoreType, inverted: Bool = false) {
        self.semaphoreType = type
        self.inverted = inverted
        super.init()
        
        setupSemaphore()
        startSemaphoreAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSemaphore() {
        switch semaphoreType {
        case .front:
            background = SKSpriteNode(imageNamed: "semaphoreBackground")
            background.zPosition = 0
            redLight = SKSpriteNode(imageNamed: "vehicleSemaphoreRedLight")
            redLight.zPosition = 1
            yellowLight = SKSpriteNode(imageNamed: "vehicleSemaphoreYellowLight")
            yellowLight.zPosition = 1
            greenLight = SKSpriteNode(imageNamed: "vehicleSemaphoreGreenLight")
            greenLight.zPosition = 1
            pRedLight = SKSpriteNode(imageNamed: "pedestrianSemaphoreRedLight")
            pRedLight.zPosition = 1
            pGreenLight = SKSpriteNode(imageNamed: "pedestrianSemaphoreGreenLight")
            pGreenLight.zPosition = 1
        case .back:
            background = SKSpriteNode(imageNamed: "semaphoreBackground")
            background.zPosition = 1
            redLight = SKSpriteNode(imageNamed: "vehicleSemaphoreRedLight")
            redLight.zPosition = 0
            yellowLight = SKSpriteNode(imageNamed: "vehicleSemaphoreYellowLight")
            yellowLight.zPosition = 0
            greenLight = SKSpriteNode(imageNamed: "vehicleSemaphoreGreenLight")
            greenLight.zPosition = 0
            pRedLight = SKSpriteNode(imageNamed: "pedestrianSemaphoreRedLight")
            pRedLight.zPosition = 0
            pGreenLight = SKSpriteNode(imageNamed: "pedestrianSemaphoreGreenLight")
            pGreenLight.zPosition = 0
        }
        
        
        addChild(background)
        background.addChild(redLight)
        background.addChild(greenLight)
        background.addChild(yellowLight)
        background.addChild(pRedLight)
        background.addChild(pGreenLight)
    }
    
    private func startSemaphoreAnimation() {
        vehicleSemaphoreAnimation()
        pedestrianSemaphoreAnimation()
    }
    
    private func vehicleSemaphoreAnimation() {
        let greenOnAction = SKAction.run { self.greenLight.alpha = 1 }
        let greenOffAction = SKAction.run { self.greenLight.alpha = 0 }
        let yellowOnAction = SKAction.run { self.yellowLight.alpha = 1 }
        let yellowOffAction = SKAction.run { self.yellowLight.alpha = 0 }
        let redOnAction = SKAction.run { self.redLight.alpha = 1 }
        let redOffAction = SKAction.run { self.redLight.alpha = 0 }
        
        let allOff = SKAction.group([greenOffAction,redOffAction,yellowOffAction])
        
        let greenDuration = SKAction.wait(forDuration: 15.0)
        let yellowDuration = SKAction.wait(forDuration: 3.0)
        let redDuration = SKAction.wait(forDuration: 15.0)
        
        let vehicleSequence = SKAction.sequence([
            greenOnAction, greenDuration, greenOffAction,
            yellowOnAction, yellowDuration, yellowOffAction,
            redOnAction, redDuration, redOffAction
        ])
        
        let repeatForever = SKAction.group([allOff,SKAction.repeatForever(vehicleSequence)])
        run(repeatForever)
    }
    
    private func pedestrianSemaphoreAnimation() {
        let greenOnAction = SKAction.run { self.pGreenLight.alpha = 1 }
        let greenOffAction = SKAction.run { self.pGreenLight.alpha = 0 }
        let redOnAction = SKAction.run { self.pRedLight.alpha = 1 }
        let redOffAction = SKAction.run { self.pRedLight.alpha = 0 }
        
        let allOff = SKAction.group([greenOffAction,redOffAction])
        
        let greenDuration = SKAction.wait(forDuration: 15.0)
        let redDuration = SKAction.wait(forDuration: 18.0)
        
        
        let pedestrianSequence = SKAction.sequence([
            redOnAction, redDuration, redOffAction,
            greenOnAction, greenDuration, greenOffAction
        ])
        
        let repeatForever = SKAction.group([allOff,SKAction.repeatForever(pedestrianSequence)])
        run(repeatForever)
    }
}

