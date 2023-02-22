//
//  08_texteditor.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//

import Foundation

import SwiftUI

//显示可编辑文本界面的控件。相当于UITextView
//可以添加.onSubmit来捕获提交事件
//点击空白区域收起键盘
//设置自动大小写的场景，比如首字母大写，全部大写，全不大写等等
//自动纠错默认为false就是会自动纠错
//直接设置.border设置圆角，只会设置外部的，不会设置内部的，因此需要手动绘制一个图像进行覆盖
//注意“热区”，只要有内容的区域都属于热区(即使这里是空白的)，热区在这里不属于空白区域
//因此需要追加热区设置.contentShape(Rectangle())

struct StudyTextEditor : View {
    @State private var content:String = ""
    var body: some View {
        
        VStack{
            
            TextEditor(text: .constant("Placeholder")).frame(width: 200,height: 50,alignment: .center)
            
        
            //TextField，预览无法操作
            TextField("首字母默认大写", text: $content).frame(width: 300, height: 20, alignment: .center)
            //自动纠错
                .disableAutocorrection(true)
            //                    .border(.red, width: 1)
            //                    .cornerRadius(20)
                .overlay{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.red, lineWidth: 2)
                        .padding(-10)
                }
                .onSubmit {
                    print("我点击了！")
                }
            
                .contentShape(Rectangle())//追加热区设置
                .onTapGesture {
                    print("tap")
                    
                }
            
            
        }
        
        
    }
}

struct StudyTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        StudyTextEditor()
    }
}
