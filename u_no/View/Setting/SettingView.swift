//
//  SettingView.swift
//  u_no
//
//  Created by t2023-m0117 on 8/29/24.
//

import UIKit
import SnapKit

class SettingView: UIView {

    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        return image
    }()
    
    let settingTable: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.register(SettingCell.self, forCellReuseIdentifier: "CustomCell")
        table.separatorColor = .black
        table.separatorInset = .zero
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        customizeCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [logoImage, settingTable].forEach { self.addSubview($0) }
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
        
        settingTable.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(200)
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(225)
        }
    }
    
    private func customizeCells() {
        settingTable.delegate = self
    }
}

extension SettingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? SettingCell {
            customCell.backgroundColor = .white
        }
    }
}
