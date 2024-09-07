//
//  MainViewController.swift
//  u_no
//
//  Created by 이득령 on 8/29/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let mainVM = MainViewModel()
    // 임시 즐겨찾기 모델
    private let favoritesVM = FavoritesViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                // 첫번째 섹션
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(330))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item, item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.orthogonalScrollingBehavior = .none
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            } else {
                // 두번째 섹션
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(110))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(250))
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, repeatingSubitem: item, count: 2)
                
                let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalGroup])
                
                let section = NSCollectionLayoutSection(group: horizontalGroup)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        bindCollectionView()

//        bindPriceData()

        mainVM.fetchAllData()
        
        func setupCollectionView() {
            collectionView.register(MainViewFirstCell.self, forCellWithReuseIdentifier: MainViewFirstCell.id)
            collectionView.register(MainViewSecoundCell.self, forCellWithReuseIdentifier: MainViewSecoundCell.id)
            collectionView.register(MainSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeaderView.id)
            collectionView.backgroundColor = .white
            collectionView.delegate = self
            view.addSubview(collectionView)
            
            collectionView.snp.makeConstraints {
                $0.edges.equalTo(view.safeAreaLayoutGuide)
            }
        }
        
        func bindCollectionView() {
            let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Price>>(configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
                if indexPath.section == 0 {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewFirstCell.id, for: indexPath) as? MainViewFirstCell else {
                        return UICollectionViewCell()
                    }
                    cell.configure(with: item)
                    return cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewSecoundCell.id, for: indexPath) as? MainViewSecoundCell else {
                        return UICollectionViewCell()
                    }
                    cell.configure(with: FavoritesItem(leftTopText: "복숭아", rightTopText: "23,000원", rightBottomText: "20%"))
                    return cell
                }
            }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeaderView.id, for: indexPath) as? MainSectionHeaderView else {
                    return UICollectionReusableView()
                }
                
                if indexPath.section == 0 {
                    header.configure(with: "Top3")
                } else if indexPath.section == 1 {
                    header.configure(with: "관심품목")
                }
                return header
            })
          
            mainVM.foodPrices
                .map { prices in
                    return [SectionModel(model: "prices", items: prices)]
                }
                .bind(to: collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }
        
        func bindPriceData() {
            mainVM.foodPrices.observe(on: MainScheduler.instance).subscribe(onNext: {
                [weak self] data in
                print("+++called MainViewController+++")
                
                for i in data {
                    print("출력")
                    print(i.itemName)
                }
                
            }, onError: { error in
                print("--- called MainViewController ERROR ---")
                print("\(error)")
            }
            )
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let graphViewController = GraphViewController()
        present(graphViewController, animated: true, completion: nil)
            
    }
}
