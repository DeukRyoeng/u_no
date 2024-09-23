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
    
    private let network = NetworkManager.shared
    private let itemManager = ItemManager.shared
    
    private let disposeBag = DisposeBag()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = true
        searchBar.tintColor = .lightGray
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.layer.borderColor = UIColor.mainGreen.cgColor
        searchBar.searchTextField.layer.borderWidth = 1.0
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.clipsToBounds = true
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력하세요", attributes: placeholderAttributes)
        return searchBar
    }()
    
    private let searchTableView = UITableView()
    private let filteredData = BehaviorSubject<[Item]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindSearchBar()
        bindViewModel()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [searchBar, searchTableView].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(44)
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("취소", for: .normal)
            cancelButton.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    private func bindSearchBar() {
        // 텍스트 감지
        searchBar.rx.text.orEmpty
            .distinctUntilChanged() // 같은 텍스트 입력은 무시
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // 0.3초 후에 처리
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                print("검색어 입력: \(query)")
                
                if query.isEmpty {
                    self.searchVM.searchData.onNext([])
                    return
                }
                
                if let itemCategory = self.itemManager.getItemCategory(for: query) {
                    if let firstCode = itemCategory.codes.first {
                        let itemcategory = firstCode.itemcategory
                        let itemcode = firstCode.itemcode
                        let kindcode = firstCode.kindcode
                        
                        print("부류코드: \(itemcategory), 품목코드: \(itemcode), 품종코드: \(kindcode)")
                        self.searchVM.fetchSearchData(itemcategory: itemcategory, itemcode: itemcode, kindcode: kindcode)

                    } else {
                        print("해당품목에 코드가 없습니다")
                    }
                } else {
                    print("상품을 찾을 수 없습니다.")
                    self.searchVM.searchData.onNext([])
                }
            })
            .disposed(by: disposeBag)
        // 검색 버튼 클릭 감지
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                guard let searchText = self?.searchBar.text else { return }
                print("검색버튼 클릭: \(searchText)")
                // 검색동작 수행
                self?.searchBar.resignFirstResponder() // 키보드 숨기기
            })
            .disposed(by: disposeBag)
        
        // 취소버튼 클릭 감지
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchBar.text = ""
                self?.searchBar.resignFirstResponder() // 키보드 숨기기
                print("취소 버튼 클릭")
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        searchVM.searchData
            .observe(on: MainScheduler.instance)
            .bind(to: searchTableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { row, item, cell in
                cell.configure(with: item.itemname.asString())
                print(item)
            }
            .disposed(by: disposeBag)
    }

//    private func bindViewModel() {
//        searchVM.searchData
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] items in
//                print("검색결과: \(items)")
//            }).disposed(by: disposeBag)
//    }
    
    /// 부류코드와 품목코드를 조회하는 함수
    private func getItemCodes(for query: String) -> [String: String]? {
        let itemCodes: [String: [String: String]] = [
            "쌀": ["부류코드": "100", "품목코드": "111", "품종코드": "01"],
            "쌀": ["부류코드": "100", "품목코드": "111", "품종코드": "02"],
            "양배추": ["부류코드": "200", "품목코드": "212", "품종코드": "001"],
            "감자": ["부류코드": "300", "품목코드": "321", "품종코드": "002"],
            "고구마": ["부류코드": "300", "품목코드": "322", "품종코드": "003"]
        ]
        return itemCodes[query]
    }

}
