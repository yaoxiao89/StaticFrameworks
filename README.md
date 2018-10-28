# StaticFrameworks

A POC for a strategy to reduce the amount of time an app takes to launch. For background, see:
* https://developer.apple.com/videos/play/wwdc2016/406
* https://developer.apple.com/videos/play/wwdc2017/413

The StaticFrameworks.xcodeproj contains 6 targets:
* NetworkCore
* PersistenceCore
* AppCore
* AppUICore
* DependencyCore
* StaticFrameworks

The StaticFrameworks target is the iOS application. The DependencyCore target is a dynamic framework. All other targets are static frameworks. The idea is to redue the number of dynamic frameworks in the iOS application:
* All static frameworks are combined to create one dynamic framework (DependencyCore)
* The dynamic framework (DependencyCore) is embedded into the app target (StaticFrameworks)
