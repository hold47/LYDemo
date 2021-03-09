//
//  LYHomeMiaoshaHeader.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/2.
//

import UIKit

class LYHomeMiaoshaHeader: BaseCollectionReusableView {
    
    let counter = CountDown()
    var model: LYMiaoshaModel? {
        didSet {
            let currentTime = (model?.timestamp ?? 0) * 1000
            let startTime = (model?.spike_notice?.start_time ?? 0) * 1000
            let endTime = (model?.spike_notice?.end_time ?? 0) * 1000

            if (currentTime < startTime) {
                startCountDown(start: currentTime, end: startTime)
                resultLabel.text = "后开始"
            }
            if (currentTime > startTime && currentTime < endTime ) {
                startCountDown(start: currentTime, end: endTime)
                resultLabel.text = "后结束"
            }

            let current = startTime / 1000
            let date = Date(timeIntervalSince1970: TimeInterval(current))
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let currentDateString = formatter.string(from: date)
            changciLabel.text = "\(currentDateString)点场"
        }
    }
    /// 此方法用两个时间戳做参数进行倒计时
    func startCountDown(start: Int, end: Int) {
        // 销毁定时器,不然无法刷新
        counter.destoryTimer()
        counter.countDown(withStratTimeStamp: start, finishTimeStamp: end) { [weak self] (day, hour, minute, second) in
            self?.refreshUI(day: day, hour: hour, minute: minute, second: second)
        }
    }
    
    func refreshUI(day: Int, hour: Int, minute: Int, second: Int) {
        dayLabel.text = String(format: "%02d", day)
        hourLabel.text = String(format: "%02d", hour)
        minuteLabel.text = String(format: "%02d", minute)
        secondLabel.text = String(format: "%02d", second)
    }
    
    
    @IBOutlet weak var changciLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var hourLabel: UILabel! {
        didSet {
            hourLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var minuteLabel: UILabel! {
        didSet {
            minuteLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var secondLabel: UILabel! {
        didSet {
            secondLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton! {
        didSet {
            moreButton.layoutImage(type: .right, space: 5)
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 8
        }
    }
    
}
