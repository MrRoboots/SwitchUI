//
//  23_stacks.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/22.
//

import Foundation
import SwiftUI

//
//UI通常由多种不同类型的视图组合而成。我们如何对他们进行分组以及布局定位？此时就需要使用stacks。我们可以使用三种堆栈来对UI进行分组:
//
//HStack - 水平排列其子视图
//VStack - 垂直排列其子视图
//ZStack -根据深度排列子视图(例如从后到前)
//在这三种Stack的基础上还有一种懒加载的Stack，叫lazyStack.
//
//除此之外还需要了解绝地位置和相对位置的使用
//
//注意： SwiftUI没有坐标系这种说法，使用弹性布局。类似于HTML的布局方式


//VStack的Text和button就会垂直分布，Text视图堆叠在Button视图的上方
//HStack的Text和button会水平分布，Text视图堆叠在Button视图的左侧
//ZStack的Text和button会水平分布，Text视图堆叠在Button视图的底部
//默认情况下一个Stack的两个View之间的间隔很少或没有间隔，但是我们可以通过提供一个参数(spacing)来控制间隔
//VStack默认也会将视图居中对齐。但我们可以使用' alignment '属性进行更改，这里进行左对齐
//HStack的语法与VStack相同，包括指定空格和对齐。ZStack也可以指定对齐方式，但是不能指定空格

struct StudyStacks : View{
    
    var body:some View{
        
        
        
        
        ScrollView{
            //包括leading、trailing、center
            VStack(alignment:.leading, spacing: 20){
                Text("orange").background(.orange).font(.caption)
                Text("red").background(.red).font(.title)
                Text("blue").background(.blue).font(.largeTitle)
                Text("yellow").background(.yellow).font(.callout)
            }
            .border(.gray)


            //包括bottom、top、firstTextBaseline、lastTextBaseline、center、
            HStack(alignment:.lastTextBaseline, spacing: 20){
                Text("orange").background(.orange).font(.caption)
                Text("red").background(.red).font(.title)
                Text("blue").background(.blue).font(.largeTitle)
                Text("yellow").background(.yellow).font(.callout)
            }
            .border(.gray)


            //包括leading、trailing、bottom、top、bottomLeading、topLeading、bottomtrailing、toptrailing、center
            ZStack(alignment: .topTrailing){
                Text("orange").background(.orange).font(.caption)
                Text("red").background(.red).font(.title)
                Text("blue").background(.blue).font(.largeTitle)
                Text("yellow").background(.yellow).font(.callout)
            }
            .border(.gray)


            //混合布局
            HStack{
                ZStack(alignment: .center){
                    Circle()
                        .fill(Color.yellow).frame(width: 100,height: 100)

                    Button(action:{
                        print("button tapped")
                    }){
                        Text("Press Me")
                    }
                }

                VStack(spacing: 10, content: {
                    Text("Text1")
                    Text("Text2")
                })
            }


            //LazyStacka懒加载
            //            scrollView正常情况下会一次性加载VStack里的数据，比如这里的100个item
            //            但是使用lazyVStack后，就只会加载当前页面显示的item
            //            需要注意：lazyVStack必须和scrollView搭配使用，还必须有循环创建，否则无法出现懒加载效果
            ScrollView{
                LazyVStack{
                    ForEach(1...100,id:\.self){
                        Text("Cell \($0)")
                    }
                }
            }.frame(height: 100)
            
            
            
            //Offset相对位置
            //灰色边框是原始位置
            //offset是将视图以及已经添加的修饰符都进行整体偏移，所以把green也偏移了过去
            //而border是在offset后添加的修饰器，所以仍然在文本的原始位置
            //两种方式仅仅在于方式不一样，效果是完全一样的
            VStack{
                
                Text("Offset by passing CGSize()").border(.green).offset(CGSize(width: 20, height: 25)).border(.gray)
                
                Text("Offset by passing horizontal & vertical distance")
                    .border(.green)
                    .offset(x: 20, y: 50)
                    .border(.gray).padding([.bottom],100)
                
                
                
                //绝对位置position
                //position是将视图的中心放置在父视图的特定坐标上。
//                第一个注意的是这里设置的位置是视图的中心位置
//                第二个需要注意的是放置到了父视图的特定坐标上，所以position后设置的颜色充满整个父视图
                Text("Position by passing a CGPoint()")
                    .background(Color.blue)
                    .position(CGPoint(x: 175, y: 100))
                    .background(Color.green).frame(height: 200)
                    
                Text("Position by passing the x and y coordinates")
                    .background(.red)
                    .position(CGPoint(x: 175, y: 100))
                    .background(.green).frame(height: 200)
            }
            
            
        }

    }
    
    
    
}


struct StudyStacks_Previews: PreviewProvider {
    static var previews: some View {
        StudyStacks()
    }
}
