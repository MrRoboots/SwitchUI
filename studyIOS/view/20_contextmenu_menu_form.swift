//
//  20_contextmenu_menu.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/22.
//

import Foundation
import SwiftUI

//contextMenu
//长按生效
//给一个view增加菜单选项
//也可以设置是否显示菜单
//案例中菜单选项有多个按钮，点击按钮后可以改变背景颜色。
//背景颜色设置到文本视图中，所以通过点击菜单选项就可以改变文本视图的背景颜色。


struct ContextMenuAndMenuAndFrom : View{
    @State var backgroundColor = Color.red
    @State var isShow = true
    
    var body: some View{
        
        VStack{
            Text("Hello world~").bold().font(.largeTitle).foregroundColor(.white).background(backgroundColor)
                .contextMenu (isShow ? ContextMenu{
                    Button("Red") {
                        backgroundColor = .red
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                    Button {
                        backgroundColor = .yellow
                    } label: {
                        Label("yellow", systemImage: "scribble")
                    }
                } : nil )
            
            
//            Menu来实现菜单视图，可以设置标题
//            菜单中可以放文本视图和按钮视图
//            并还可以再嵌套菜单视图，实现多层级菜单的选择。
            
            Menu("Menu") {
                Text("Item1")
                Text("Item2")
                Text("Item3")
                Button("Red") {
                    backgroundColor = .red
                }
                Button("Green") {
                    backgroundColor = .green
                }
                Button("Blue"){
                    backgroundColor = .blue
                }
                Button("Yellow"){
                    backgroundColor = .yellow
                }
                
                Menu("Menu") {
                    Text("Item1")
                    Text("Item2")
                    Text("Item3")
                    Button("Red") {
                        backgroundColor = .red
                    }
                    Menu("Menu") {
                        Text("Item1")
                        Text("Item2")
                        Text("Item3")
                        Button("Red") {
                            backgroundColor = .red
                        }
                    }
                }
            }
            
            
//            表单视图
//            Form和List在使用和现象是没有区别的,底层也是一样的，都是对UItableView的封装，可以看做是分组的List
//            用于分组数据输入的控件的容器，如在设置或检查器中。
            
            Form{
                Text("Item1")
                Text("Item2")
                Text("Item3")
            }
            
        }

        
    }
    
}



struct ContextMenuAndMenuAndFrom_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuAndMenuAndFrom()
    }
}
