//
//  UIImage+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/28.
//  Copyright © 2020 mumu. All rights reserved.
//

import UIKit
import ImageIO
import CoreImage

extension UIImage {
    
}

extension UIImage {
    
    func createImage(isCornored: Bool = true, size: CGSize = CGSize.zero, backgroundColor: UIColor = .white, callBack: @escaping (_ image: UIImage) ->()) {
        //  在子线程中执行
        DispatchQueue.global().async {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            //1. 开启上下文
            UIGraphicsBeginImageContext(size)
            //2. 设置颜色
            backgroundColor.setFill()
            //3. 颜色填充
            UIRectFill(rect)
            //4. 图像绘制
            //切回角
            let path = UIBezierPath(ovalIn: rect)
            path.addClip()
            
            self.draw(in: rect)
            //5. 获取图片
            let image = UIGraphicsGetImageFromCurrentImageContext()
            //6 关闭上下文
            UIGraphicsEndImageContext()
            //回到主线程刷新UI
            DispatchQueue.main.async(execute: {
                callBack(image!)
            })
        }
    }
    
    /// 获取圆角图片(带边框)
    func getRoundRectImage(size: CGFloat, radius: CGFloat, borderWidth: CGFloat?, borderColor: UIColor?) -> UIImage {
        let scale = self.size.width / size
    
        //  初始值
        var defaultBorderWidth: CGFloat = 0
        var defaultBorderColor = UIColor.clear
        
        if let borderWidth = borderWidth { defaultBorderWidth = borderWidth * scale }
        if let borderColor = borderColor { defaultBorderColor = borderColor }
        
        let radius = radius * scale
        let react = CGRect(x: defaultBorderWidth, y: defaultBorderWidth, width: self.size.width - 2 * defaultBorderWidth, height: self.size.height - 2 * defaultBorderWidth)
        
        //  绘制图片设置
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        let path = UIBezierPath(roundedRect:react , cornerRadius: radius)
        
        //  绘制边框
        path.lineWidth = defaultBorderWidth
        defaultBorderColor.setStroke()
        path.stroke()
        path.addClip()
        
        //  画图片
        draw(in: react)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
        
    }
}

//  MARK: - GIF
extension UIImage {
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL = URL(string: gifUrl)
            else {
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
    
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

//  MARK: - QR Code
extension UIImage {
    /// 识别图片二维码
    /// - Returns: 二维码内容
    func getQRCode() -> String? {
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let features = detector?.features(in: CoreImage.CIImage(cgImage: self.cgImage!))
        guard (features?.count)! > 0 else { return nil }
        let feature = features?.first as? CIQRCodeFeature
        return feature?.messageString
    }
}
