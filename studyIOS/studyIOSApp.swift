//
//  studyIOSApp.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//

import SwiftUI

@main
struct studyIOSApp: App {
    var body: some Scene {
        WindowGroup {
            //定义为全局的环境变量 TabBarIndexObserved
            ContentView().environmentObject(TabBarIndexObserved())
        }
    }
}
