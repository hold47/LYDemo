//
//  String+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/28.
//  Copyright © 2020 mumu. All rights reserved.
//
import UIKit

extension String {
        
    /// 字符串 -> [String]   字符串拼接
    func arrayBy(seperator: String) -> [String] {
        return self.split(separator: ",").map({ String($0) }) //  这种如果没有count = 0
        //        return self.components(separatedBy: seperator)    这种如果没有count = 1
    }
    
    /// [String] -> 字符串
    static func arrayToString(array: [String], seperator: String) -> String {
        var temp = ""
        array.forEach { temp += "\(seperator)\($0)" }
        return temp.removingPrefix(seperator)
    }
    
    func getHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let rect = NSString(string: self).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        return rect.size.height
    }
    
    func getWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let rect = NSString(string: self).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        return rect.size.width
    }
    
    /// 必填项
    func mandatoryString(textColor:UIColor = UIColor(hexString: "FF6363")!) -> NSMutableAttributedString{
        let attstr = NSMutableAttributedString(string: self)
        attstr.addAttributes([.foregroundColor : textColor], range: NSRange(location: 0, length: 1))
        return attstr
    }
    
    /// 查找子串返回NSRange
    /// - Parameter string: 子串
    /// - Returns: NSRanges
    func nsranges(_ string: String) -> [NSRange] {
        return ranges(string).map { (range) -> NSRange in
            self.nsRange(from: range)
        }
    }
    
    /// 查找所有子串
    /// - Parameter string: 需要查找的子串
    /// - Returns: Ranges
    func ranges(_ string: String) -> [Range<String.Index>] {
        var rangeArray = [Range<String.Index>]()
        var searchedRange: Range<String.Index>
        guard let sr = self.range(of: self) else {
            return rangeArray
        }
        
        searchedRange = sr
        
        var resultRange = self.range(of: string, range: searchedRange, locale: nil)
        
        while let range = resultRange {
            rangeArray.append(range)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: string ,range: searchedRange, locale: nil)
        }
        
        return rangeArray
    }
    
    /// range转换为NSRange
    private func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /// NSRange转化为range
    private func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    /// 手机号码脱敏
    func phoneNumberProcessing() -> String {
        var mobile = self
        mobile.replaceSubrange(mobile.index(mobile.startIndex, offsetBy: 3)..<mobile.index(mobile.startIndex, offsetBy: 7), with: "****")
        return mobile
    }
    
    /// 银行卡号脱敏
    func bankNumberProcessing() -> String {
        var mobile = self
        mobile = mobile.withoutSpacesAndNewLines
        mobile.replaceSubrange(mobile.index(mobile.startIndex, offsetBy: mobile.count - 7)..<mobile.index(mobile.startIndex, offsetBy: mobile.count - 4), with: "****")
        return mobile
    }
    
    /// 获取时间差,如果大于当前时间返回true
    func compareTwoTime() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let startTime = dateFormatter.date(from: self)!
        let date1 = Date(timeInterval: 14*24*60*60, since: startTime)
        let date2 = Date()
        return date2.compare(date1) == .orderedAscending
    }
    
    /// 汉字 -> 拼音
    /// - Parameter isMarked: 是否带音标
    func chineseToPinyin(isMarked: Bool) -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        
        if isMarked {
            CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)
        } else {
            CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        }
        
        return stringRef as String
    }
    
    /// 判断是否含有中文
    func isContainedChineseWord() -> Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    //  返回第一次出现的指定子字符串在此字符串中的索引
    //  如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    /// 将字符串转换为控制器
    func convertToVc() -> UIViewController? {
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return nil
        }
        let className = nameSpace + "." + (self)
        var controller: UIViewController?
        
        if self == "ClosuresViewController" {
            
        } else {
            //  这里需要指定类的类型XX.Type
            guard let controllerClass = NSClassFromString(className) as? UIViewController.Type else { return nil }
            let vc = controllerClass.init()
            controller = vc
        }
        
        guard let pushVc = controller else { return nil }
        return pushVc
    }
    
    /// 使用下标截取字符串 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        
        let range = Range(uncheckedBounds: (lower: max(0, min(self.count, r.lowerBound)), upper: min(self.count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    /// 返回银行卡格式 8888 8888 8888 8888字符串
    /// - Parameter joined: 间隔字符串
    /// - Returns: 格式化好的字符串
    public func formateForBankCard(joined: String = " ") -> String {
        guard self.count > 0 else {
            return self
        }
        let length: Int = self.count
        let count: Int = length / 4
        var data: [String] = []
        for i in 0..<count {
            let start: Int = 4 * i
            let end: Int = 4 * (i + 1)
            data.append(self[start..<end])
        }
        if length % 4 > 0 {
            data.append(self[4 * count..<length])
        }
        let result = data.joined(separator: " ")
        return result
    }
    
    /// Path
    static var libraryPath: String! {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    static var documentPath: String! {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    
    static var cachePath: String! {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
}

//  MARK: - JSON
extension String {
    /// JSONString转换为字典
    func convertToDictionary() -> [String: Any]? {
        guard let jsonData: Data = data(using: .utf8) else { return nil }
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else { return nil }
        return dict as? [String: Any]
    }
    
    /// JSONString转换为字典数组
    func convertToJSONArray() -> [[String: Any]]? {
        guard let jsonData = self.data(using: .utf8) else { return nil }
        guard let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else { return nil }
        return array as? [[String: Any]]
    }
        
    /// JSONList转字符串
    static func string(from JSONList: [Any]) -> String? {
        guard JSONSerialization.isValidJSONObject(JSONList) else { return nil }
        do {
            let data = try JSONSerialization.data(withJSONObject: JSONList, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    /// JSON转换为字符串
    static func string(from jsonDict: [AnyHashable: Any]) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

//  MARK:- Substring
extension String {

    /// range
    func nsRangeForSubString(_ subString: String) -> NSRange? {
        guard let range = range(of: subString) else {
            return nil
        }
        return toNSRange(range)
    }

    func toNSRange(_ range: Range<String.Index>) -> NSRange {
        guard let from = range.lowerBound.samePosition(in: utf16),
            let to = range.upperBound.samePosition(in: utf16) else {
            return NSMakeRange(0, 0)
        }
        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
    }

    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) else {
                return nil
        }
        return from ..< to
    }
}

//  MARK: - QR Code
extension String {

    /// 黑白普通二维码(大小为300)
    func generateQRCode() -> UIImage {
        return generateQRCode(size: nil)
    }
   
    /// 生成带大小参数的黑白普通二维码
    func generateQRCode(size: CGFloat?) -> UIImage {
        return generateQRCode(size: size, logo: nil)
    }
    
    /// 生成带Logo二维码(大小:300)
    func generateQRCode(logo: UIImage?) -> UIImage {
       return generateQRCode(size: nil, logo: logo)
    }
    
    /// 生成大小和Logo的二维码
    func generateQRCode(size: CGFloat?, logo: UIImage?) -> UIImage {
        let color = UIColor.black   //  二维码颜色
        let bgColor = UIColor.white //  二维码背景颜色
        return generateQRCode(size: size, color: color, bgColor: bgColor, logo: logo)
    }
    
    /// 生成大小颜色和Logo的二维码
    func generateQRCode(size: CGFloat?, color: UIColor?, bgColor: UIColor?, logo: UIImage?) -> UIImage {
        
        let radius: CGFloat = 5    //圆角
        let borderLineWidth: CGFloat = 1.5 //线宽
        let borderLineColor = UIColor.gray  //线颜色
        let boderWidth: CGFloat = 8    //白带宽度
        let borderColor = UIColor.white // 白带颜色
        
        return generateQRCode(size: size, color: color, bgColor: bgColor, logo: logo,radius:radius,borderLineWidth: borderLineWidth,borderLineColor: borderLineColor,boderWidth: boderWidth,borderColor: borderColor)
    }
    
    /// 生成自定义二维码
    func generateQRCode(size: CGFloat?, color: UIColor?, bgColor: UIColor?, logo: UIImage?, radius: CGFloat, borderLineWidth: CGFloat?, borderLineColor: UIColor?, boderWidth: CGFloat?, borderColor: UIColor?) -> UIImage {
        
        let ciImage = generateCIImage(size: size, color: color, bgColor: bgColor)
        let image = UIImage(ciImage: ciImage)
        
        guard let QRCodeLogo = logo else { return image }
        
        let logoWidth = image.size.width/4
        let logoFrame = CGRect(x: (image.size.width - logoWidth) /  2, y: (image.size.width - logoWidth) / 2, width: logoWidth, height: logoWidth)
        
        //  绘制logo
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //  线框
        let logoBorderLineImagae = QRCodeLogo.getRoundRectImage(size: logoWidth, radius: radius, borderWidth: borderLineWidth, borderColor: borderLineColor)
        //  边框
        let logoBorderImagae = logoBorderLineImagae.getRoundRectImage(size: logoWidth, radius: radius, borderWidth: boderWidth, borderColor: borderColor)
        
        logoBorderImagae.draw(in: logoFrame)
    
        let QRCodeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return QRCodeImage!
    }
   
    /// 生成CIImage
    private func generateCIImage(size: CGFloat?, color: UIColor?, bgColor: UIColor?) -> CIImage {
        //  缺省值
        var QRCodeSize : CGFloat = 300      //  默认300
        var QRCodeColor = UIColor.black     //  默认黑色二维码
        var QRCodeBgColor = UIColor.white   //  默认白色背景
        
        if let size = size { QRCodeSize = size }
        if let color = color { QRCodeColor = color }
        if let bgColor = bgColor { QRCodeBgColor = bgColor }
        
        //  二维码滤镜
        let contentData = self.data(using: String.Encoding.utf8)
        let fileter = CIFilter(name: "CIQRCodeGenerator")
        fileter?.setValue(contentData, forKey: "inputMessage")
        fileter?.setValue("H", forKey: "inputCorrectionLevel")
        let ciImage = fileter?.outputImage
        
        //  颜色滤镜
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(cgColor: QRCodeColor.cgColor), forKey: "inputColor0") //  二维码颜色
        colorFilter?.setValue(CIColor(cgColor: QRCodeBgColor.cgColor), forKey: "inputColor1")   //  背景色
        
        //  生成处理
        let outImage = colorFilter!.outputImage
        let scale = QRCodeSize / outImage!.extent.size.width;
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        let transformImage = colorFilter!.outputImage!.transformed(by: transform)
        return transformImage
    }
    
}

