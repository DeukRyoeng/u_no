//
//  PeopleCell.swift
//  u_no
//
//  Created by t2023-m0117 on 9/19/24.
//

import UIKit
import SnapKit

class PeopleCell: UICollectionViewCell {

    private let emojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.subBackground
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        [emojiImageView, nameLabel, roleLabel, introLabel].forEach { addSubview($0) }
        
        backgroundColor = UIColor.subBackground2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 24
        clipsToBounds = true

        emojiImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(80)
            $0.centerY.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(emojiImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

        roleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(emojiImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

        introLabel.snp.makeConstraints {
            $0.top.equalTo(roleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(emojiImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

    // Method to configure the cell with person data
    func configure(emoji: UIImage, name: String, role: String, introduction: String) {
        emojiImageView.image = emoji
        nameLabel.text = name
        roleLabel.text = role
        introLabel.text = introduction
    }
}
