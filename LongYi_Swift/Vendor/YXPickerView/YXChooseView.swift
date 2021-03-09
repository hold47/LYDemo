//
//  YXChooseView.swift
//  RuFengVideoEditDemo
//
//  Created by godox on 2020/1/10.
//  Copyright © 2020 JackMayx. All rights reserved.
//

import UIKit

public class YXChooseView: UIView {
    
    public var chooseCityNameAndCode: ((_ cityTitleArray: [String], String) -> Void)?
    public var chooseCityCodeArray: ((_ cityCodeArray: [String]) -> Void)?
    var selectCityModelArray = [YXModel]()
    
    private var modelList: [YXModel]?
    private var chooseDataArray = ArraySlice<String>()
    private var cityLiview: YXPickerListView!
    private var titleView: YXPickerTitleView!
    private var titleArray = ["请选择"]
    private lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.yx.width, height: (self.yx.getWindow?.frame.size.height)!))
        view.backgroundColor = UIColor.black
        view.alpha = 0.0
        return view
    }()
    
    private lazy var myScrollerView: UIScrollView = {
        let scrollerView = UIScrollView(frame: CGRect(x: 0, y: 100, width: self.yx.width, height: self.yx.height - (100 + Constant.safeArea.bottom)))
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.isPagingEnabled = true
        scrollerView.delegate = self
        return scrollerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        loadData()
        addSubview(myScrollerView)
        setSubviews()
        
        yx.clipRectCorner(direction: [.topLeft, .topRight], cornerRadius: 20)
        yx.getWindow?.addSubview(bgView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: 0, y: frame.origin.y + Constant.tabBar_height, width: frame.size.width, height: frame.size.height + Constant.tabBar_height)
        })
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.alpha = 0.6
            self.frame = CGRect(x: 0, y: frame.origin.y + Constant.tabBar_height - frame.size.height, width: frame.size.width, height: frame.size.height + Constant.tabBar_height)
        })
        
        titleView = YXPickerTitleView(frame: CGRect(x: 0, y: 40, width: yx.width, height: 40))
        titleView.titleArray = titleArray
        addSubview(titleView)
        titleView.delegate = self
        
        yx.getWindow?.addSubview(self)
        bgView.addTapAction(action: { [unowned self] in 
            self.disMiss()
        })
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 15, width: yx.width, height: 30))
        titleLabel.textColor = UIColor(hexString: "333333")
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = "请选择地址"
        addSubview(titleLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        
        cityLiview = YXPickerListView(frame: CGRect(x: width * CGFloat(chooseDataArray.count) , y: 0, width: width, height: myScrollerView.height))
        myScrollerView.addSubview(cityLiview)
        cityLiview.delegate = self
        cityLiview.tag = chooseDataArray.count
                
        myScrollerView.contentSize = CGSize(width: yx.width * CGFloat(chooseDataArray.count + 1), height: 0)
        myScrollerView .setContentOffset(CGPoint(x: yx.width * CGFloat(chooseDataArray.count), y: 0), animated: true)
        
        cityLiview.cityDataArray = modelList
        
    }

    ///数据
    private func loadData() {
        let path = Bundle.main.path(forResource: "city", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        do {
            modelList = try JSONDecoder().decode([YXModel].self, from: data!)
        } catch {
            print(error)
        }
    }
    
    private func disMiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = 1000
            self.bgView.alpha = 0.0
        }) { (bool) in
            self.removeFromSuperview()
            self.bgView.removeFromSuperview()
        }
    }
}


extension YXChooseView: UIScrollViewDelegate {
    ///滚动
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / yx.width
        titleView.scrollerTitle(index: Int(index))
    }
}

extension YXChooseView: YXPickerListViewDelegate {
    func yxPickerListView(at pickListView: YXPickerListView, didselectModel: YXModel) {
        
        guard didselectModel.child != nil else {
            titleArray.removeLast()
            titleArray.append(didselectModel.name ?? "")
            chooseCityNameAndCode!(titleArray, didselectModel.id ?? "")
            disMiss()
            return
        }
        
        selectCityModelArray.append(didselectModel)
        if selectCityModelArray.count == 2 {
            chooseCityCodeArray!(selectCityModelArray.map{ $0.id ?? "" })
        }
        
        titleArray.removeAll()
        chooseDataArray = chooseDataArray[0..<pickListView.tag]
        chooseDataArray.append(didselectModel.name ?? "")
        chooseDataArray.forEach { (item) in
            titleArray.append(item)
        }
        titleArray.append("请选择")
        modelList = didselectModel.child
        setSubviews()
        titleView.titleArray = titleArray
        
    }

}

extension YXChooseView: YXPickerTitleViewDelegate {
    ///点击title
    func yxpickerTitleDidselect(index: Int) {
        self.myScrollerView.setContentOffset(CGPoint(x: self.yx.width * CGFloat(index), y: 0), animated: true)
    }
}
