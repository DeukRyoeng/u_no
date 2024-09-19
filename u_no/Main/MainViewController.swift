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
    
    private let priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시세보기", for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkGray
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = UIColor.mainBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(330))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.orthogonalScrollingBehavior = .none
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            } else if sectionIndex == 1 {
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
            return nil
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var isPriceIncrease: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setupCollectionView()
        setupPriceButton()
        bindCollectionView()
        bindPriceButton()
        mainVM.fetchAllData()
    }

    private func setupPriceButton() {
        view.addSubview(priceButton)
        priceButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
    }

    private func bindPriceButton() {
        priceButton.rx.tap
            .bind { [weak self] in
                self?.showPriceFilter()
            }
            .disposed(by: disposeBag)
    }

    private func showPriceFilter() {
        let priceFilterVC = PriceFilterViewController()
        priceFilterVC.modalPresentationStyle = .custom
        priceFilterVC.transitioningDelegate = self
        priceFilterVC.onFilterSelected = { [weak self] isPriceIncrease in
            self?.isPriceIncrease = isPriceIncrease
            self?.updateCollectionViewBasedOnFilter()
        }
        present(priceFilterVC, animated: true, completion: nil)
    }

    private func updateCollectionViewBasedOnFilter() {
        collectionView.delegate = nil
        collectionView.dataSource = nil

        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Price>>(
            configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
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
                    return cell
                }
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeaderView.id, for: indexPath) as? MainSectionHeaderView else {
                    return UICollectionReusableView()
                }
                
                if indexPath.section == 0 {
                    header.configure(with: self.isPriceIncrease ? "Top3: 시세상승" : "Top3: 시세하락")
                } else if indexPath.section == 1 {
                    header.configure(with: "관심품목")
                }
                return header
            }
        )
        
        let top3PricesObservable = self.isPriceIncrease ? mainVM.top3RisingPrices : mainVM.top3FallingPirces
        
        top3PricesObservable
            .do(onNext: { prices in
                print("Prices: \(prices)") // Debug print to check the data
            })
            .map { prices in
                [SectionModel(model: "Top3", items: prices)]
            }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.delegate = self
    }

    private func setupCollectionView() {
        collectionView.register(MainViewFirstCell.self, forCellWithReuseIdentifier: MainViewFirstCell.id)
        collectionView.register(MainViewSecoundCell.self, forCellWithReuseIdentifier: MainViewSecoundCell.id)
        collectionView.register(MainSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeaderView.id)
        collectionView.backgroundColor = UIColor.mainBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindCollectionView() {
        updateCollectionViewBasedOnFilter()
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let top3PricesObservable = isPriceIncrease ? mainVM.top3RisingPrices : mainVM.top3FallingPirces
        
        top3PricesObservable
            .take(1)
            .subscribe(onNext: { [weak self] prices in
                guard let self = self else { return }
                let selectedPrice = prices[indexPath.row]
                let graphViewController = GraphViewController()
                graphViewController.nameData = [selectedPrice]
                
                self.present(graphViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
