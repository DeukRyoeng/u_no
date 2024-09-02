//
//  MainCollectionViewCell.swift
//  u_no
//
//  Created by 유민우 on 8/30/24.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let id = "MainCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .green
    }
    
}
