//
//  ModelListViewController.swift
//  3D-Preview-Demo
//
//  Created by fang on 2019/2/17.
//  Copyright © 2019 fangcha. All rights reserved.
//

import UIKit
import Foundation
import QuickLook

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = Bundle.main.url(forResource: models[indexSelected], withExtension: "usdz")!
        return url as QLPreviewItem
    }
    
    @IBOutlet var collectionView: UICollectionView!
    let models = ["wheelbarrow", "wateringcan", "teapot", "gramophone", "cupandsaucer", "redchair", "tulip", "plantpot"]
    
    var thumbnails = [UIImage]()
    var indexSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for model in models {
            if let thumbnail = UIImage(named: model) {
                thumbnails.append(thumbnail)
            }
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModelCell", for: indexPath) as! ModelCell
        
        cell.modelThumbnail.image = thumbnails[indexPath.item]
        let title = models[indexPath.item]
        cell.modelTitle.text = title.capitalized
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.item
        let modelName = models[indexSelected]
        
        let actionSheet = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "QuickLook", style: .default, handler: {
            action in
            let previewController = QLPreviewController()
            previewController.dataSource = self
            previewController.delegate = self
            self.present(previewController, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "SceneKit", style: .default, handler: {
            action in
            SceneViewController.fc_pushToNavigation(self.navigationController!, modelName: modelName)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

