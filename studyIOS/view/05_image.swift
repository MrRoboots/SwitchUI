//
//  05_image.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//


import Foundation
import SwiftUI


struct StudyImage : View {
    
    var body: some View {
        
        VStack{
            //直接使用Image就可以拿到图片了，这里只能使用Assets中的图片
            //从assets加载图片
            //resizable 可调整大小 frame设置宽高
            //aspectRatio 设置宽高比
            Image("test1").resizable().frame(width: 100,height: 100).aspectRatio(contentMode: .fit)
            
            
            //如果想要使用文件路径下的图片，需要使用UIImage
            //            UIImage.init(named: "mine_invite.png")
            
            
            //加载网络图片
            //网络图片使用AsyncImage，注意要设置占位图片或占位文字，网络图片有可能会失败
            let tesla = "https://t7.baidu.com/it/u=1595072465,3644073269&fm=193&f=GIF"
            //
            //            AsyncImage(url: URL(string: tesla)) { image in
            //                // 1
            //                image
            //                    .resizable()
            //                    .scaledToFit()
            //            } placeholder: {
            //                ZStack {
            //                    // 2
            //                    Color.gray
            //                    // 3
            //                    VStack(spacing: 20) {
            //                        // 4
            //                        ProgressView()
            //                        // 5
            //                        Text("Loading...")
            //                            .foregroundColor(Color.white)
            //                    }
            //                }
            //            }
            //            // 6
            //            .frame(width: 100, height: 100)
            
            
            AsyncImage(url: URL(string: tesla)) { image in
                image.resizable().scaledToFit()
            }placeholder: {
                ZStack{
                    Color.gray
                    VStack(spacing: 16){
                        ProgressView()
                        Text("Loading...").foregroundColor(Color.white)
                    }
                }
            }.frame(width: 200,height: 200)
            
            
        }.padding()
        
        
        
    }
}

struct StudyImage_Previews: PreviewProvider {
    static var previews: some View {
        StudyImage()
    }
}
