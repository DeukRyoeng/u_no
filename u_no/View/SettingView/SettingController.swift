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
        view.backgroundColor = .white
        setupUI()
        bindTableView()
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
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                if !item.hasSwitch {
                    print("Selected: \(item.title)")
                }
            })
            .disposed(by: disposeBag)
    }
}
