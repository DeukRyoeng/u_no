//
//  GraphViewController.swift
//  u_no
//
//  Created by 백시훈 on 8/29/24.
//

import Foundation
import UIKit
import DGCharts
import RxSwift
import RxCocoa
import CoreData

class GraphViewController: UIViewController {
    private let graphView = GraphView()
    private let graphViewModel = GraphViewModel()
    private let disposeBag = DisposeBag()
    private let common = Common()
    
    private var dateData: [String] = []
    private var priceData: [Double] = []
    private var tableData: [[String]] = []
    var nameData: [Price] = []

    override func loadView() {
        view = graphView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        graphView.collectionView.dataSource = self
        graphView.collectionView.delegate = self
        graphView.months = setDatePickerView()
        graphView.pickerView.dataSource = self
        graphView.pickerView.delegate = self
        setupBindings()
    }

    // 버튼 처리
    private func setupBindings() {
        graphView.backButton.rx.tap
            .bind { [weak self] in
                self?.presentingViewController?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)

        graphView.favoritPlusButton.rx.tap
            .bind { [weak self] in
                self?.addFavorite()
            }
            .disposed(by: disposeBag)
        
        graphViewModel.tableData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  datas in
                self?.tableData.removeAll()
                self?.tableData = datas
                self?.graphView.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(graphViewModel.priceData, graphViewModel.dateData)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (prices, dates) in
                self?.priceData = prices
                self?.dateData = dates
                if self?.priceData.count != 0 && self?.dateData.count != 0{
                    self?.setChartData()
                }
                
            })
            .disposed(by: disposeBag)
        
        graphViewModel.alertMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                self?.common.showAlert(viewController: self!, message: message)
            })
            .disposed(by: disposeBag)
        
    }

    // 즐겨찾기 추가 기능
    private func addFavorite() {
        guard let name = nameData.first?.itemName,
              let price = priceData.last.map({ String($0) }),
              let fluctuationRate = nameData.first?.value.asString(),
              let productno = nameData.first?.productno else {
            return
        }
        graphViewModel.savedFavoriteCoreData(name: name, price: price, discount: fluctuationRate, productno: productno)
    }

        
    func retrieveData() {
        graphView.textField.isHidden = true
        graphView.titleLabel.text = nameData.first?.itemName
        graphViewModel.fetchData(regday: nameData.first?.lastestDay ?? "", productNo: nameData.first?.productno ?? "")
    }
    

    private func setDatePickerView() -> [String]{
        var result: [String] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        if let month = Int(formatter.string(from: Date())) {
            for i in 1...month {
                result.append("\(i)월")
            }
        }
        return result
    }

    private func setChartData() {
        let entries = generateDataEntries()
        graphView.setData(entries: entries)
    }

    private func generateDataEntries() -> [ChartDataEntry] {
        var entries: [ChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var calendar = Calendar.current
        let timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        calendar.timeZone = timeZone
        dateFormatter.timeZone = timeZone
        
        let reversedPriceData = priceData.reversed()
        let reversedDateData: [String] = dateData.reversed()
        
        for (index, value) in reversedPriceData.enumerated() {
           
            let dateString = reversedDateData[index]
            
            if let date = dateFormatter.date(from: dateString) {
                var components = calendar.dateComponents([.year, .month, .day], from: date)
                components.hour = 0
                components.minute = 0
                components.second = 0

                if let startOfDay = calendar.date(from: components) {
                    let timestamp = startOfDay.timeIntervalSince1970
                    let entry = ChartDataEntry(x: timestamp, y: value)
                    entries.append(entry)
                }
            } else {
                print("Error: 타입 에러 \(dateString)")
            }
        }
        return entries
    }
}

extension GraphViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section < tableData.count ? tableData[section].count : 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tableData.count // 섹션 개수
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        // 셀에 데이터 설정
        let data = tableData[indexPath.section][indexPath.item]
        let label = UILabel()
        label.text = data
        label.frame = cell.contentView.bounds
        
        // 셀 정렬
        if indexPath.item == 2 {
            label.textAlignment = .right
        } else if(indexPath.item == 0){
            label.textAlignment = .left
        }else{
            label.textAlignment = .center
        }
        
        cell.contentView.addSubview(label)
        
        let separator = UIView(frame: CGRect(x: 0, y: cell.contentView.bounds.height - 1, width: cell.contentView.bounds.width, height: 1))
        separator.backgroundColor = .black
        cell.contentView.addSubview(separator)
        
        
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        let numberOfColumns: CGFloat = 3 // 3 열
        let itemWidth = totalWidth / numberOfColumns
        return CGSize(width: itemWidth, height: 40) // 셀 크기 설정
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 셀 간의 간격
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 줄 간의 간격
    }
}

extension GraphViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        graphView.months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        graphView.months[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        graphView.textField.text = graphView.months[row]
        self.view.endEditing(true)
    }
}
