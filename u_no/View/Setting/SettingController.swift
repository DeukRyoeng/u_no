//
//  SettingController.swift
//  u_no
//
//  Created by t2023-m0117 on 8/29/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SettingController: UIViewController {
    
    private let settingView = SettingView()
    private let viewModel = SettingViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 248/255.0, alpha: 1.0)
        setupUI()
        bindTableView()
        bindViewModel()
    }
    
    private func setupUI() {
        view.addSubview(settingView)
        settingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindTableView() {
        viewModel.items
            .bind(to: settingView.settingTable.rx.items(cellIdentifier: "CustomCell", cellType: SettingCell.self)) { row, item, cell in
                cell.selectionStyle = .none
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        settingView.settingTable.rx
            .modelSelected(SettingItem.self)
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        viewModel.selection
            .subscribe(onNext: { item in
                if !item.hasSwitch {
                    print("Selected: \(item.title)")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        viewModel.openURL
            .compactMap { $0 }
            .subscribe(onNext: { url in
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            })
            .disposed(by: disposeBag)
    }
}
