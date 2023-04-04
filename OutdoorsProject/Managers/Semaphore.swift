//
//  Semaphore.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import SpriteKit

class Semaphore: SKNode {
    private var background: SKSpriteNode!
    private var redLight: SKSpriteNode!
    private var yellowLight: SKSpriteNode!
    private var greenLight: SKSpriteNode!
    private var pRedLight: SKSpriteNode!
    private var pGreenLight: SKSpriteNode!
    
    var isRedLightOn = false
    
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
            background = SKSpriteNode(imageNamed: "semaphoreFrontground")
            background.zPosition = 1
            redLight = SKSpriteNode(imageNamed: "vehicleFSemaphoreRedLight")
            redLight.zPosition = -1
            yellowLight = SKSpriteNode(imageNamed: "vehicleFSemaphoreYellowLight")
            yellowLight.zPosition = -1
            greenLight = SKSpriteNode(imageNamed: "vehicleFSemaphoreGreenLight")
            greenLight.zPosition = -1
            pRedLight = SKSpriteNode(imageNamed: "pedestrianFSemaphoreRedLight")
            pRedLight.zPosition = -1
            pGreenLight = SKSpriteNode(imageNamed: "pedestrianFSemaphoreGreenLight")
            pGreenLight.zPosition = -1
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
        let redOnAction = SKAction.run {
            self.redLight.alpha = 1
            self.isRedLightOn = true
        }
        let redOffAction = SKAction.run {
            self.redLight.alpha = 0
            self.isRedLightOn = false
        }
        
        let yellowInitTime = SKAction.wait(forDuration: 1.0)
        let yellowInit = SKAction.sequence([yellowOnAction, yellowInitTime])
        let yellowBlinkInterval = SKAction.wait(forDuration: 0.5)
        let yellowBlink = SKAction.sequence([yellowOnAction,yellowBlinkInterval,
                                             yellowOffAction,yellowBlinkInterval])
        let yellowBlinkAction = SKAction.repeat(yellowBlink, count: 3)
        let yellowAction = SKAction.sequence([yellowInit,yellowBlinkAction])
        
        let allOff = SKAction.group([greenOffAction,redOffAction,yellowOffAction])
        
        let greenDuration = SKAction.wait(forDuration: 15.0)
        let redDuration = SKAction.wait(forDuration: 15.0)
        
        let vehicleSequence = SKAction.sequence([
            greenOnAction, greenDuration, greenOffAction,
            yellowAction,redOnAction,
            redDuration, redOffAction
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
        let redDuration = SKAction.wait(forDuration: 19.0)
        
        
        let pedestrianSequence = SKAction.sequence([
            redOnAction, redDuration, redOffAction,
            greenOnAction, greenDuration, greenOffAction
        ])
        
        let repeatForever = SKAction.group([allOff,SKAction.repeatForever(pedestrianSequence)])
        run(repeatForever)
    }
}

