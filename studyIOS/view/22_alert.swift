//
//  22_alert.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/22.
//

import Foundation
import SwiftUI

//这里可以设置多种按钮类型
//可以设置点击事件的响应
//还可以设置按钮列表，进行选择点击

struct StudyAlert : View {
    @State var showAlert:Bool = false
    @State var showDialog:Bool = false
    var body: some View {
       
        VStack{
            
            //Alert
            Button("show Alert") {
                showAlert.toggle()
            }
            .alert(isPresented: $showAlert) {
                Alert.init(title: Text("title"), message: Text("message"), dismissButton: .cancel())
            }
                
            Button("show Dialog") {
                showDialog.toggle()
            }.confirmationDialog("dialog", isPresented: $showDialog) {
                Button("btn1") {}
                Button("btn2") {}
                Button("btn3") {}
            }
            
        }.padding()

        
    }
}

struct StudyAlert_Previews: PreviewProvider {
    static var previews: some View {
        StudyAlert()
    }
}
