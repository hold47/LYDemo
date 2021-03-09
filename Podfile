platform :ios, '11.0'

inhibit_all_warnings!
use_frameworks!

target 'LongYi_Swift' do
  
  pod 'Moya', '~> 14.0.0'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'RxGesture', '~> 3.0'
  # 记得关闭掉UIViewExtension里面的IBInspectable属性,不然打开xib巨卡
  pod 'SwifterSwift', '~> 5.0'
  pod 'CryptoSwift', '~> 1.0'
  pod 'Kingfisher', '~> 5.9'
  pod 'SwiftDate', '~> 6.2.0'
  
  # UI
  pod 'MBProgressHUD', '~> 1.2'
  pod 'SnapKit', '~> 5.0'
  pod 'MJRefresh', '~> 3.2'
  pod 'EmptyDataSet-Swift', '~> 4.2'
  pod 'IQKeyboardManagerSwift', '~> 6.5.0'
  pod 'Popover', '~> 1.2'
  pod 'RTRootNavigationController', '~> 0.7'
  pod 'FDFullscreenPopGesture', '~> 1.1'
  pod 'FSPagerView', '~> 0.8.3'
  pod 'JXSegmentedView', '~> 1.2.7'
  pod 'CHIPageControl', '~> 0.2'
  
  
  pod 'XHLaunchAd', '3.9.12'
  pod 'UMCCommon', '~> 7.1.0'
  pod 'WechatOpenSDK', '~> 1.8.7.1'
  pod 'AlipaySDK-iOS', '~> 15.7.9'
  
  
  pod 'TagListView', '~> 1.4.1'
  #  pod 'TABAnimated', '~>2.4.7'  #SkeletonView
  #  pod 'JXPhotoBrowser', '~> 2.2.6'
  #  pod 'TZImagePickerController', '~> 3.4'
  
  # 友盟
  #pod 'UMCCommon'
  #pod 'UMCSecurityPlugins'
  # U-Share SDK UI模块（分享面板，建议添加）
  #pod 'UMCShare/UI'
  # 集成微信(精简版0.2M)
  #pod 'UMCShare/Social/ReducedWeChat'
  # 集成QQ/QZone/TIM(精简版0.5M)
  #pod 'UMCShare/Social/ReducedQQ'
  #pod 'WechatOpenSDK'
  #pod 'AlipaySDK-iOS'
  # 图片剪裁
  # pod 'PhotoTweaks'
  
  
  
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
      end
    end
  end
  
  
#  post_install do |installer_representation|
#    installer_representation.pods_project.build_configurations.each do |config|
#      
#      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
#        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
#      end
#      #      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
#      #      config.build_settings['SDKROOT'] = 'iphoneos'
#      #      config.build_settings['ENABLE_BITCODE'] = 'NO'
#      #      config.build_settings['VALID_ARCHS'] = 'arm64 arm64e armv7s x86_64'
#      #       config.build_settings['SWIFT_VERSION'] = '5.0'
#      
#      #      if config.name.include?("Debug")
#      #        # 仅编译当前架构的版本
#      #        config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
#      #        # 将debug中每一个pod文件的Optimization Level设置成none,减少编译时间
#      #        config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
#      #      end
#      
#    end
#  end
  
end
