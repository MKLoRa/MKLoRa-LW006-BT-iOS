#
# Be sure to run `pod lib lint MKLoRaWAN-SB.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-SB'
  s.version          = '0.0.2'
  s.summary          = 'A short description of MKLoRaWAN-SB.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aadyx2007@163.com/MKLoRaWAN-SB'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/aadyx2007@163.com/MKLoRaWAN-SB.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKLoRaWAN-SB' => ['MKLoRaWAN-SB/Assets/*.png']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-SB/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.subspec 'SyncDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-SB/Classes/DatabaseManager/SyncDatabase/**'
    end
    
    ss.subspec 'LogDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-SB/Classes/DatabaseManager/LogDatabase/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-SB/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-SB/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-SB/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-SB/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-SB/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'TextButtonCell' do |sss|
      sss.source_files = 'MKLoRaWAN-SB/Classes/Expand/TextButtonCell/**'
    end
    
    ss.subspec 'MsgInfoCell' do |sss|
      sss.source_files = 'MKLoRaWAN-SB/Classes/Expand/MsgInfoCell/**'
    end
    
    ss.subspec 'FilterCell' do |sss|
      sss.subspec 'FilterBeaconCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Expand/FilterCell/FilterBeaconCell/**'
      end
      
      sss.subspec 'FilterByRawDataCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Expand/FilterCell/FilterByRawDataCell/**'
      end
      
      sss.subspec 'FilterEditSectionHeaderView' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Expand/FilterCell/FilterEditSectionHeaderView/**'
      end
      
      sss.subspec 'FilterNormalTextFieldCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Expand/FilterCell/FilterNormalTextFieldCell/**'
      end
      
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'AlarmFunctionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AlarmFunctionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/AlarmFunctionPage/Model'
        ssss.dependency 'MKLoRaWAN-SB/Functions/AlarmFunctionPage/View'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/AlertAlarmSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/SosAlarmSettingsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AlarmFunctionPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AlarmFunctionPage/View/**'
      end
    end
    
    ss.subspec 'AlertAlarmSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AlertAlarmSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/AlarmFunctionPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AlertAlarmSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'AuxiliaryPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AuxiliaryPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/DownlinkPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/ManDownPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/AlarmFunctionPage/Controller'
      end
    end
    
    ss.subspec 'AxisSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AxisSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/AxisSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/AxisSettingPage/Model/**'
      end
    end
    
    ss.subspec 'BleFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/BleFixPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-SB/Functions/BleFixPage/Model'
        ssss.dependency 'MKLoRaWAN-SB/Functions/BleFixPage/View'
      
        ssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/BleFixPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/BleFixPage/View/**'
      end
    end
    
    ss.subspec 'BleSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/BleSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/BleSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-SB/Functions/BleSettingsPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/BleSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/BleSettingsPage/View/**'
      end
      
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DebuggerPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/DebuggerPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DebuggerPage/View/**'
      end
      
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/UpdatePage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/SelftestPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/DebuggerPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DeviceInfoPage/Model/**'
      end
      
    end
    
    ss.subspec 'DeviceModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DeviceModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/StandbyModePage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/TimingModePage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/PeriodicModePage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/MotionModePage/Controller'
      end
    end
    
    ss.subspec 'DeviceSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DeviceSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/DeviceSettingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/SynDataPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/OnOffSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/IndicatorSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/DeviceInfoPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DeviceSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'DownlinkPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/DownlinkPage/Controller/**'
      end
    end
    
    ss.subspec 'FilterPages' do |sss|
      
      sss.subspec 'FilterByAdvNamePage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByAdvNamePage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByAdvNamePage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByAdvNamePage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBeaconPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByBeaconPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBeaconPage/Header'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBeaconPage/Model'
          
        end
        
        ssss.subspec 'Header' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByBeaconPage/Header/**'
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByBeaconPage/Model/**'
          
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBeaconPage/Header'
        end
      end
      
      sss.subspec 'FilterByBXPButtonPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByBXPButtonPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBXPButtonPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByBXPButtonPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBXPTagPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByBXPTagPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBXPTagPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByBXPTagPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByMacPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByMacPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByMacPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByMacPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByOtherPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByOtherPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByOtherPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByOtherPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByPirPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByPirPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByPirPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByPirPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByRawDataPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByRawDataPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByRawDataPage/Model'
          
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBeaconPage/Controller'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByUIDPage/Controller'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByURLPage/Controller'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByTLMPage/Controller'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBXPButtonPage/Controller'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByBXPTagPage/Controller'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByPirPage/Controller'
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByOtherPage/Controller'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByRawDataPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByTLMPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByTLMPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByTLMPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByTLMPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByUIDPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByUIDPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByUIDPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByUIDPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByURLPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByURLPage/Controller/**'
        
          sssss.dependency 'MKLoRaWAN-SB/Functions/FilterPages/FilterByURLPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/FilterPages/FilterByURLPage/Model/**'
        end
      end
      
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/GeneralPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/DeviceModePage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/AuxiliaryPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/BleSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/AxisSettingPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/GeneralPage/Model/**'
      end
      
    end
    
    ss.subspec 'IndicatorSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/IndicatorSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/IndicatorSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/IndicatorSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'LCGpsFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LCGpsFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/LCGpsFixPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LCGpsFixPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LoRaApplicationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/LoRaApplicationPage/Model'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/MessageTypePage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LoRaApplicationPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LoRaPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/LoRaSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/LoRaApplicationPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LoRaPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LoRaSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/LoRaSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LoRaSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'LRGpsFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LRGpsFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/LRGpsFixPage/Model'
        ssss.dependency 'MKLoRaWAN-SB/Functions/LRGpsFixPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LRGpsFixPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/LRGpsFixPage/View/**'
      end
      
    end
    
    ss.subspec 'ManDownPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/ManDownPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/ManDownPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/ManDownPage/Model/**'
      end
      
    end
    
    ss.subspec 'MessageTypePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/MessageTypePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/MessageTypePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/MessageTypePage/Model/**'
      end
      
    end
    
    ss.subspec 'MotionModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/MotionModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/MotionModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/MotionModePage/Model/**'
      end
      
    end
    
    ss.subspec 'OnOffSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/OnOffSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/OnOffSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/OnOffSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/PeriodicModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/PeriodicModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/PeriodicModePage/Model/**'
      end
      
    end
    
    ss.subspec 'PositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/PositionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/PositionPage/Model'
                
        ssss.dependency 'MKLoRaWAN-SB/Functions/WifiFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/BleFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/LCGpsFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/LRGpsFixPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/PositionPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-SB/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/ScanPage/View/**'
        ssss.dependency 'MKLoRaWAN-SB/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'SelftestPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/SelftestPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/SelftestPage/View'
        ssss.dependency 'MKLoRaWAN-SB/Functions/SelftestPage/Model'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/SelftestPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/SelftestPage/Model/**'
      end
    end
    
    ss.subspec 'SosAlarmSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/SosAlarmSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/SosAlarmSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/SosAlarmSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'StandbyModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/StandbyModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/StandbyModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/StandbyModePage/Model/**'
      end
    end
    
    ss.subspec 'SynDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/SynDataPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/SynDataPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/SynDataPage/View/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/PositionPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-SB/Functions/DeviceSettingPage/Controller'
      end
    end
    
    ss.subspec 'TimingModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/TimingModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/TimingModePage/Model'
        ssss.dependency 'MKLoRaWAN-SB/Functions/TimingModePage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/TimingModePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/TimingModePage/View/**'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.subspec 'WifiFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/WifiFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-SB/Functions/WifiFixPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-SB/Classes/Functions/WifiFixPage/Model/**'
      end
    end
    
    ss.dependency 'MKLoRaWAN-SB/SDK'
    ss.dependency 'MKLoRaWAN-SB/DatabaseManager'
    ss.dependency 'MKLoRaWAN-SB/CTMediator'
    ss.dependency 'MKLoRaWAN-SB/ConnectModule'
    ss.dependency 'MKLoRaWAN-SB/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary',      '4.13.0'
    
  end

end
