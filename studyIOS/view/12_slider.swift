//
//  12_slider.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI

//滑动时动态获取到的值是value
//in是设置滑动范围
//step是可以设置整个范围多少等分（可以设置自己的精确度）
//onEidtingChanged是滑动时的响应操作
//还可以设置最大范围和最小范围显示

struct StudySlider : View {
    
    @State private var isEditing = false
    @State private var speed = 0.0
    
    var body: some View {
        
        VStack{
            Slider(
                value: $speed,
                in: 0...100,
                step: 1
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            Text("\(String(format: "%.1f", speed))")
                .foregroundColor(isEditing ? .red : .blue)
        }
        
    }
    
}

struct StudySlider_Previews: PreviewProvider {
    static var previews: some View {
        StudySlider()
    }
}
