//
//  21_scrollview.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/22.
//

import Foundation
import SwiftUI


//设置方向，可以选择垂直还是水平方向滑动
//设置是否显示Indicators
//通过代理增加按钮跳转某个cell，此时需要使用ScrollViewReader来实现。
//比如这里点击按钮后，可以直接跳转到底90个cell。


struct StudyScrollView : View{
    @Namespace var topID
    @Namespace var bottomID
    var body :some View{
        
        ScrollViewReader { proxy in
            ScrollView(.vertical,showsIndicators: true) {
                Button("Scroll to Bottom") {
                    withAnimation {
                        proxy.scrollTo(bottomID)
                    }
                }
                .id(topID)
                
                Button("Scroll to 90"){
                    withAnimation{
                        proxy.scrollTo(90)
                    }
                }
                
                VStack(alignment: .center, spacing: 10) {
                           ForEach(0..<100) {
                               Text("cell \($0)").font(.title).id($0)
                           }
                           .frame(maxWidth:.infinity)
                       }
                
                Button("Top") {
                    withAnimation {
                        proxy.scrollTo(topID)
                    }
                }
                .id(bottomID)
            }
        }
        
    }
    
    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}


struct StudyScrollView_Previews: PreviewProvider {
    static var previews: some View {
        StudyScrollView()
    }
}
