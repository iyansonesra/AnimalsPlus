import SwiftUI
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var dotNodes = [SCNNode]()
       var textNode = SCNNode()
    var animalNode = SCNNode()
       var meterValue: Double?
       var sceneView = ARSCNView()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupSceneView()
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
         let heightCentimeter = heightMeter.converted(to: UnitLength.centimeters)
         let heightCent = Int(heightCentimeter.value)
            
            let value = "\(heightCentimeter)"
            let finalMeasurement = String(value.prefix(6))
         addAnimal(height: heightCent, atPosition: start.position)
            updateText(text: finalMeasurement, atPosition: end.position)
       
            
        }
       
     
    func addAnimal(height: Int, atPosition position: SCNVector3) {
        
        animalNode.removeFromParentNode()
        guard let animalScene = SCNScene(named: "deer.usdz") else {
            fatalError("no deer")
        }
       
         animalNode = animalScene.rootNode.clone()
        
        animalNode.position = position
        animalNode.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
            
            // Add the deer node to the scene's root node
            sceneView.scene.rootNode.addChildNode(animalNode)
     
    
    }
     func updateText(text: String, atPosition position: SCNVector3) {
            textNode.removeFromParentNode()
            let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.red
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(x: position.x, y: position.y + 0.01, z: position.z)
            textNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
            sceneView.scene.rootNode.addChildNode(textNode)
            
        }
    
   
}
                                                                 
