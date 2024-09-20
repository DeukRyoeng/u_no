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
        view.backgroundColor = UIColor.mainBackground
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
        
        viewModel.actionTrigger
            .subscribe(onNext: { [weak self] action in
                guard let self = self else { return }
                
                switch action {
                case .accountDeletion:
                    self.presentConfirmationModal(
                        title: "계정탈퇴",
                        description: "정말로 계정을 탈퇴하시겠습니까?",
                        sub: "(알고싶어 서비스를 더이상 이용하지 못합니다.)",
                        actionButtonText: "계정탈퇴",
                        actionHandler: {
                            print("Account deleted")
                        }
                    )
                    
                case .logout:
                    self.presentConfirmationModal(
                        title: "로그아웃",
                        description: "정말로 로그아웃 하시겠습니까?",
                        sub: "(로그인화면으로 이동합니다.)",
                        actionButtonText: "로그아웃",
                        actionHandler: {
                            self.viewModel.startKakaoSignOut()
                            print("Logged out")
                        }
                    )
                    
                case .showPeopleController:
                    self.showPeopleController()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func showPeopleController() {
        let peopleVC = PeopleController()
        
        let backButton = UIBarButtonItem()
        backButton.title = "설정"
        self.navigationItem.backBarButtonItem = backButton
        
        peopleVC.hidesBottomBarWhenPushed = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(peopleVC, animated: true)
    }



    private func presentConfirmationModal(title: String, description: String, sub:String, actionButtonText: String, actionHandler: @escaping () -> Void) {
        let confirmationVC = ConfirmationViewController(
            title: title,
            description: description,
            sub: sub,
            actionButtonText: actionButtonText,
            actionHandler: actionHandler
        )
        
        confirmationVC.modalPresentationStyle = .pageSheet
        if let sheet = confirmationVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in return 300 })]
        }
        present(confirmationVC, animated: true, completion: nil)
    }
}
