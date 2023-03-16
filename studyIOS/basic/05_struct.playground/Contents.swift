import UIKit

var greeting = "Hello, playground"


//结构体的初始化器 初始化器实现

/*
 1、结构体的初始化器
 注意：初始化器必须保证所有存储属性都完成初始化
 */
struct Point1 {
    var x: Int = 5
    var y: Int
}

//此时都有值
var p11 = Point1(x: 10, y: 10)
//xYou自己的初始值5
var p12 = Point1(y: 10)
//y没值
//var p3 = Point(x:5)
//x、y都没值
//var p4 = Point()

//本质：初始化器中给存储属性赋初始值
struct WYPoint {
    var x: Int = 0
    var y: Int = 0
}
var p = WYPoint()


//自定义结构体
/*
 2、自定义初始化器
 */
struct Point2 {
    var x : Int = 0
    var y : Int = 0
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
//只有这个初始化器
var p21 = Point2(x: 10, y: 10)
//系统不再提供默认初始化器
//var p22 = Point2(y: 10)
//var p23 = Point2(x:5)
//var p24 = Point2()

//注意初始化器的定义格式
//我们看到如果提供了自定义的初始化器，默认的初始化器系统将不再提供


//结构体内存结构
/*
 3、结构体的内存查看
 */
struct Point3 {
    var x: Int = 0
    var y: Int = 0
    var origin: Bool = false
}
print(MemoryLayout<Point3>.size) // 17
print(MemoryLayout<Point3>.stride) // 24
print(MemoryLayout<Point3>.alignment) // 8


/*
 1、类的初始化器
 */
//没有给存储属性赋值，类的定义会报错
//class Point4 {
//    var x: Int
//    var y: Int
//}
//let p41 = Point4()//报错，没有给存储属性赋初始值

//只有空构造
class Point5 {
    var x: Int = 0
    var y: Int = 0
}
let p51 = Point5()//空构造中赋初始值，不报错
//let p52 = Point5(x: 10,y: 20)//默认没有其他构造器
//let p53 = Point5(x: 10)//默认没有其他构造器
//let p54 = Point2(y: 20)//默认没有其他构造器


//反初始化器
//反初始化器可以理解为析构器

/*
 2、类的反初始化器
 */
class Person {
    var x: Int = 0
    var y: Int = 0
    deinit {
        print("WY:Perosn对象销毁了")
    }
}

func testInit() -> Void {
    var person = Person()
}

testInit()//WY:Perosn对象销毁了

//继承关系中的反初始化器
class Student : Person {
    deinit {
        print("WY:Student对象销毁了")
    }
}
func testInit2() -> Void {
    var student = Student()
}
//WY:Student对象销毁了
//WY:Perosn对象销毁了
testInit2()


//定义方式和析构器一样，只是名字不一样
//所用也是销毁对象
//deinit不接受任何参数，不能写()，没有返回值，不能自行调用，必须系统调用
//父类的deinit能被子类继承,如果子类没有反初始化器，会直接调用父类的反初始化器
//子类的deinit调用完毕后会调用父类的deinit

