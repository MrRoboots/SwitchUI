//
//  04_link.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//


import Foundation
import SwiftUI

//destination参数用来设置URL
//还需要设置标题用来描述URL
//通过设置OpenURLAction覆盖默认的URL打开的方式

struct StudyLink : View {
    
    var body: some View {
        
        VStack{
            //Link
            Link(destination: URL(string:"https://www.baidu.com/")!) {
                Text("Link")
            }
            
            Link("View Our Terms of Service",
                 destination: URL(string: "https://www.example.com/TOS.html")!)
            
            //设置OpenURLAction
            Link("Visit Our Site", destination: URL(string: "https://www.example.com")!)
                .environment(\.openURL, OpenURLAction { url in
                    print("Open \(url)")
                    return .handled})
            
            
        }.padding()
        
        
    }
}

struct StudyLink_Previews: PreviewProvider {
    static var previews: some View {
        StudyLink()
    }
}
