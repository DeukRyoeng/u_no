//
//  GraphView.swift
//  u_no
//
//  Created by 백시훈 on 8/29/24.
//

import Foundation
import UIKit
import SnapKit
import DGCharts
import Charts
class GraphView: UIView{
    let lineChart = LineChartView()
    let collectionView: UICollectionView
    let pickerView = UIPickerView()
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    var months: [String] = []
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical              // 세로 방향 스크롤
        layout.itemSize = CGSize(width: 80, height: 40) // 셀 크기 설정
        layout.minimumInteritemSpacing = 10             // 셀 간 간격 설정
        layout.minimumLineSpacing = 10                  // 줄 간 간격 설정
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        backgroundColor = .white
        setConfigure()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
    private func setConfigure(){
        textField.inputView = pickerView
        textField.text = months.last
        [lineChart, collectionView, textField].forEach { addSubview($0) }
        lineChart.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(300)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(lineChart.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(lineChart.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(200)
        }
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.drawGridLinesEnabled = false//보조선
        lineChart.xAxis.labelRotationAngle = -45
        lineChart.xAxis.forceLabelsEnabled = true
        lineChart.xAxis.granularity = 0.5
        lineChart.xAxis.granularityEnabled = true
        lineChart.leftAxis.enabled = false
        
        let yAxisFormatter = NumberFormatter()
        yAxisFormatter.numberStyle = .decimal
        lineChart.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: yAxisFormatter)
        lineChart.rightAxis.forceLabelsEnabled = true
        lineChart.xAxis.drawLabelsEnabled = false
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    func setData(entries: [ChartDataEntry]) {
        let lineChartDataSet = LineChartDataSet(entries: entries, label: "가격")
        lineChartDataSet.colors = [.green]         // 선 색상 설정
        lineChartDataSet.circleColors = [.red]     // 데이터 포인트 색상 설정
        lineChartDataSet.drawCirclesEnabled = true // 데이터 포인트 표시 여부 설정
        lineChartDataSet.valueFormatter = self     // 데이터 포인트 위 값 포맷터 설정
        lineChartDataSet.circleRadius = 5.0
        lineChartDataSet.valueFont = .boldSystemFont(ofSize: 8)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChart.data = lineChartData
        guard let firstEntry = entries.first, let lastEntry = entries.last else { return }
        lineChart.xAxis.axisMinimum = firstEntry.x
        lineChart.xAxis.axisMaximum = lastEntry.x
        lineChart.xAxis.labelCount = entries.count
        lineChart.xAxis.valueFormatter = self
    }
    
}
extension GraphView: AxisValueFormatter, ValueFormatter {
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
