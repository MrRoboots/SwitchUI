//
//  prop_wrapper.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/22.
//

import Foundation
import SwiftUI


//@State将属性和视图进行绑定，是唯一真实数据源。子视图和父视图之间是值传递
//@Binding在子视图和父视图之间是指针传递
//@ObservableObject只能监听对象，并且可以在多个视图中监听
//@EnvironmentObject将数据放到环境中，更适用在多视图中


//@State 值传递
//SwiftUI管理声明为state的存储属性。当值发生变化时，SwiftUI会更新视图层次结构中依赖于该值的部分。使用@State作为存储在视图层次结构中的给定值的唯一真值来源。
//@State修饰的属性虽然是存储属性，但是我们可以进行读写操作。
//
//父视图和子视图进行传递该属性只能是值传递。
//
//需要在属性名称前加上一个美元符号$来获得这个值。因为它是投影属性


//@Binding 指针传递
//@State修饰的属性是值传递，因此在父视图和子视图之间传递属性时。子视图针对属性的修改无法传递到父视图上。
//Binding修饰后会将属性会变为一个引用类型，视图之间的传递从值传递变为了引用传递，将父视图和子视图的属性关联起来。这样子视图针对属性的修改，会传递到父视图上。
//需要在属性名称前加上一个美元符号$来获得这个值。因为它是投影属性


//@ObservableObject
//对实例进行监听，其用处和@State非常相似，只不过必须是对象，而且这个被监听的对象可以被多个视图使用。需要注意用法


struct PropWrapper : View{
    @State private var str:String = ""
    @State private var isShowText = false
    @State private var buttonText = "按钮"
    
    @ObservedObject var updater = DelayedUpdater()
    
    let envUpdater = DelayedUpdater()
    
    var body:some View{
        VStack{
            TextField("请输入",text: $str).textFieldStyle(RoundedBorderTextFieldStyle()).border(.black).padding()
            
            //            按钮在BtnView视图中，并且通过点击，修改isShowText的值。
            //            将BtnView视图添加到ContentView上作为它的子视图。并且传入isShowText。
            //            此时的传值是指针传递，会将点击后的属性值传递到父视图上。
            //            父视图拿到后也作用在自己的属性，因此他的文本视图会依据该属性而隐藏或显示
            //            如果将@Binding改为@State，会发现点击后不起作用。这是因为值传递子视图的更改不会反映到父视图上
            
            if(isShowText) {
                Text("点击后会被隐藏")
            } else {
                Text("点击后会被显示").hidden()
            }
            
            BtnView(isShowText: $isShowText,buttonText: $buttonText)
            
            //            绑定的数据是一个对象。
            //            被修饰的对象，其类必须遵守ObservableObject协议
            //            此时这个类中被@Published修饰的属性都会被绑定
            //            使用@ObservedObject修饰这个对象，绑定这个对象。
            //            被@Published修饰的属性发生改变时，SwiftUI就会进行更新。
            //            这里当value值会随着时间发生改变。所以updater对象也会发生改变。此时文本视图的内容就会不断更新。
            
            Text("\(updater.value)").padding()
            
            
            
            //在多视图中，为了避免数据的无效传递，可以直接将数据放到环境中，供多个视图进行使用。
//            给属性添加@EnvironmentObject修改，就将其放到了环境中。
//            其他视图中想要获取该属性，可以通过.environmentObject从环境中获取。
//            可以看到分别将EnvView和BtnvView的属性分别放到了环境中
//            之后我们ContentView视图中获取数据时，可以直接通过环境获取。
//            不需要将数据传递到ContentView，而是直接通过环境获取，这样避免了无效的数据传递，更加高效
//            如果是在多层级视图之间进行传递，会有更明显的效果。

            EnvView().environmentObject(envUpdater)
            BtnvView().environmentObject(envUpdater)
            
        }
        
    }
    
}


struct BtnView:View{
    @Binding var isShowText:Bool
    @Binding  var buttonText:String
    
    var body: some View{
        VStack{
            Button{
                isShowText.toggle()
            }label: {
                Text(buttonText)
            }
      
        }
    }
}

struct BtnvView:View{
    @EnvironmentObject var updater: DelayedUpdater
    var body: some View{
        Text("\(updater.value)").padding()
    }
}

struct EnvView: View {
    @EnvironmentObject var updater: DelayedUpdater
    
    var body: some View {
        Text("\(updater.value)")
    }
}


class DelayedUpdater: ObservableObject {
    @Published var value = 0
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}






struct PropWrapper_Previews: PreviewProvider {
    static var previews: some View {
        PropWrapper()
    }
}
