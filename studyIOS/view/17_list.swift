//
//  17_list.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI

//列表，就是OC中的TableView，是对UITableView的包装
//List里面设置每一项cell
//通过ForEach进行循环设置。

struct ListModel : Identifiable{
    var id = UUID()
    var name:String = ""
}

struct StudyList : View {
    
    var listModel:[ListModel] = [
        ListModel(name: "张三"),
        ListModel(name: "李四"),
        ListModel(name: "王五"),
        ListModel(name: "王五"),
        ListModel(name: "王五"),
        ListModel(name: "王五"),
        ListModel(name: "张三"),
        ListModel(name: "李四"),
    ]
    
    var body: some View {
        
        List{
            ForEach(listModel){ data in
                Text("ID:\(data.id) - NAME:\(data.name)")
            }
        }
        
    }
}

struct StudyList_Previews: PreviewProvider {
    static var previews: some View {
        StudyList()
    }
}
