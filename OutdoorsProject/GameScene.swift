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
    var stopZones: [StopZone] = []
    
    override func didMove(to view: SKView) {
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        self.addChild(cameraNode)
        setBackground()
        let scaleX = backgroundNode.size.width / view.frame.size.width
        let scaleY = backgroundNode.size.height / view.frame.size.height
        cameraNode.setScale(min(scaleX, scaleY))
        startSpawningCarsOnAllRoutes()
        setSemaphores()
        setStopZone()
    }
    
    func setStopZone() {
        let stopZoneSize = CGSize(width: 284.52, height: 20)
        let stopZone1 = StopZone(size: stopZoneSize)
        stopZone1.position = CGPoint(x: 185, y: -180)
        stopZone1.zPosition = 0
        
        let stopZone2 = StopZone(size: stopZoneSize)
        stopZone2.position = CGPoint(x: -166, y: 180)
        stopZone2.zPosition = 0
        
        addChild(stopZone1)
        addChild(stopZone2)
        stopZones.append(stopZone1)
        stopZones.append(stopZone2)
    }
    
    func setBackground() {
        backgroundNode = SKSpriteNode(imageNamed: "avenue")
        backgroundNode.zPosition = -1
        self.addChild(backgroundNode)
    }
    
    func setSemaphores() {
        let vehicleSemaphore1 = Semaphore(type: .front)
        vehicleSemaphore1.position = CGPoint(x: 310, y: 256)
        vehicleSemaphore1.zPosition = 1
        addChild(vehicleSemaphore1)
        
        let vehicleSemaphore2 = Semaphore(type: .back)
        vehicleSemaphore2.position = CGPoint(x: -275, y: -300)
        vehicleSemaphore2.zPosition = 2
        addChild(vehicleSemaphore2)
    }
    
    func startSpawningCarsOnAllRoutes() {
        for _ in 1...6 {
            let spawnAction = SKAction.run { [weak self] in
                self?.spawnCar()
            }
            
            let randomWaitDuration = randomTimeInterval(min: 3, max: 5)
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
        car.zPosition = 0
        addChild(car)
        
        let constantSpeed = CGFloat(6) // Defina a velocidade constante aqui
        car.speed = constantSpeed
        let direction: CGFloat = startPoint.y < 0 ? 1 : -1
        let maxY = backgroundNode.size.height / 2
        let minY = -backgroundNode.size.height / 2
        car.moveVertically(direction: direction, maxY: maxY, minY: minY, allVehicles: vehicles, scene: self)
        
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
