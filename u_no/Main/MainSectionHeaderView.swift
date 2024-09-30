//
//  MainSectionHeaderView.swift
//  u_no
//
//  Created by 유민우 on 8/30/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainSectionHeaderView: UICollectionReusableView {
    
    static let id = "MainSectionHeaderView"
    
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 34)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시세보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(sectionTitle)
        addSubview(priceButton)

        sectionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }

        priceButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with title: String, isFavoriteHeader: Bool = false) {
        sectionTitle.text = title
        priceButton.isHidden = !isFavoriteHeader
    }
}
