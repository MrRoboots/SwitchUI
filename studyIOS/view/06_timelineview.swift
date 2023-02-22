//
//  06_timelineview.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//


import Foundation
import SwiftUI
//两个参数，一个是计划表，一个是执行的内容
//在这里时间表是从当前时间，每1秒开始执行一次
//执行的内容就是打印当前时间
//因此知道个视图可以做定时器使用
//可以传入三种参数
//.everyMinute 每分钟
//.periodic(from: , by: )从开始时间开始，多久开始更新
//.explicit(更新次数)


struct StudyTimeLineView : View {

    var body: some View {
       
        VStack{
            //TimelineView
            TimelineView(.periodic(from: Date.now, by: 1.0)) {
                context in
                Text(context.date.description).font(.title)
            }
        }.padding()

        
    }
}

struct StudyTimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        StudyTimeLineView()
    }
}
