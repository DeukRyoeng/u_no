//
//  MainViewController.swift
//  u_no
//
//  Created by 이득령 on 8/29/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    lazy var collcetinoView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        collectionView.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
