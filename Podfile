platform:ios,'9.0'
use_frameworks!
inhibit_all_warnings!

def pods

    #Swift
   
    pod 'Alamofire'#网络请求
    pod 'SnapKit'#约束布局
    pod 'Kingfisher'#图片缓存
    pod 'EmptyDataSet-Swift'#空界面

    #Objective-C

    pod 'MJRefresh'#上下拉刷新
    pod 'SVProgressHUD'#透明指示层
    pod 'RealReachability'#网络状态监测

end

target 'test' do
    pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'YES'
            config.build_settings['SWIFT_VERSION'] = '4.1'
        end
    end
end
