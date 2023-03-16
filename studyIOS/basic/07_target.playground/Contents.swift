import UIKit
import SwiftUI

var greeting = "Hello, playground"

//对于属性，Swift更具体的划分了存储属性和计算属性，并且可以更方便的为存储属性增加属性观察器。对于初始化器，需要着重理解Swift为实例的安全使用所进行的规范化，设定了两段式初始化和安全检查来确保初始化过程的安全，只有初始化完成后才可以进行实例的使用。方法的定义和实现没有特殊性。只不过Swift显式的增加了下标函数，可以更方便的操作存储属性
//主要内容：
//属性
//初始化器
//方法
//下标

//属性
//Swift中的属性包括实例属性和类型属性，又分为存储属性和计算属性。存储属性可以类比OC的成员变量，计算属性可以类比OC的属性，但是它并没有成员变量
//存储属性
//存储属性相当于是OC的实例变量，没有setter和getter，它直接存储在实例的内存中，结构体、类可以定义实例存储属性，枚举不可以定义。
/*
 1、存储属性和计算属性
 */
func test1() {
    struct Circle {
        //存储属性
        var radius: Double
        //计算属性
        var diameter: Double {
            set {
                radius = newValue / 2
            }
            get {
                radius * 2
            }
        }
    }
    let circle = Circle(radius: 5)
    print(circle.radius)
    print(circle.diameter)
}
test1()

//延迟存储属性
//延迟存储属性lazy Stored Property，使用lazy修饰，在第一次使用属性的时候才会进行初始化
/*
 2、延迟存储属性
 */
//func test2() {
//    class PhotoView {
//        //这是一个存储属性，直接将闭包表达式结果赋值Image
//        lazy var image : Image = {
//            let url = "https://image.baidu.com/xx.png"
//            return Image(url)
//        }()
//    }
//}


//属性观察器
//监听属性的修改
/*
 3、属性观察器
 */
func test3() {
    struct Circle {
        var radius: Double {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, radius)
            }
        }
        init() {
            self.radius = 1.0//不会触发观察器
            print("Circle init!")
        }
    }
    // Circle init!
    //willSet 2.0
    //didSet 1.0 2.0
    var cicle = Circle()
    cicle.radius = 2.0
}
test3()


//观察器有两个方法，一个是willSet，一个是didSet
//分别是在属性将要修改、属性修改完成的时候执行
//willSet会传递新值，默认叫newValue
//didSet会传递旧值，默认叫做oldValue
//在初始化器中和属性定义时设置不会触发观察(这个也容易理解，这个没有观察的意义)
//willSet和didSet方法其实是包含在setter方法中的

//计算属性
//计算属性就相当于OC的属性，有getter方法就决定了是计算属性，它作为函数，不占用实例的内存，枚举、结构体、类都可以定义计算属性
//计算属性和存储属性的区别
struct Circle {
    //存储属性
    var radius: Double
    //计算属性
    var diameter: Double {
        set {
            radius = newValue / 2
        }
        get {
            radius * 2
        }
    }
}
    
let circle = Circle(radius: 5)
print(circle.radius)
print(circle.diameter)
    
//只读计算属性
struct Circle2 {
    //存储属性
    var radius: Double
    //计算属性
    var diameter: Double {
        get {
            radius * 2
        }
    }
}
    
//简写
struct Circle3 {
    //存储属性
    var radius: Double
    //计算属性
    var diameter: Double { radius * 2 }
}


//枚举的rawValue的本质就是只读计算属性
enum TestEnum: Int {
    case test1 = 1, test2 = 2, test3 = 3
    var rawValue: Int {
        switch self {
        case .test1:
            return 10
        case .test2:
            return 11
        case .test3:
            return 12
            //条件全部保证，就不需要增加default
            //            default:
            //                <#code#>
            //            }
        }
    }
}
print(TestEnum.test3.rawValue)//12


//inout对于属性的传递
//属性作为inout修饰的参数传递，他们的传递方式和普通的变量有一定的不同

