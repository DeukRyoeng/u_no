//
//  MainSectionHeaderView.swift
//  u_no
//
//  Created by 유민우 on 8/30/24.
//

import UIKit
import SnapKit

class MainSectionHeaderView: UICollectionReusableView {
    
    static let id = "MainSectionHeaderView"
    
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = UIColor.mainBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(sectionTitle)
        sectionTitle.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(with title: String, isFavoriteHeader: Bool = false) {
        sectionTitle.text = title
        sectionTitle.font = isFavoriteHeader ? .boldSystemFont(ofSize: 30) : .boldSystemFont(ofSize: 35) 
    }
}
