//
//  18_tabview.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/21.
//



import Foundation
import SwiftUI
struct Person: Identifiable {
    let givenName: String
    let familyName: String
    let emailAddress: String
    let id = UUID()
}

///定义一个全局环境变量
final class TabBarIndexObserved : ObservableObject{
    @Published
    var tabSelectd:TabBarItem = .Home
}

enum TabBarItem: Int {
    case Home
    case Living
    case Message
    case Mine
    
    var titleStr:String{
        switch self{
        case .Home:
            return "首页"
        case .Living:
            return "直播"
        case .Message:
            return "消息"
        case .Mine:
            return "我的"
        }
    }
    
    var normalImage:Image{
        var image = ""
        switch self{
        case .Home:
            image = ""
        case .Living:
            image=""
        case .Message:
            image=""
        case .Mine:
            image = ""
        }
        image = "person"
        return Image(systemName:image)
    }
    
    
    var selectImage:Image{
        var image = ""
        switch self{
        case .Home:
            image = ""
        case .Living:
            image=""
        case .Message:
            image=""
        case .Mine:
            image = ""
        }
        image = "person"
        return Image(systemName: image)
    }
    
}


     private struct Purchase: Identifiable {
         let price: Decimal
         let id = UUID()
     }

struct HomePageView : View{
    
    private var people = [
        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
    ]
    
    private let currencyStyle = Decimal.FormatStyle.Currency(code:"USD")
    
    
    //设置定时器 每2s运行一次 mode为 common 在主线程执行 autoconnect 立即开始定时器
     let timer = Timer.publish(every: 2, tolerance: 0.5, on: .main, in: .common).autoconnect()
      
     @State private var bannerIndex = 0
    
    
    var body: some View{
        
        VStack{
//            Table(people) {
//                TableColumn("Given Name", value: \.givenName)
//                TableColumn("Family Name", value: \.familyName)
//                TableColumn("E-Mail Address", value: \.emailAddress)
//            }
            
            if #available(iOS 15.0, *) {
                TabView(selection: $bannerIndex){
                    Image("test1").resizable().scaledToFit().tag(0)
                    Image("test2").resizable().scaledToFit().tag(1)
                    Image("test1").resizable().scaledToFit().tag(2)
                    Image("test2").resizable().scaledToFit().tag(3)
                }
                .background(Color(red: 0.5, green: 0.9, blue: 0.3, opacity: 0.3))
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onReceive(timer){ time in
                    self.bannerIndex += 1
                    if self.bannerIndex > 3{
                        self.bannerIndex = 0
                    }
                }
                .onAppear{
                     
                }.onDisappear{
                    self.timer.upstream.connect().cancel()
                }
            }
            
            Table(of: Purchase.self) {
                TableColumn("Base price") { purchase in
                    Text(purchase.price, format: currencyStyle)
                }
                TableColumn("With 15% tip") { purchase in
                    Text(purchase.price * 1.15, format: currencyStyle)
                }
                TableColumn("With 20% tip") { purchase in
                    Text(purchase.price * 1.2, format: currencyStyle)
                }
                TableColumn("With 25% tip") { purchase in
                    Text(purchase.price * 1.25, format: currencyStyle)
                }
            } rows: {
                TableRow(Purchase(price:20))
                TableRow(Purchase(price:50))
                TableRow(Purchase(price:75))
            }

        }
        
    }
}


struct LivingPageView : View{
    var body: some View{
        Text("直播内容")
    }
}


struct MessagePageView : View{
    var body: some View{
        Text("消息内容")
    }
}

struct MinePageView : View{
    var body: some View{
        Text("我的内容")
    }
}


struct StudyTabView : View {
    @State private var selectIndex : Int = 0
    
    @EnvironmentObject
    private var tabbarIndex : TabBarIndexObserved
    
    private var selectTab:Binding<Int>{
        Binding(get: {
            tabbarIndex.tabSelectd.rawValue
        }, set: {
            tabbarIndex.tabSelectd = TabBarItem(rawValue: $0)!
        })
    }

    
    var body: some View {
        
        
        //TabView
        //        TabView(selection: $selectIndex) {
        //            Text("Tab Content 1").tabItem {
        //                Image(systemName: "person")
        //                Text("首页")
        //            }.onTapGesture(perform: {
        //                selectIndex = 0
        //            }).badge(Text("2"))
        //
        //            Text("Tab Content 2").tabItem {
        //                Image(systemName: "person")
        //                Text("其他")
        //            }.onTapGesture {
        //                selectIndex = 1
        //            }
        //        }
        
        
        TabView(selection: selectTab){
            HomePageView().tabItem{
                tabItem(for: .Home)
            }.tag(TabBarItem.Home.rawValue).badge(99)
            
            LivingPageView().tabItem{
                tabItem(for: .Living)
            }.tag(TabBarItem.Living.rawValue)
            
            MessagePageView().tabItem{
                tabItem(for: .Message)
            }.tag(TabBarItem.Message.rawValue)
            
            MinePageView().tabItem{
                tabItem(for: .Mine)
            }.tag(TabBarItem.Mine.rawValue)
        } .font(.headline)
            .accentColor(.red) // 设置 tab bar 选中颜色
        
    }
    
    
    private func tabItem(for tab:TabBarItem)-> some View{
        print(tab.rawValue)
        return VStack{
            tab.rawValue == selectTab.wrappedValue ? tab.selectImage : tab.normalImage
            Text(tab.titleStr)
        }
    }
    
}

struct StudyTabView_Previews: PreviewProvider {
    static var previews: some View {
        StudyTabView().environmentObject(TabBarIndexObserved())
    }
}
