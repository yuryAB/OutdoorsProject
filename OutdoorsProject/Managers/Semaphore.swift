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
    
    enum SemaphoreType {
        case vehicle, pedestrian
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
        case .vehicle:
            background = SKSpriteNode(imageNamed: "vehicleSemaphoreBackground")
            redLight = SKSpriteNode(imageNamed: "vehicleSemaphoreRedLight")
            yellowLight = SKSpriteNode(imageNamed: "vehicleSemaphoreYellowLight")
            greenLight = SKSpriteNode(imageNamed: "vehicleSemaphoreGreenLight")
        case .pedestrian:
            background = SKSpriteNode(imageNamed: "pedestrianSemaphoreBackground")
            redLight = SKSpriteNode(imageNamed: "pedestrianSemaphoreRedLight")
            greenLight = SKSpriteNode(imageNamed: "pedestrianSemaphoreGreenLight")
        }
        
        if inverted {
                   background.yScale = -1
               }
        
        addChild(background)
        background.addChild(redLight)
        background.addChild(greenLight)
        
        if semaphoreType == .vehicle {
            background.addChild(yellowLight)
        }
        
        // Ajuste a posição das luzes conforme necessário
    }
    
    private func createLight(color: SKColor) -> SKSpriteNode {
        let light = SKSpriteNode(color: color, size: CGSize(width: 20, height: 20))
        light.zPosition = 1
        return light
    }
    
    private func startSemaphoreAnimation() {
        if semaphoreType == .vehicle {
            vehicleSemaphoreAnimation()
        } else {
            pedestrianSemaphoreAnimation()
        }
    }
    
    private func vehicleSemaphoreAnimation() {
        let greenOnAction = SKAction.run { self.greenLight.alpha = 0 }
        let greenOffAction = SKAction.run { self.greenLight.alpha = 1 }
        let yellowOnAction = SKAction.run { self.yellowLight.alpha = 0 }
        let yellowOffAction = SKAction.run { self.yellowLight.alpha = 1 }
        let redOnAction = SKAction.run { self.redLight.alpha = 0 }
        let redOffAction = SKAction.run { self.redLight.alpha = 1 }
        
        let greenDuration = SKAction.wait(forDuration: 15.0)
        let yellowDuration = SKAction.wait(forDuration: 3.0)
        let redDuration = SKAction.wait(forDuration: 15.0)
        
        let vehicleSequence = SKAction.sequence([
            greenOnAction, greenDuration, greenOffAction,
            yellowOnAction, yellowDuration, yellowOffAction,
            redOnAction, redDuration, redOffAction
        ])
        
        let repeatForever = SKAction.repeatForever(vehicleSequence)
        run(repeatForever)
    }
    
    private func pedestrianSemaphoreAnimation() {
        let greenOnAction = SKAction.run { self.greenLight.alpha = 0 }
        let greenOffAction = SKAction.run { self.greenLight.alpha = 1 }
        let redOnAction = SKAction.run { self.redLight.alpha = 0 }
        let redOffAction = SKAction.run { self.redLight.alpha = 1 }
        
        let greenDuration = SKAction.wait(forDuration: 15.0)
        let redDuration = SKAction.wait(forDuration: 18.0)
        
        let pedestrianSequence = SKAction.sequence([
            redOnAction, redDuration, redOffAction,
            greenOnAction, greenDuration, greenOffAction
        ])
        
        let repeatForever = SKAction.repeatForever(pedestrianSequence)
        run(repeatForever)
    }
}

