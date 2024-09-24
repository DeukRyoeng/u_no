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
        image.image = UIImage(named: "mainTitle")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let settingTable: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.register(SettingCell.self, forCellReuseIdentifier: "CustomCell")
        table.separatorColor = .black
        table.separatorInset = .zero
        table.layer.cornerRadius = 8
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        customizeCells()
        addTopSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [logoImage, settingTable].forEach { self.addSubview($0) }
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30)
            $0.height.width.equalTo(350)
        }
        
        settingTable.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(240)
        }
    }
    
    private func customizeCells() {
        settingTable.delegate = self
    }
    
    private func addTopSeparator() {
        // 테이블 뷰 맨 위에 검정색 라인 추가
        let topSeparator = UIView()
        topSeparator.backgroundColor = .black
        self.addSubview(topSeparator)
        
        topSeparator.snp.makeConstraints {
            $0.leading.trailing.equalTo(settingTable)
            $0.bottom.equalTo(settingTable.snp.top)  // 테이블 뷰 위쪽에 위치
            $0.height.equalTo(0.5)  // 라인의 두께 설정
        }
    }
}

extension SettingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? SettingCell {
            customCell.backgroundColor = .white
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }
}
