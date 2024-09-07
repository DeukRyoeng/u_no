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
class GraphViewController: UIViewController {
    private let graphView = GraphView()
    private let graphViewModel = GraphViewModel()
    private let disposeBag = DisposeBag()
    private var dateData: [String] = []
    private var priceData: [Double] = []
    private var tableData: [[String]] = []
    private var GraphPriceInfo = [PriceInfo]()
    var itemCodeData: String = "212"
    override func loadView() {
        view = graphView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createDay()
        graphView.collectionView.dataSource = self
        graphView.collectionView.delegate = self
        graphView.months = setDatePickerView()
        graphView.pickerView.dataSource = self
        graphView.pickerView.delegate = self
        bind()
    }
    func createDay(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        let currentDate = Date()
        let currentDateString = dateFormatter.string(from: currentDate)
        var date16DaysAgoString = ""
        if let date16DaysAgo = calendar.date(byAdding: .day, value: -16, to: currentDate) {
            date16DaysAgoString = dateFormatter.string(from: date16DaysAgo)
        }
        graphViewModel.fetchData(strtDay: date16DaysAgoString, endDay: currentDateString, itemCode: itemCodeData)
    }
    
    func bind(){
        graphViewModel.graphPrice.observe(on: MainScheduler.instance).skip(1).debug("test").subscribe(onNext: {[weak self] priceInfos in
            self?.priceData.removeAll()
            self?.dateData.removeAll()
            self?.tableData.removeAll()
            
            var infoAry: [PriceInfo] = priceInfos.filter { $0.countyName == "평균" }
            infoAry.sort { info1, info2 in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                if let date1 = formatter.date(from: info1.regday ?? ""),
                   let date2 = formatter.date(from: info2.regday ?? "") {
                    return date1 < date2
                }
                return false
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var previousPrice: Double? = nil
            
            for info in infoAry{
                if let priceString = info.price,
                   let price = Double(priceString.replacingOccurrences(of: ",", with: "")), // 쉼표 제거 후 Double로 변환
                   let date = info.regday,
                   let year = info.yyyy {
                    let formattedDate = "\(year)-\(date)"
                    if let dateObject = dateFormatter.date(from: formattedDate) {
                        let formattedDateString = dateFormatter.string(from: dateObject)
                        self?.priceData.append(price)
                        self?.dateData.append(formattedDateString)
                        
                        ///등락률 계산
                        var changeRateString = "-"
                        if let previousPrice = previousPrice {
                            let changeRate = ((price - previousPrice) / previousPrice) * 100
                            changeRateString = String(format: "%.2f", changeRate) + "%"
                        }
                        self?.tableData.append([formattedDateString,priceString, changeRateString])
                        previousPrice = price
                    }
                }
                
                
            }
            self?.tableData.append(["날짜", "가격", "등락률"])
            self?.setChartData()
            self?.tableData.reverse()
            self?.graphView.collectionView.reloadData()
        }).disposed(by: disposeBag)
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
    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    private func generateDataEntries() -> [ChartDataEntry] {
        var entries: [ChartDataEntry] = []
        let dateFormatter = DateFormatter()
        
        var calendar = Calendar.current
        let timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        calendar.timeZone = timeZone
        dateFormatter.timeZone = timeZone
        
        for (index, value) in priceData.enumerated() {
            guard index < dateData.count else { continue }
            let dateString = dateData[index]
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
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
            }
        }
        return entries
    }
    
}
extension GraphViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData[section].count // 각 섹션의 셀 개수
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
