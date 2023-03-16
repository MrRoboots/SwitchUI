//
//  idle_fish_ui.swift
//  studyIOS
//
//  Created by YunXing on 2023/2/23.
//

import Foundation
import SwiftUI


let screeWidth = UIScreen.main.bounds.width
let screeHeight = UIScreen.main.bounds.height

let array = ["关注", "推荐", "西安"]
let array1 = [["精品手机":"一年质保"], ["奢品捡漏":"低价保真"], ["潮鞋潮服":"正品尖货"], ["折扣美妆":"低至 9.9"]]
let array2 = [["省心卖":"高价回收"], ["闲鱼潮社":"1元起拍"], ["校园圈":"学生专属"], ["低价卡券":"火锅69折"], ["3C数码":"热门榜单"], ["仓库特卖":"大牌捡漏"]]
let array3 = ["推荐", "手机", "箱包", "盲盒", "手办", "双十一转卖", "童裝"]
let array4 = [["title": "100多台24寸 27寸显示器 ips 电竞曲面直面", "price": "150", "want": "799", "create": "可爱的猫咪"], ["title": "【顺丰包邮】门缝门底密封条房门缝隙隔音降噪", "price": "2.60", "want": "1686", "create": "亮片喜欢"], ["title": "扬盈轻奢超薄翻斗鞋柜17cm窄家用门口省空间", "price": "1550", "want": "220", "create": "扬盈旗舰店"], ["title": "家里安监控买多了，剩下几个摄像头，4G版的", "price": "189", "want": "75", "create": "大妞小妞嘻嘻嘻"], ["title": "SwiftUI实战班全套课程，强烈推荐！", "price": "199", "want": "15", "create": "子松"]]
let array5 = ["蜜柚香甜", "小江睡不着", "手工设计", "晚风中的蝉鸣", "赛博朋克", "中国万岁", "Jackson"]
let array6 = [["title": "找人帮忙", "subTitle": "持证服务更靠谱"], ["title": "找份兼职", "subTitle": "薪资担保岗位真"], ["title": "附近回收", "subTitle": "免费上门更省心"]]
let array7 = [Color.green, Color.orange, Color.red]
let array8 = ["整租", "合租", "千元房", "全部"]
let array9 = ["闲鱼小站", "低价卡券", "民宿短租", "搬家拉货", "演出票务", "同城跑腿"]
let colors = [Color.red, Color.purple, Color.red, Color.orange, Color.teal, Color.brown]

enum FishBarItem:Int{
    
    case Home
    case Play
    case Message
    case Mine
    
    var title : String{
        switch self {
        case .Home:
            return "闲鱼"
        case .Play:
            return "会玩"
        case .Message:
            return "消息"
        case .Mine:
            return "我的"
        }
    }
    
    var selectIcon : Image{
        var img : String = ""
        switch self{
        case .Home:
            img = "tab1_select"
        case .Play:
            img = "tab2_select"
        case .Message:
            img = "tab4_select"
        case .Mine:
            img = "tab5_select"
        }
        return Image(img)
    }
    
    var normalIcon : Image{
        var img : String = ""
        switch self{
        case .Home:
            img = "tab1_normal"
        case .Play:
            img = "tab2_normal"
        case .Message:
            img = "tab4_normal"
        case .Mine:
            img = "tab5_normal"
        }
        return Image(img)
    }
}


///定义一个全局环境变量
final class FishTabBarIndexObserved : ObservableObject{
    @Published
    var tabSelectd:FishBarItem = .Home
}


struct IdleFishUI:View{
    
    @State var tabSwitch = 1
    
    @State var searchText:String = ""
    
    @EnvironmentObject
    private var tabbarObs : FishTabBarIndexObserved
    
    private var selectTabs : Binding<Int>{
        Binding(get: {
            tabbarObs.tabSelectd.rawValue
        }, set: {
            tabbarObs.tabSelectd = FishBarItem(rawValue: $0)!
        })
    }
    
    
    var body: some View{
        TabView(selection: selectTabs){
            HomePage(tabSwitch: $tabSwitch, searchText:$searchText)
                .ignoresSafeArea().padding().tabItem{
                    tabItem(for: .Home)
                }.tag(FishBarItem.Home.rawValue)//不同的TabView视图设置不同的标签
            
            
            PlayPage().tabItem{
                tabItem(for: .Play)
            }.tag(FishBarItem.Play.rawValue)
            
            
            VStack{
                Text("h哈哈哈")
            }.tabItem {
                Label("", systemImage: "plus.circle.fill")//plus.circle
            }.tag(5)
            
            MessagePage()
                .tabItem{
                    tabItem(for: .Message)
                }.tag(FishBarItem.Message.rawValue)
            
            MinePage().tabItem{
                tabItem(for: .Mine)
            }.tag(FishBarItem.Mine.rawValue)
            
        }.accentColor(.black).font(Font.system(size: 16))
    }
    
    func tabItem(for tab:FishBarItem) -> some View{
        return VStack{
            tab.rawValue == selectTabs.wrappedValue ? tab.selectIcon : tab.normalIcon
            Text(tab.title)
        }
    }
    
}


struct MessagePage : View{
    var body: some View{
        Text("消息")
    }
}

struct MinePage : View{
    var body: some View{
        Text("我的")
    }
}

struct PlayPage : View{
    var body: some View{
        Text("会玩")
    }
}


struct HomePage:View{
    @Binding var tabSwitch:Int
    @Binding var searchText:String
    
    var body: some View{
        VStack{
            //标题
            HStack{
                Image(uiImage: UIImage.init(named: "signIn")!)
                Spacer()//设置距离
                ForEach(array.indices,id: \.self){ i in
                    Button{
                        withAnimation{
                            tabSwitch = i
                        }
                    }label: {
                        Text(array[i])
                    }.foregroundColor(i == tabSwitch ? .black : .gray).padding(5).font(Font.system(size: 20,weight: tabSwitch==i ? .bold : .regular))
                }
                
                Spacer()
                Image(uiImage: UIImage.init(named: "live")!)
            }.padding(EdgeInsets.init(top: 36, leading: 0, bottom: 0, trailing: 0))
            
            //搜索
            HStack{
                Button{
                    print("search")
                }label: {
                    Button{
                        print("scan")
                    }label: {
                        Image(uiImage: UIImage.init(named: "scan")!)
                    }.padding([.leading],10)
                    Text("").frame(width: 0.5,height: 18).background(.gray.opacity(0.5))
                    TextField("搜索宝贝/鱼塘/用户",text:$searchText).foregroundColor(.gray).multilineTextAlignment(.leading)
                    Spacer()
                    Text("搜索").foregroundColor(.black.opacity(0.6)).padding(EdgeInsets.init(top: 10, leading: 14, bottom: 10, trailing: 14)).background(.yellow).cornerRadius(20)
                }.overlay{
                    RoundedRectangle(cornerRadius: 20).stroke(.yellow,lineWidth: 3)
                }
                Image(uiImage: UIImage.init(named: "classes")!)
            }
            
            //内容
            TabView(selection:$tabSwitch ){
                attentionView().tag(0)
                recommendView().tag(1)
                localityView().tag(2)
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)).ignoresSafeArea()
        }
    }
}




//关注
struct attentionView:View{
    var body: some View{
        
        VStack(spacing: 16){
            HStack{
                Text("常访问的人").font(.footnote).foregroundColor(.gray)
                Spacer()
            }
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(array5,id:\.self){str in
                        VStack{
                            Image("userHead").resizable().frame(width: 44,height: 44)
                            Text(str).foregroundColor(.gray).font(.callout).lineLimit(1)
                        }.frame(width:70)
                    }
                }
            }
            
            ScrollView{
                ForEach(array4,id:\.self){dic in
                    VStack(alignment: .leading){
                        HStack{
                            Image("userHead").resizable().frame(width:32,height: 32)
                            VStack(alignment: .leading) {
                                Text(dic["create"]!)//字典获取的是可选项。易理解
                                Text("1小时前发布").foregroundColor(.gray).font(.footnote)
                            }
                            Spacer()
                            Text("¥"+dic["price"]!).bold().foregroundColor(.red)
                        }
                        
                        Text("\t\t \(dic["title"]!)").overlay(Text("今日上新").padding(2).background(.green).foregroundColor(.white).font(.footnote).cornerRadius(4),alignment: .topLeading)
                        
                        
                        Image("logicImg").resizable().cornerRadius(10).scaledToFit()
                        
                        Spacer(minLength: 15)
                        Divider()
                        Spacer(minLength: 15)
                    }
                }
            }
        }
        
    }
}


struct recommendView:View{
    @State var typeSwitch = 0
    var body: some View{
        ScrollView(showsIndicators:false){
            Spacer(minLength: 8)//距离顶部距离为8
            VStack{
                HStack{
                    Text("闲鱼优品").font(.title2).bold()
                    Text("验货包真｜全国包邮｜品质包退").padding(3).background(.orange.opacity(0.3)).cornerRadius(8).font(.footnote).lineLimit(1)
                    Spacer()
                    Button("更多 >"){
                    }.foregroundColor(.gray).font(.caption).padding(EdgeInsets.init(top: 8, leading: 10, bottom: 8, trailing: 10)).background(.white).cornerRadius(16)
                }
                
                HStack{
                    ForEach(array1,id: \.self){dic in
                        VStack{
                            Image("img\(array1.firstIndex(of: dic)!+1)").resizable().frame(width: 76,height: 76).cornerRadius(50)
                            Text(dic.keys.first!).bold()
                            Text(dic.values.first!).foregroundColor(.gray).font(Font.system(size: 15,weight: .regular))
                        }
                        if array1.firstIndex(of: dic)! != array1.count-1{Spacer().foregroundColor(.red)}
                    }
                }
            }.padding(10).background(.gray.opacity(0.05)).cornerRadius(20)
            
            Spacer(minLength: 14)
            LazyVGrid(columns: [
                //设置三列
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 24) {
                ForEach(array2,id:\.self){dic in
                    HStack(spacing:0){
                        VStack(alignment:.leading,spacing: 3){
                            Text(dic.keys.first!).bold()
                            Text(dic.values.first!).foregroundColor(colors[array2.firstIndex(of: dic)!]).font(Font.system(size: 15,weight: .regular))
                        }
                        Image("img\(array2.firstIndex(of: dic)!+5)")
                    }
                }
            }.padding(10).background(.gray.opacity(0.05)).cornerRadius(20)
            
            
            //水平滚动显示多选项，很明显是水平布局
            ScrollView(.horizontal, showsIndicators: false) {
                //布局方式为水平
                VStack(alignment: .weirdAlignment, spacing: 0) {
                    HStack(spacing: 16) {
                        ForEach(array3.indices, id: \.self) { i in
                            //如果在不同的场景下会有多种不同样式的显示，可以使用Group进行包装
                            Group {
                                //选中项，显示为文本，不再点击
                                if i == typeSwitch {
                                    Text(array3[i]).foregroundColor(.black).font(Font.system(size: 21, weight: .bold)).alignmentGuide(.weirdAlignment, computeValue: { d in d[HorizontalAlignment.center] }).transition(AnyTransition.identity)
                                    //没有选中，设置为按钮，并且使用默认动画来更改
                                } else {
                                    Button(array3[i]){
                                        withAnimation{
                                            typeSwitch = i
                                        }
                                    }.foregroundColor(.gray).font(Font.system(size:18,weight: .regular)).transition(AnyTransition.identity)
                                }
                            }
                        }
                    }.padding(EdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
                    Image("lineIcon").alignmentGuide(.weirdAlignment, computeValue:{
                        d in d[HorizontalAlignment.center]
                    }).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 4, trailing: 0))
                    
                }
            }
            
            ScrollView{
                LazyVGrid(columns:[    GridItem(.flexible()),
                                       GridItem(.flexible()),],spacing: 24){
                    ForEach(array4,id:\.self){dic in
                        VStack(spacing: 8){
                            Image("logicImg").frame(width:screeWidth/2-8*3).clipped().cornerRadius(10)
                            Text(dic["title"]!).bold().lineLimit(2)
                            HStack{
                                Text("¥\(dic["price"]!)").bold().foregroundColor(.red)
                                Spacer()
                                Text(dic["want"]!+"人想要").foregroundColor(.gray).font(.footnote)
                            }
                            
                            HStack(spacing:3){
                                Image("userHead")
                                Text(dic["create"]!).foregroundColor(.gray).font(.footnote).lineLimit(1)
                                Spacer()
                                Label{
                                    Text("芝麻信用极好").foregroundColor(.blue).font(.caption).offset(x: -3, y: 0)
                                }icon:{
                                    Image("zhima").offset(x: 3, y: 0)
                                }.padding(EdgeInsets.init(top: 1, leading: 0, bottom: 1, trailing: 0)).overlay(
                                    RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.5)).layoutPriority(1)
                            }
                        }
                    }
                }
            }
            
            Spacer(minLength: 20)
        }
    }
}


struct localityView:View{
    var body: some View{
        ScrollView{
            
            HStack{
                ForEach(array6.indices,id:\.self){i in
                    VStack{
                        HStack{
                            VStack(alignment:.leading,spacing: 4){
                                Text(array6[i]["title"]!).fontWeight(.medium)
                                Text(array6[i]["subTitle"]!).foregroundColor(array7[i]).font(.footnote)
                            }
                            Spacer()
                        }.padding(10)
                    }.frame(height:120,alignment: .top).background(array7[i].opacity(0.05)).cornerRadius(6)
                }
            }
            
            
            //2. 出租信息
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("好房出租").fontWeight(.medium)
                        Text("真实房东 免中介费").foregroundColor(.blue).font(.footnote)
                        Spacer()
                    }
                    HStack(spacing: 20) {
                        ForEach(array8, id: \.self) { str in
                            VStack(spacing: 4) {
                                Image(uiImage: UIImage.init(named: "userHead")!).resizable().frame(width: 36, height: 36)
                                Text(str).font(.footnote)
                            }
                        }
                    }
                }
                Button {
                    print("detail")
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("人民大会堂")
                            Spacer()
                            Text(">")
                        }
                        HStack(spacing: 0) {
                            Text("23").foregroundColor(.blue)
                            Text("套房源").foregroundColor(.gray)
                        }
                    }
                }.padding(8).background(.white).cornerRadius(30).frame(width: 130)
                
            }.padding(10).background(.blue.opacity(0.05)).cornerRadius(6)
            
            //3. 详细显示
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(array9, id: \.self) { str in
                        VStack(spacing: 4) {
                            Image(uiImage: UIImage.init(named: "img\(array9.firstIndex(of: str)!+5)")!).frame(width: 44).cornerRadius(6)
                            Text(str).font(.footnote).fontWeight(.medium)
                        }
                    }
                }
            }
            
        }
    }
}


//自定义一个水平布局方式
extension HorizontalAlignment {
    //新建一个枚举WeirdAlignment
    private enum WeirdAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return 0
        }
    }
    //定义(水平布局)
    static let weirdAlignment = HorizontalAlignment(WeirdAlignment.self)
}

struct IdleFishUI_Previews: PreviewProvider {
    static var previews: some View {
        IdleFishUI().environmentObject(FishTabBarIndexObserved())
    }
}
