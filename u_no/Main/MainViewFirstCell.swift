//
//  Top3Cell.swift
//  u_no
//
//  Created by 유민우 on 9/3/24.
//

import UIKit
import SnapKit

class MainViewFirstCell: UICollectionViewCell {
    
    static let id = "MainViewFirstCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 27)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .right
        label.textColor = UIColor(red: 75/255.0, green: 166/255.0, blue: 251/255.0, alpha: 1.0)
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = UIColor(red: 75/255.0, green: 166/255.0, blue: 251/255.0, alpha: 1.0)
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        [nameLabel, priceLabel, discountLabel].forEach { contentView.addSubview($0) }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(200)
            $0.height.equalTo(70)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-5)
            $0.width.equalTo(120)
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(with price: Price, isRising: Bool) {
        nameLabel.text = price.itemName
        priceLabel.text = "\(price.dpr1.asString())원"
        discountLabel.text = "\(price.value.asString())%"
        
        // Set colors based on price fluctuation
        if isRising {
            priceLabel.textColor = UIColor.mainRed
            discountLabel.textColor = UIColor.mainRed
        } else {
            priceLabel.textColor = UIColor.mainBlue
            discountLabel.textColor = UIColor.mainBlue
        }
    }
}
