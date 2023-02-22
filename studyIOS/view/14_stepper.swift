//
//  14_stepper.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//

 import SwiftUI

 struct StudyStepper : View
 {
     //首先添加一个浮点类型的属性，并设置它的初始值为0.
     //该属性拥有@State绑定包装标记，
     //表示该属性将和步进器视图进行数据绑定。
      @State var temperature: Double = 0

       var body: some View
        {
             VStack
             {
                 //添加一个步进器视图，
                 Stepper(onIncrement: {
                     //步进器递增事件
                     self.temperature += 1
                 }, onDecrement: {
                     //步进器递减事件
                     self.temperature -= 1
                 },//步进器数值标签
                    label:
                 {
                     //设置步进器标签的内容，用来显示temperature属性的数值。
                     Text("Temperature: \(Int(temperature))")
                 })

                 Stepper(onIncrement: {
                     self.temperature += 1
                 }, onDecrement: {
                     self.temperature -= 1
                 },//步进器数值改变时触发的事件
                    onEditingChanged: { (item) in
                     print(item)
                 }, label: {
                     Text("Temperature: \(Int(temperature))")
                 })
             }
                 //设置VStack视图的内边距，使界面元素和屏幕的左右两侧保持一定的距离。
             .padding()
         }
 }

 struct StudyStepper_Previews : PreviewProvider {

     static var previews: some View {
         StudyStepper()
     }
 }
