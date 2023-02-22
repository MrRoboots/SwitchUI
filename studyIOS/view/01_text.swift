//
//  01_text.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI

struct StudyText : View {

    var body: some View {
       
        VStack{
            
            Text("我是一个Text，我是一个Text，**Markdown语法加粗了**").lineLimit(3).foregroundColor(.red)
            
        }.padding()

        
    }
}

struct StudyText_Previews: PreviewProvider {
    static var previews: some View {
        StudyText()
    }
}
