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
    
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(sectionTitle)
        sectionTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func configure(with text: String) {
        sectionTitle.text = text
    }
    
}
