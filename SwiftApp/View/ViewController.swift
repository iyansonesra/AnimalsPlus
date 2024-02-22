import SwiftUI
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var dotNodes = [SCNNode]()
       var textNode = SCNNode()
    var animalNode = SCNNode()
       var meterValue: Double?
       var sceneView = ARSCNView()
    var topTextLabel: UILabel = UILabel()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupSceneView()
           setupTopTextLabel()
           scheduleLabelHiding()
       }
       
    func setupSceneView() {
            sceneView = ARSCNView(frame: view.frame)
            sceneView.showsStatistics = false
            sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
            sceneView.autoenablesDefaultLighting = true
            sceneView.delegate = self // Set delegate
            sceneView.isUserInteractionEnabled = true // Enable user interaction
            view.addSubview(sceneView)
            let configuration = ARWorldTrackingConfiguration()
            sceneView.session.run(configuration)
        }
    func scheduleLabelHiding() {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            self?.fadeOutTopTextLabel()
        }
    }

    func fadeOutTopTextLabel() {
        UIView.animate(withDuration: 3.0, animations: { [weak self] in
            self?.topTextLabel.alpha = 0.0
        }) { [weak self] _ in
            // Optionally, you can remove the label from the view hierarchy after the animation completes
            self?.topTextLabel.removeFromSuperview()
        }
    }
    func setupTopTextLabel() {
        topTextLabel.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 40)
            topTextLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            topTextLabel.textAlignment = .center
            topTextLabel.textColor = .black
            let font = UIFont.systemFont(ofSize: 20)
            let boldItalicFont = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic])!, size: font.pointSize)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: boldItalicFont
            ]
            topTextLabel.attributedText = NSAttributedString(string: "Click in any two places to render an animal!", attributes: attributes)
            view.addSubview(topTextLabel)
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("Touches began") // Check if this gets printed
            if dotNodes.count >= 2 {
                for dot in dotNodes {
                    dot.removeFromParentNode()
                }
                dotNodes.removeAll()
            }
            
            if let touch = touches.first, let hitResult = sceneView.hitTest(touch.location(in: sceneView), types: .featurePoint).first {
                addDot(at: hitResult)
            }
        }

        func addDot(at hitResult: ARHitTestResult) {
            let dotGeometry = SCNSphere(radius: 0.005)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.red
            dotGeometry.materials = [material]

            let dotNode = SCNNode(geometry: dotGeometry)
            dotNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
            sceneView.scene.rootNode.addChildNode(dotNode)
            dotNodes.append(dotNode)

            if dotNodes.count >= 2 {
                calculate()
                for dot in dotNodes {
                    dot.removeFromParentNode()
                }
            }
        }
       
     func calculate () {
            let start = dotNodes[0]
            let end = dotNodes[1]
            
            print(start.position)
            print(end.position)
            
            let distance = sqrt(
                pow(end.position.x - start.position.x, 2) +
                pow(end.position.y - start.position.y, 2) +
                pow(end.position.z - start.position.z, 2)
            )
            
            meterValue = Double(abs(distance))
         let heightMeter = Measurement(value: meterValue ?? 0, unit: UnitLength.meters)
         let heightCentimeter = heightMeter.converted(to: UnitLength.inches)
         let heightCent = Int(heightCentimeter.value)
            
            let value = "\(heightCentimeter)"
            let finalMeasurement = String(value.prefix(6))
         addAnimal(height: heightCent, atPosition: start.position)
        }
       
    public func degToRadians(degrees:Double) -> Double
     {
        return degrees * (M_PI / 180);
      }
    func addAnimal(height: Int, atPosition position: SCNVector3) {
        if(height < 2) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "butterfly.usdz") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.0005, y: 0.0005, z: 0.0005)
            animalNode.eulerAngles = SCNVector3Make(0,Float(degToRadians(degrees:180 )),0)
                // Add the deer node to the scene's root node
                sceneView.scene.rootNode.addChildNode(animalNode)
            updateText(text: "Butterfly (1/8\")", atPosition: position, scal: 0.002, zOff: 0.1)
            
        } else if(height >= 2 && height < 20) {
            //falcon
        } else if(height >= 20 && height < 32) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "panda.usdz") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.0045, y: 0.0045, z: 0.0045)
                
                // Add the deer node to the scene's root node
            updateText(text: "Giant Panda (30\")", atPosition: position, scal: 0.01, zOff: 0.5)
                sceneView.scene.rootNode.addChildNode(animalNode)
        } else if(height >= 32 && height < 38) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "wolf.usdz") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
                
                // Add the deer node to the scene's root node
            updateText(text: "Gray Wolf (32\")", atPosition: position, scal: 0.01, zOff: 0.5)
                sceneView.scene.rootNode.addChildNode(animalNode)
        } else if(height >= 38 && height < 45) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "tiger.usdz") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
                
                // Add the deer node to the scene's root node
            updateText(text: "Bengal Tiger (39\")", atPosition: position, scal: 0.01, zOff: 0.5)
                sceneView.scene.rootNode.addChildNode(animalNode)
        } else if(height >= 45 && height < 52) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "penguin.usdz") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
                
                // Add the deer node to the scene's root node
            updateText(text: "Emperor Penguin (50\")", atPosition: position, scal: 0.01, zOff: 0.6)
                sceneView.scene.rootNode.addChildNode(animalNode)
        } else if(height >= 52 && height < 65) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "kangaroo.usdz") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
                
                // Add the deer node to the scene's root node
            updateText(text: "Kangaroo (59\")", atPosition: position, scal: 0.01, zOff: 0.6)
                sceneView.scene.rootNode.addChildNode(animalNode)
        } else if(height >= 65 && height < 100) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "ostrich.scn") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.052, y: 0.052, z: 0.052  )
                
                // Add the deer node to the scene's root node
            updateText(text: "Ostrich (96\")", atPosition: position, scal: 0.01, zOff: 0.6)
                sceneView.scene.rootNode.addChildNode(animalNode)
        } else if(height >= 100) {
            animalNode.removeFromParentNode()
            guard let animalScene = SCNScene(named: "elephant.usdz") else {
                fatalError("no deer")
            }
           
             animalNode = animalScene.rootNode.clone()
            
            animalNode.position = position
            animalNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
            updateText(text: "Elephant (120\")", atPosition: position, scal: 0.01, zOff: 0.6)
                // Add the deer node to the scene's root node
                sceneView.scene.rootNode.addChildNode(animalNode)
        }
        
     
    
    }
    func updateText(text: String, atPosition position: SCNVector3, scal: Float, zOff: Float) {
            textNode.removeFromParentNode()
            let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.red
            textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(x: position.x, y: position.y + 0.05, z: position.z + zOff)
            textNode.scale = SCNVector3(x: scal, y: scal, z: scal)
            sceneView.scene.rootNode.addChildNode(textNode)
            
        }
    
   
}
                                                                 
