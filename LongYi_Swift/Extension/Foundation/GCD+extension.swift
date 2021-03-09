//
//  GCD+extension.swift
//  firefly20200330
//
//  Created by 扬 on 2020/4/13.
//  Copyright © 2020 mumu. All rights reserved.
//

public typealias GCDTask = () -> Void

/// 主线程延迟执行
@discardableResult
public func delay(_ seconds: Double, _ block: @escaping GCDTask) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: block)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
    return item
}

/// 异步线程延迟执行
@discardableResult
public func asyncDelay(_ seconds: Double,_ task: @escaping GCDTask) -> DispatchWorkItem {
    return _asyncDelay(seconds, task)
}

@discardableResult
public func asyncDelay(_ seconds: Double,_ task: @escaping GCDTask,_ mainTask: GCDTask? = nil) -> DispatchWorkItem {
    return _asyncDelay(seconds, task, mainTask)
}

fileprivate func _asyncDelay(_ seconds: Double,_ task: @escaping GCDTask, _ mainTask : GCDTask? = nil) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: task)
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
    if let main = mainTask {
        item.notify(queue: DispatchQueue.main, execute: main)
    }
    return item
}

/// 互斥锁
func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try body()
}

extension DispatchQueue {
    private static var _onceToken = [String]()
    
    /// 同步执行一次
    class func once(token: String = "\(#file):\(#function):\(#line)", block: ()->Void) {
        objc_sync_enter(self)
        
        defer { objc_sync_exit(self) }
        
        if _onceToken.contains(token) {
            return
        }
        _onceToken.append(token)
        block()
    }
}
