//
//  file+extension.swift
//  WoLawyer
//
//  Created by TLL on 2019/12/30.
//  Copyright © 2019 wo_lawyer. All rights reserved.
//

import UIKit


// 显示缓存大小
func cacheSize() -> Double {
  let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
  return folderSize(filePath: cachePath)
}

//计算单个文件的大小
func fileSize(filePath: String) -> UInt64 {
  let manager = FileManager.default
  if manager.fileExists(atPath: filePath) {
    do {
        let attr = try manager.attributesOfItem(atPath: filePath)
        let size = attr[FileAttributeKey.size] as! UInt64
        return size
    } catch  {
        LYPrint("error :\(error)")
        return 0
    }
  }
  return 0
}

//遍历文件夹，返回多少k
func folderSize(filePath: String) -> Double {
  let folderPath = filePath
  let manager = FileManager.default
  if manager.fileExists(atPath: filePath) {
      // 取出文件夹下所有文件数组
      let fileArr = FileManager.default.subpaths(atPath: folderPath)
      
      /* 文件总的大小 */
      var totleSize = 0.0
      for file in fileArr! {
          
          // 把文件名拼接到路径中
          let path = folderPath.appending("/\(file)")
          // 取出文件属性
        let floder = try! FileManager.default.attributesOfItem(atPath: path)
       
        /* 用元组来取得 文件的的大小 */
          for (key,value) in floder {
              
              if key == FileAttributeKey.size {
                  /* 每个文件的大小 */
                  let size = (value as! Double)
                  totleSize += size //总的大小
              }
              
          }
      }
      
    return  totleSize
  }
  return 0
}

// 清除缓存
func clearCache() {

        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            let path = cachePath?.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path!) {
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    
                }
            }
        }
}

// 清除doc文件
func clearDocPathCache() {

        // 取出cache文件夹目录 缓存文件都在这个目录下
    let cachePath = Constant.docPath
        
        // 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath)
        
        // 遍历删除
        for file in fileArr! {
            let path = cachePath.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
}

//删除沙盒里的文件
func deleteFile(filePath: String) {
  let manager = FileManager.default
  let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
  let uniquePath = path.appendingPathComponent(filePath)
  if manager.fileExists(atPath: uniquePath) {
    do {
        try FileManager.default.removeItem(atPath: uniquePath)
    } catch {
        LYPrint("error:\(error)")
    }
  }
    
    /// 检查目录是否存在，如果不存在则创建
    func directoryExisted(path: String) -> Bool {
        var directoryExists = ObjCBool.init(false)
        let existed = FileManager.default.fileExists(atPath: path, isDirectory:  &directoryExists)

        //  目录不存在
        if !(existed == true && directoryExists.boolValue == true) {
            do{
                
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            catch{
                return false
            }
        }
        
        return true
    }
}
