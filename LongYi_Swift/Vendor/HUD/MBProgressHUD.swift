//
//  MBProgressHUD.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

import UIKit
import MBProgressHUD

public let HUD = Hud.default
public let HUDLastTime: TimeInterval = 1.5

public final class Hud {
    public let contentView: UIView
    public let progressHUD: MBProgressHUD
    public static let `default`: Hud = Hud(Constant.keyWindow)
    
    init(_ contentView: UIView) {
        self.contentView = contentView
        progressHUD = MBProgressHUD(view: contentView)
        progressHUD.areDefaultMotionEffectsEnabled = false
        progressHUD.margin = 10
        contentView.addSubview(progressHUD)
    }
    
    public enum ContentType {
        case success(String?)
        case error(String?)
        case toast(String?)
        case loading(String? = nil)
        case `default`
    }
    
    @discardableResult
    public func show(_ type: ContentType) -> Hud {
        progressHUD.backgroundColor = .clear
        progressHUD.bezelView.style = .solidColor
        progressHUD.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        switch type {
        case .toast(let message):
            show(message)
        case .error(let message):
            let imageView = UIImageView(image: UIImage(named: "hud_fail"))
            show(message, mode: .customView, customView: imageView)
        case .success(let message):
            let imageView = UIImageView(image: UIImage(named: "hud_success"))
            show(message, mode: .customView, customView: imageView)
        case .loading(let message):
            progressHUD.bezelView.backgroundColor = .clear
            progressHUD.backgroundColor = UIColor(hexString: "000000")?.withAlphaComponent(0.4)
            /// 菊花动画
            let image = UIImage(named: "loading1")?.scaled(toWidth: 40)
            let imageView = UIImageView(image: image)
            let anim = CABasicAnimation(keyPath: "transform.rotation.z")
            anim.toValue = Double.pi * 2
            anim.duration = 1
            anim.repeatCount = MAXFLOAT
            anim.fillMode = .forwards
            anim.isRemovedOnCompletion = false
            anim.isCumulative = true
            imageView.layer.add(anim, forKey: "rotation")
            show(message, mode: .customView, customView: imageView)
        case .default:
            progressHUD.show(animated: true)
        }
        return self
    }
    
    @discardableResult
    private func show(_ message: String?, mode: MBProgressHUDMode = MBProgressHUDMode.text, customView: UIView? = nil, isAnimated: Bool = true) -> Hud {

        progressHUD.detailsLabel.text = message
        progressHUD.mode = mode
        progressHUD.customView = customView
        progressHUD.detailsLabel.textColor = .white
        progressHUD.detailsLabel.numberOfLines = 0
        progressHUD.detailsLabel.font = UIFont.systemFont(ofSize: 12)

        progressHUD.show(animated: isAnimated)
        contentView.bringSubviewToFront(progressHUD)
        return self
    }
    
    @discardableResult
    public func hide(_ delay: TimeInterval = 0, animated: Bool = true, execute: (() -> Void)? = nil) -> Hud {
        progressHUD.hide(animated: animated, afterDelay: delay)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(delay * 1000))) {
            execute?()
        }
        return self
    }
    
}
