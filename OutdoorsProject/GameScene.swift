//
//  GameScene.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var cameraNode: SKCameraNode!
    private var backgroundNode: SKSpriteNode!
    private var isZoomedIn = false
    var vehicles: [Vehicle] = []
    
    override func didMove(to view: SKView) {
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        self.addChild(cameraNode)
        
        backgroundNode = SKSpriteNode(imageNamed: "avenue")
        backgroundNode.zPosition = -1
        self.addChild(backgroundNode)
        
        let scaleX = backgroundNode.size.width / view.frame.size.width
        let scaleY = backgroundNode.size.height / view.frame.size.height
        cameraNode.setScale(min(scaleX, scaleY))
        startSpawningCarsOnAllRoutes()
        
        let vehicleSemaphore = Semaphore(type: .vehicle)
        vehicleSemaphore.position = CGPoint(x: 100, y: 100)
        addChild(vehicleSemaphore)
        
        let pedestrianSemaphore = Semaphore(type: .pedestrian)
        pedestrianSemaphore.position = CGPoint(x: 200, y: 100)
        addChild(pedestrianSemaphore)
    }
    
    
    func startSpawningCarsOnAllRoutes() {
        for _ in 1...6 {
            let spawnAction = SKAction.run { [weak self] in
                self?.spawnCar()
            }
            
            let randomWaitDuration = randomTimeInterval(min: 1, max: 5)
            let waitAction = SKAction.wait(forDuration: randomWaitDuration)
            let sequence = SKAction.sequence([spawnAction, waitAction])
            let repeatForever = SKAction.repeatForever(sequence)
            
            run(repeatForever)
        }
    }
    
    func spawnCar() {
        let startPoint = StartPointManager.VehicleStartPoints.randomElement()!
        let car = Vehicle()
        car.position = startPoint
        addChild(car)
        
        let initialSpeed = CGFloat.random(in: 5...15)
        car.speed = initialSpeed
        let direction: CGFloat = startPoint.y < 0 ? 1 : -1
        let maxY = backgroundNode.size.height / 2
        let minY = -backgroundNode.size.height / 2
        car.moveVertically(direction: direction, maxY: maxY, minY: minY, allVehicles: vehicles)
        
        vehicles.append(car)
    }
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        printCoordinates(at: location)
        toggleZoom()
    }
    
    func printCoordinates(at location: CGPoint) {
        print("Clicado em X: \(location.x), Y: \(location.y)")
    }
    
    func toggleZoom() {
        if isZoomedIn {
            let zoomOutAction = SKAction.scale(to: 1, duration: 0.5)
            cameraNode.run(zoomOutAction)
        } else {
            let zoomInAction = SKAction.scale(to: 3, duration: 0.5)
            cameraNode.run(zoomInAction)
        }
        isZoomedIn.toggle()
    }
    
    func randomTimeInterval(min: TimeInterval, max: TimeInterval) -> TimeInterval {
        return TimeInterval.random(in: min...max)
    }
}
