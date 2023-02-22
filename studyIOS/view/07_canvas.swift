//
//  07_canvas.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//

import Foundation
import SwiftUI


//Canvas就是一个画布。我们可以对画布进行绘制丰富和动态的2D图形
//Canvas将GraphicsContext传递给用于执行即时模式绘图操作的闭包
//通过闭包进行绘制，传入两个参数，一个是绘制的内容，一个是绘制的大小
//Canvas还传递一个CGSize值，您可以使用它来定制您绘制的内容
//使用画布在SwiftUI视图中绘制丰富和动态的2D图形。画布将GraphicsContext传递给用于执行即时模式绘图操作的闭包。画布还传递一个CGSize值，您可以使用它来定制您绘制的内容。例如，你可以使用上下文的stroke(_:with:lineWidth:)命令来绘制一个Path实例:

struct StudyCanvas : View {

    var body: some View {
       
        VStack{
                 Canvas { context, size in
                     context.stroke(
                         Path(ellipseIn: CGRect(origin: .zero, size: size)),
                        with: .color(.green),
                         lineWidth: 4)
                 }
                 .frame(width: 300, height: 200)
                 .border(Color.blue)
        
            
        }

        
    }
}

struct StudyCanvas_Previews: PreviewProvider {
    static var previews: some View {
        StudyCanvas()
    }
}
