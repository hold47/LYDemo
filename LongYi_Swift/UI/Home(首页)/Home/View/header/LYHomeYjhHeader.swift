//
//  LYHomeYjhHeader.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/12.
//

import UIKit
import JXSegmentedView

extension LYHomeYjhHeader: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        selectIndex?(index)
    }
    
}

class LYHomeYjhHeader: BaseCollectionReusableView {
    
    @IBOutlet weak var bgView2: UIView! {
        didSet {
            bgView2.backgroundColor = Constant.yjhColor
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 8
        }
    }
    @IBOutlet weak var segmentView: JXSegmentedView! {
        didSet {
            segmentView.backgroundColor = Constant.yjhColor
        }
    }
    var segmentDatasource: JXSegmentedTitleDataSource!
    var segmentIndicator: JXSegmentedIndicatorLineView!
    var selectIndex: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
    override func initSubviews() {
        //  segmentView
        segmentView.delegate = self
        segmentDatasource = JXSegmentedTitleDataSource()
        segmentDatasource.titleSelectedColor = .white
        segmentDatasource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 15)
        segmentDatasource.titleNormalColor = UIColor(hexString: "#BAD8FF")!
        segmentDatasource.titleNormalFont = UIFont.systemFont(ofSize: 15)
        segmentView.dataSource = segmentDatasource
        segmentIndicator = JXSegmentedIndicatorLineView()
        segmentIndicator.indicatorWidth = 60
        segmentIndicator.indicatorHeight = 2
        segmentIndicator.indicatorColor = .white
        segmentIndicator.verticalOffset = 5
        segmentView.indicators = [segmentIndicator]
    }
    
}
