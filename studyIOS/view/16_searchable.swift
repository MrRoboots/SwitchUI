//
//  16_searchable.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI


//如果给List添加.searchable，必须配合NavigationView
//给Text添加搜索框，可以给搜索框添加可选值，还可以给这些值设置响应

struct ItemModel: Identifiable {
    var id = UUID()
    var name: String
    var detailView: DetailView
}

//创建一个详情View
//Identifiable:个对象的唯一标识
struct DetailView: View, Identifiable {
    var id = UUID()
    var detail: String
    @State var text = ""
    var body: some View {
        VStack (alignment: .leading){
            Text(detail).font(.largeTitle).foregroundColor(.gray).bold()
                .searchable(text: $text){
                    Text("大同").searchCompletion("大同")
                    Text("太原").searchCompletion("太原")
                    Text("太原").searchCompletion("太原")
                    Text("太原").searchCompletion("太原")
                    Text("太原").searchCompletion("太原")
                }
        }
       
    }
}


//定义一个数组
let datas: [ItemModel] = [
    ItemModel(name: "太原", detailView: DetailView(detail: "山西省会")),
    ItemModel(name: "西安", detailView: DetailView(detail: "陕西省会")),
    ItemModel(name: "银川", detailView: DetailView(detail: "宁夏省会")),
    ItemModel(name: "西宁", detailView: DetailView(detail: "青海省会")),
    ItemModel(name: "呼和浩特", detailView: DetailView(detail: "内蒙省会")),
    ItemModel(name: "郑州", detailView: DetailView(detail: "河南省会"))
]

//创建一个viewModel，提供了数组项
//并且还有一个filtedItems用来过滤每一项
class ViewModel: ObservableObject {
    
    @Published var allItems: [ItemModel] = datas
    @Published var searchedItem: String = ""
    
    var filtedItems: [ItemModel] {
        searchedItem.isEmpty ? allItems : allItems.filter({ str in
            str.name.lowercased().contains(searchedItem.lowercased())
        })
    }
}

struct StudySearchable : View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(viewModel.filtedItems) { data in
                    NavigationLink(data.name,destination: data.detailView)
                }
            }.navigationTitle(Text("搜索页面"))
        }
        
        
    }
}

struct StudySearchable_Previews: PreviewProvider {
    static var previews: some View {
        StudySearchable()
    }
}
