//
//  SettingCell.swift
//  u_no
//
//  Created by t2023-m0117 on 8/29/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SettingCell: UITableViewCell {
    
    let customLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let ImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .gray
        return imageView
    }()
    
    let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    internal let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [customLabel, ImageView, toggleSwitch].forEach { contentView.addSubview($0) }
        
        customLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        ImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        toggleSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with item: SettingItem) {
        customLabel.text = item.title
        toggleSwitch.isHidden = !item.hasSwitch
        ImageView.isHidden = item.hasSwitch

        // Ensure the switch is off by default
        toggleSwitch.isOn = false

        if item.hasSwitch {
            toggleSwitch.rx.controlEvent(.valueChanged)
                .asObservable()
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    print("알람 설정 변경됨: \(self.toggleSwitch.isOn)")
                })
                .disposed(by: disposeBag)
        }
    }
}
