//
//  02_lable.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI

//正常情况包含了图标和标题
//也可以设置labelStyle，设置为只显示图标或标题
//labelStyle也可以直接设置到外部视图上，可以作用到内部所有的label上
//我们还可以给一个label自由组合文本和图标。
//上文中自定义一个Label，包含两个文本和一个图标
//还可以自定义labelStyle

struct StudyLable : View {

    var body: some View {
       
        VStack{
            
            //用户界面项的标准标签，由带有标题的图标组成。
             //labelStyle设置label样式
             Label("Lightning", systemImage: "bolt.fill")
             Label("Lightning", systemImage: "bolt.fill").labelStyle(.iconOnly)
             Label("Lightning", systemImage: "bolt.fill").labelStyle(.titleOnly)
             //自定义label样式
             Label("Lightning", systemImage: "bolt.fill")
            
        }.padding()

        
        //多label统一样式
           VStack {
               Label("Rain", systemImage: "cloud.rain")
               Label("Snow", systemImage: "snow")
               Label("Sun", systemImage: "sun.max")
           }
           .labelStyle(.iconOnly)
        
        //组合标签
        Label {
            Text("第一行文字").font(.body).foregroundColor(.primary)
            Text("第二行文字").font(.subheadline).foregroundColor(.secondary)
            
        } icon: {
            Circle().fill(.orange).frame(width: 30,height: 30,alignment:.center).overlay(Text("圆").foregroundColor(.white))
        }
        
    }
}

struct StudyLable_Previews: PreviewProvider {
    static var previews: some View {
        StudyLable()
    }
}
