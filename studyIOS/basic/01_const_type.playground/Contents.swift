import UIKit

var greeting = "Hello, playground"

let dictionary: Dictionary = ["age":"18","name":"wy"]//类型要注意匹配
dictionary["age"]
dictionary["name"]

//元组
//在Swift中有元组概念，元组主要是为了在特殊情况下得到的对象有不用的数据类型的成员的场景使用
/*
 元组的创建
 */
//直接赋值
let http404Error = (404,"Not Found")
//带有标识符
let http202Status = (statusCode:200,desciption:"OK")

//元组可以存储不同数据类型的成员
//存储的元素可以直接存储成员，也可以带有标识符用以获取
//一旦声明，可以改值，但不能添加/删除元素
//不能更改已经声明的元素名称
//已声明的名称可以省略，但未声明名称的元组，不可添加名称：


/*
 元组的使用
 */
//用下标来获取
print("The status code is \(http404Error.1)")
//用标识符来获取
print("The status code is \(http202Status.statusCode)")
//直接统一赋值给多个变量
let (statusCode,statusMessage) = http404Error
let (justTheStatusCode,_) = http202Status
let (statusCode2, statusMessage2): (Int, String) =  http404Error//正确
print("============元组============")
print(statusCode,statusMessage)
print(justTheStatusCode)
print(statusCode2,statusMessage2)
print("============元组============")

//获取有两种方式，一种是直接通过下标获取，一种是通过标识符来获取
//也可以直接赋值给两个变量/常量
//取值时可以指定类型，加强类型判断
//不想处理的值，可以用下划线_代替

//和结构体的区别：
//结构体可以存储函数，元组不可以
//结构体只能直接存储成员，元组可以存储带有标识符的成员

/// 求和【概述】
///
/// 将两个整数相加【更详细的描述】
/// - Parameters:
///   - v1: v1 第一个整数
///   - v2: v2 第二个证书
/// - Returns: 2个整数的和
///
/// - Note : 传入2个证书即可【批注】
func sum(v1: Int,v2: Int) -> Int {
    v1 + v2
}

print(sum(v1:1,v2:1))


//print函数的认识
//public func print(_ items: Any..., separator: String = " ", terminator: String = "\n")
//第一个参数items是可变参数，因此它可以是0个或多个参数，
//第二个参数separator是参数中间的分割字符，默认是" "
//第三个参数terminator是字符串末尾的字符，默认是"\n"，换行
let ss = "swift"
print("快乐","学习","\(ss)语言", separator: "-", terminator: "~啦啦")


