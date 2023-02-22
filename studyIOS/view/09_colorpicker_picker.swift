//
//  09_colorpicker.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//


import Foundation
import SwiftUI

struct StudyColorPicker : View {
    
    
    
    @State var textColor = Color.red
    @State var selectedCity = "成都市"
    
    
    var body: some View {
    
        
        VStack{
            
     
            //ColorPicker
            //supportsOpacity是否设置透明度
            ColorPicker("picker", selection: $textColor, supportsOpacity: false).font(.largeTitle).foregroundColor(textColor)
            
         

            //Picker
            //$selectedCity就是获取的值
            //设置多种选择项
            Picker(selection: $selectedCity, label: Text("Picker").frame(width: 50, height: 10, alignment: .center)) {
                Text("省").tag("成都市")
                Text("市").tag(2)
                Text("区").tag(3)
            }.border(.orange)
            
            Text("this city is : \(selectedCity)")
            
            
        }.padding()

        
    }
}

struct StudyColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        StudyColorPicker()
    }
}
