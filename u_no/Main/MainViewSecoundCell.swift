//
//  MainViewSecoundCell.swift
//  u_no
//
//  Created by 유민우 on 9/3/24.
//

import UIKit
import SnapKit

class MainViewSecoundCell: UICollectionViewCell {
    
    static let id = "MainViewSecoundCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .right
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        [nameLabel, quantityLabel, priceLabel].forEach { contentView.addSubview($0) }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.width.equalTo(120)
            $0.height.equalTo(50)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.trailing.equalToSuperview().offset(-5)

        }
        
        priceLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.leading.equalToSuperview().offset(5)

        }
    }
    
    func configure(with price: Price) {
        nameLabel.text = price.productName ?? "Unknown Product"
        priceLabel.text = "\(price.dpr1.asString())원"

        let fluctuationString = price.value.asString()
        let fluctuation = Double(fluctuationString) ?? 0.0
        quantityLabel.text = "\(fluctuation)%"
        
        let directionValue = price.direction.asString()
        switch directionValue {
        case "0":
            quantityLabel.textColor = .mainBlue
            priceLabel.textColor = .mainBlue
        case "1":
            quantityLabel.textColor = .mainRed
            priceLabel.textColor = .mainRed
        case "2":
            quantityLabel.textColor = .black
            priceLabel.textColor = .black
        default:
            quantityLabel.textColor = .black
            priceLabel.textColor = .black
        }
    }


}

