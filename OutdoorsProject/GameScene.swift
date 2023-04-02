//
//  GameScene.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // 1. Adicione o objeto da câmera
    private var cameraNode: SKCameraNode!
    
    // 2. Adicione o objeto do background
    private var backgroundNode: SKSpriteNode!
    
    // 3. Crie uma variável de controle para armazenar o estado atual do zoom
    private var isZoomedIn = false
    
    override func didMove(to view: SKView) {
        // Inicialize e configure a câmera
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        self.addChild(cameraNode)
        
        // Inicialize e configure o background
        backgroundNode = SKSpriteNode(imageNamed: "avenue")
        backgroundNode.zPosition = -1
        self.addChild(backgroundNode)
        
        // Ajuste a escala da câmera para corresponder às dimensões do background
        let scaleX = backgroundNode.size.width / view.frame.size.width
        let scaleY = backgroundNode.size.height / view.frame.size.height
        cameraNode.setScale(min(scaleX, scaleY))
        
        setRoutes()
        
        for (index, _) in RoutePathManager.allPaths.enumerated() {
            let routeName = "path\(index + 1)"
            let spawnAction = SKAction.run { [weak self] in
                self?.spawnCarOnRoute(routeName: routeName, duration: 5)
            }
            let waitAction = SKAction.wait(forDuration: 2)
            let sequence = SKAction.sequence([spawnAction, waitAction])
            let repeatForever = SKAction.repeatForever(sequence)
            run(repeatForever, withKey: "spawnCarsOn\(routeName)")
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        printCoordinates(at: location)
        toggleZoom()
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }
    
    override func keyDown(with event: NSEvent) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
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
    
    func drawRoute(path: CGPath) -> SKShapeNode {
        let route = SKShapeNode(path: path)
        route.strokeColor = .red
        route.lineWidth = 5
        
        return route
    }
    
    func printCoordinates(at location: CGPoint) {
        print("Clicado em X: \(location.x), Y: \(location.y)")
    }
    
    func setRoutes() {
        for (index, path) in RoutePathManager.allPaths.enumerated() {
            let routeName = "path\(index + 1)"
            let route = createRoute(points: path, routeName: routeName)
            addChild(route)
        }
    }
    
    func createRoute(points: [CGPoint], routeName: String) -> SKShapeNode {
        let path = CGMutablePath()
        path.move(to: points[0])
        
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        
        let route = SKShapeNode(path: path)
        route.strokeColor = .orange
        route.lineWidth = 5
        route.name = routeName
        return route
    }
    
    func spawnCarOnRoute(routeName: String, duration: TimeInterval) {
        guard let route = childNode(withName: routeName) as? SKShapeNode, let path = route.path else { return }
        
        let car = SKSpriteNode(color: .blue, size: CGSize(width: 20, height: 20))
        car.position = path.currentPoint
        addChild(car)
        
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: true, duration: duration)
        let removeCar = SKAction.removeFromParent()
        let sequence = SKAction.sequence([followPath, removeCar])
        car.run(sequence)
    }
}
