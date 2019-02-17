//
//  ViewController.swift
//  3D-Preview-Demo
//
//  Created by fang on 2019/2/17.
//  Copyright © 2019 fangcha. All rights reserved.
//

import UIKit
import SceneKit

class SceneViewController: UIViewController {

    var modelName: String = ""
    
    @IBOutlet var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        let url = Bundle.main.url(forResource: modelName, withExtension: "usdz")!
        let scene = try! SCNScene(url: url, options: [.checkConsistency: true])
        sceneView.scene = scene
    }
    
    // MARK: - FCViewController
    static func fc_pushToNavigation(_ navigationController: UINavigationController, modelName: String) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sb_SceneViewController") as! SceneViewController
        vc.modelName = modelName
        navigationController.pushViewController(vc, animated: true)
    }
}
