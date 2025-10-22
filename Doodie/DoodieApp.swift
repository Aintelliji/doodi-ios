//
//  DoodieApp.swift
//  Doodie
//
//  Created by 수진 on 10/11/25.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct DoodieApp: App {
    // 서버 연결 전 임시 파이어베이스
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    // TODO:: 네비게이션 뜯어고쳐야함.. 방식...
    // swiftdata 써야함... (isProgress 담을 용도)
    
    var body: some Scene {
        WindowGroup {
            ContentView(isLogin: false)
        }
    }
}
