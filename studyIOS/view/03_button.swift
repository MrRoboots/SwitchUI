//
//  03_button.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI

struct StudyButton : View {

    var body: some View {
       
        VStack{
            
            Button{
                print("点击按钮")
            } label: {
                Label("标签",systemImage: "square.and.arrow.up.fill")
            }
            
        }.padding()

        
    }
}

struct StudyButton_Previews: PreviewProvider {
    static var previews: some View {
        StudyButton()
    }
}
