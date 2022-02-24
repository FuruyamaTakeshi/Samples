//
//  ViewController.swift
//  0925_SampleSceneKit
//
//  Created by Furuken on 2021/09/25.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    private var scnView: SCNView?
    private var favParticle: SCNParticleSystem?
    @IBOutlet weak var favButton: UIButton!
    
//    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let scene = SCNScene(named: "fav.scn", inDirectory: "./") else {
            return
        }
        
        guard let node: SCNNode = scene.rootNode.childNode(withName: "particles", recursively: true) else {
            return
        }
        favParticle = node.particleSystems?.first
        favParticle?.particleImage = UIImage(named: "star")

    }
    
    private func addFavParticle() {
        let scene = SCNScene()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)
        
        if let favParticle = favParticle {
            scene.rootNode.addParticleSystem(favParticle)
        }
        
        scnView = SCNView(frame: view.bounds)
        view.insertSubview(scnView!, belowSubview: favButton)
        scnView?.scene = scene
        scnView?.backgroundColor = .clear
    }
    
    @IBAction func didTapFavButton(_ sender: Any) {

    }
    
    @IBAction func didTapButton(_ sender: Any) {
        addFavParticle()

        UIView.animate(withDuration: 2) {
            self.scnView?.alpha = 0
        } completion: { _ in
            self.scnView?.removeFromSuperview()
            self.scnView = nil
        }
    }
    
}

