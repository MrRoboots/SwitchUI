//
//  11_progressview.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//


import Foundation
import SwiftUI

struct StudyProgressView : View {
    
    @State var progress:Double = 0.1
    
    
//    进度条颜色的设置.tint(.red)
//    view的颜色的设置.background(.green)
//    进度条值的设置，默认是0-1，我们可以也可以设置总数
//    空进度条的样式，可以直接设置成ProgressView()，此时是加载图，如果需要设置空进度条，就.progressViewStyle(.linear)
//    .progressViewStyle()就可以设置进度条的样式


    var body: some View {
        
               let start = Date().addingTimeInterval(-30)
                 let end = Date().addingTimeInterval(90)
        
        VStack{
          
            
            ProgressView(value: progress, total: 10, label: {
                Text("进度条")
            }, currentValueLabel: {
                Text("start")
            })
            .progressViewStyle(.circular)
            
            
            
            Button("加1") {
                progress += 0.1
            }
            ProgressView(value:progress,total: 10).progressViewStyle(.linear).tint(.red)
    
            
            ProgressView(timerInterval: start...end,
                                countsDown: false) {
                        Text("Progress")
                    } currentValueLabel: {
                      Text(start...end)
                     }
            
        }
        
    }
    
    
}

struct StudyProgressView_Previews: PreviewProvider {
    static var previews: some View {
        StudyProgressView()
    }
}
