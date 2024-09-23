//
//  SearchViewController.swift
//  u_no
//
//  Created by 유민우 on 9/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController {
    
    let searchVM = SearchViewModel()
    private let searchView = SearchView()
    private let network = NetworkManager.shared
    private let itemManager = ItemManager.shared
    private let disposeBag = DisposeBag()
    private var datas = [Price]()
    private let common = Common()
    
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchData()
        bindSearchBar()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let cancelButton = searchView.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("취소", for: .normal)
            cancelButton.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    private func searchData(){
        searchVM.fetchAllData()
    }
    
    private func bindSearchBar() {
        // 검색어 입력을 ViewModel의 searchQuery에 바인딩
        searchView.searchBar.rx.text.orEmpty
            .bind(to: searchVM.searchQuery)
            .disposed(by: disposeBag)
        
        // 검색 버튼 클릭 시 키보드 숨기기
        searchView.searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchView.searchBar.resignFirstResponder()
                print("검색 버튼 클릭")
            })
            .disposed(by: disposeBag)
        
        // 취소 버튼 클릭 시 검색어 초기화 및 키보드 숨기기
        searchView.searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchView.searchBar.text = ""
                self?.searchView.searchBar.resignFirstResponder()
                self?.searchVM.searchQuery.onNext("")
                print("취소 버튼 클릭")
            })
            .disposed(by: disposeBag)
    }
    
    // ViewModel의 filteredPrices를 테이블 뷰에 바인딩
    private func bindViewModel() {
        searchVM.filteredPrices
            .observe(on: MainScheduler.instance)
            .bind(to: searchView.searchTableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { row, price, cell in
                guard let itemName = price.itemName , let unit = price.unit else { return }
                let name = "\(itemName)  \(unit)"
                cell.configure(with: name)
            }
            .disposed(by: disposeBag)
        
        // 테이블 뷰 셀 선택 시 동작
        searchView.searchTableView.rx.modelSelected(Price.self)
            .subscribe(onNext: { [weak self] price in
                let graphViewController = GraphViewController()
                graphViewController.nameData = [price]
                self?.present(graphViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        
    }
    
}

