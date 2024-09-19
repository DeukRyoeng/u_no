//
//  searchTableViewCell.swift
//  u_no
//
//  Created by 유민우 on 9/12/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    static let id = "SearchTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(200)
        }
    }
    
    func configure(with itemname: String) {
        label.text = itemname
    }
    
}
