//
//  13_togle.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI


struct Alarm :  Hashable, Identifiable{
    var id = UUID()
    var isOn = false
    var name = ""
}

struct StudyToggle : View {
    
    @State var isEnable:Bool = false
    
    
    @State var alarms = [
        Alarm(isOn: true, name: "Morning"),
        Alarm(isOn: false, name: "Evening")
    ]
    
    var body: some View {
        
        VStack{
            
            Toggle("切换按钮",isOn:$isEnable).tint(.red)
            
            Toggle(isOn: $isEnable, label:{
                Text("按钮")
            })
            
            Toggle(sources: $alarms, isOn: \.isOn, label: {
                Text("多个按钮")
            })
            
        }.toggleStyle(.switch).padding()
        
        
    }
}

struct StudyToggle_Previews: PreviewProvider {
    static var previews: some View {
        StudyToggle()
    }
}
