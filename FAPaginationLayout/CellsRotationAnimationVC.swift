//
//  CellsRotationAnimationVC.swift
//  FAPaginationLayout
//
//  Created by Fahid Attique on 14/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class CellsRotationAnimationVC: UIViewController {
    
    
    
    //  IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    //  Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewConfigrations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //  Private Functions
    
    
    private func viewConfigrations() {
        
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.contentInset = UIEdgeInsetsMake(0, 30, 0, 30)
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCellsLayout()
    }
    
    func updateCellsLayout()  {
        
        let centerX = collectionView.contentOffset.x + (collectionView.frame.size.width)/2
        for cell in collectionView.visibleCells {
            
            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }
            
            if offsetX > 0 {
                
                let offsetPercentage = offsetX / view.bounds.width
                let rotation = 1 - offsetPercentage
                cell.transform = CGAffineTransform(rotationAngle: rotation - 45)
            }
        }
    }
    
}






//  Collection View FlowLayout Delegate & Data Source


extension CellsRotationAnimationVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.wallpaperImageView.image = UIImage(named: "\(indexPath.item)")
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize = collectionView.bounds.size
        
        cellSize.width -= collectionView.contentInset.left * 2
        cellSize.width -= collectionView.contentInset.right * 2
        cellSize.height = cellSize.width
        
        return cellSize
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCellsLayout()
    }
}
