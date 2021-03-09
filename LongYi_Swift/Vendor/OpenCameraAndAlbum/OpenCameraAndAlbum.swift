//
//  OpenCameraAndAlbum.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

import UIKit
import Photos

class OpenCameraAndPhotosAlbum {
    
    /// 打开相册
    /// - Parameter delegateVc: 打开的控制器
    /// - Parameter takePicture: 是否是拍照
    static func open(delegateVc: UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate, takePicture: Bool) {
        
        if takePicture {
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                LYPrint("设备不支持访问相机")
                return
            }
            
            //  判断权限
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            //  无法使用相机
            if status == .restricted || status == .denied {
                
                let alertView = UIAlertController.init(title: "无法使用相机", message: "请在iPhone的\"设置-隐私-相机\"中允许访问相机", preferredStyle: UIAlertController.Style.alert)
                let confirm = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: {
                    (handleAction) in
                    
                })
                alertView.addAction(confirm)
                
                
                let done = UIAlertAction.init(title: "设置", style: UIAlertAction.Style.default, handler:{
                    (handleAction) in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                })
                alertView.addAction(done)
                delegateVc.present(alertView, animated: true, completion: nil)
                return
            } else if (status == .notDetermined) {
                ///防止拍照黑屏问题
                AVCaptureDevice.requestAccess(for: .video) { (granted) in
                    if granted{
                        DispatchQueue.main.sync {
                            
                        }
                    }
                }
                
                return
                
            }
        } else {
            if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                LYPrint("sorry, no camera or camera is unavailable.")
                return
            }
            
            let status = PHPhotoLibrary.authorizationStatus()
            
            //无法使用相册
            if status == .restricted || status == .denied {
                
                let alertView = UIAlertController.init(title: "无法使用相册", message: "请在iPhone的\"设置-隐私-相册\"中允许访问相册", preferredStyle: UIAlertController.Style.alert)
                let confirm = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: {
                    (handleAction) in
                    
                })
                alertView.addAction(confirm)
                
                
                let done = UIAlertAction.init(title: "设置", style: UIAlertAction.Style.default, handler:{
                    (handleAction) in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                })
                alertView.addAction(done)
                delegateVc.present(alertView, animated: true, completion: nil)
                return
            }
        }
        
        let mipc = UIImagePickerController()
        mipc.sourceType = takePicture ? .camera : .photoLibrary
        
        mipc.delegate = delegateVc
        mipc.mediaTypes = ["public.image"]
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
        }
        
        DispatchQueue.main.async {
            delegateVc.present(mipc, animated: true, completion: nil)
        }
        
    }
}
