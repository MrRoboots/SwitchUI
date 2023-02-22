//
//  19_onopenurl.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/22.
//
// OnOpenURL 用来跳转页面，通过其他APP进行跳转到当前页面
//给TabView增加一个跳转连接，可以从外部应用跳转到当前页面
//需要在info中设置一下scheme
//如果想要删除URL type中的项，可以在Info.plist中删除，而且重新打开XCode
//.sheet用来弹出文本视图的弹框进行参数错误提醒


import Foundation
import SwiftUI

struct StudyOnOpenUrl : View {
    @State var selectIndex:Int = 0
    @State var show:Bool = true
    var body: some View {
        
        TabView(selection: $selectIndex){
            Text("Tab1").tabItem{
                Image(systemName: "person")
                Text("tab1")
            }.tag(1).badge("news")
            
            
            Text("Tab2").tabItem{
                Image(systemName: "person")
                Text("tab2")
            }.tag(2).badge("99")
        }.onOpenURL { url in
            switch url.host {
            case "tab1":
                selectIndex = 1
            case "tab2":
                selectIndex = 2
            default:
                show.toggle()
            }
        }.sheet(isPresented: $show){
//            Text("参数错误")
            
            Button("Close") {
                  show.toggle()
              }
              .interactiveDismissDisabled()//禁止手势滑动关闭界面,必须加在按钮的后面
            
        }
        
        
    }
}

struct StudyOnOpenUrl_Previews: PreviewProvider {
    static var previews: some View {
        StudyOnOpenUrl()
    }
}
