import Cocoa

var greeting = "Hello, playground"

//主要内容：
//枚举的简单使用
//枚举的内存计算
//可选项的简单使用

//1、定义一个枚举类型
enum Dir1 : String{
    case north
    case south
    case east
    case west
}

//2、简写
enum Dir2{
    case north,south,east,west
}

//3、使用
let north = Dir1.north.rawValue
print("wy:\(north)")//wy:north


//注意书写方式，enum表示枚举
//每一项可以用case来表示
//也可以简写，只写一个case，后面的成员用,隔开
//可以确定类型，也可以不确定
//可以直接获取每个成员的值

//关联值
//有时将枚举的成员值跟其他类型的值关联存储在一起，需要让成员值来标识关联值是哪一个成员
//关联值
enum Date {
    case digit(year: Int,month: Int,day: Int)
    case string(String)
}

//可以给枚举成员赋值
var date = Date.digit(year: 2022, month: 2, day: 10)
//此处date的枚举类型已经确定，所以可以直接使用.string()，而不需要加上Date进行说明
date = .string("2022-02-10")

/*
 1、此处通过传入的date得知枚举类型，所以在判断时可以直接使用.digit()/.string()
 2、在switch判断时，可以获取到其中的关联值进行使用
 */
switch date {
case .digit(let year,let month,let day):
    print(year,month,day)
case let .string(value):
    print(value)
}


//原始值
//枚举成员可以使用相同类型的默认值预先对应，这个默认值叫做原始值，也就是这个成员所对应的值不会被外界赋值。
//1、原始值：定义时赋值
enum Grade : String {
    case perfect = "A"
    case great = "B"
    case good = "C"
    case bad = "D"
}
print(Grade.perfect.rawValue)//A

//如果是数值类型，默认是有顺序的数值
enum Season : Int {
    case spring = 1 ,summer, autumn = 4, winter
}
print(Season.summer.rawValue)//2

//此处是在定义时赋一个原始值，以后在外界使用时就一直是这个原始值，而且外界无法更改
//在获取原始值需要使用rawValue
//如果是字符串，则原始值为字符串成员本身
//如果是数值，则按顺序递增，并且第一个成员为0

//隐式原始值
//2、原始值：隐式原始值
//如果是字符串类型，则默认值是其本身
enum Dir3 : String{
    case north
    case south
    case east
    case west
}

//等价于
enum Dir4 : String{
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
}

print(Dir3.north.rawValue)

//如果没有在定义时赋原始值，也是有默认原始值的
//如果值是字符串类型，这个默认原始值就是其成员的字符串本身
//如果值是Int类型，这个默认原始值就是数值
//注意：
//原始值当不显式赋值时，会有其默认原始值


//递归枚举
//递归枚举，声明到enum前
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr,ArithExpr)
    case difference(ArithExpr,ArithExpr)
}

//递归枚举，声明到case前
//enum ArithExpr {
//    case number(Int)
//    indirect case sum(ArithExpr,ArithExpr)
//    indirect case difference(ArithExpr,ArithExpr)
//}

//定义枚举变量，可以直接通过number来定义，也可以通过sum/difference递归定义
let ten = ArithExpr.number(10)
let five = ArithExpr.number(5)
let sum = ArithExpr.sum(ten, five)
let difference = ArithExpr.difference(ten, five)

//取出枚举变量中的数据进行加减运算
//需要注意的是：如果传入sum/difference需要递归取出number值
func calculate(_ expr: ArithExpr) -> Int {
    switch expr {
    case let .number(value):
        return value
    case let .sum(left, right):
        return calculate(left) + calculate(right)
    case let .difference(left, right):
        return calculate(left) - calculate(right)
    }
}

calculate(ten)//10
calculate(five)//5
calculate(sum)//15
calculate(difference)//5

//在ArithExpr枚举中的sum和difference中关联值也是ArithExpr枚举，这就是递归枚举
//在枚举前加上indirect就表示该枚举可以被成员递归使用
//也可以简写成第二种方式，只在需要使用递归枚举的成员前加上indirect
//在下面的使用中就可以看到使用sum时直接传入了five和four两个枚举
//之后在使用时，可以获取到number中的具体值来计算。
//在calculate中也需要递归取出number值才能计算。

//枚举内存大小
//原始值和枚举值计算大小的方式是不一样的。
//enum Dir1 : String{
//    case north
//    case south
//    case east
//    case west
//}

MemoryLayout<Dir1>.stride//分配空间大小
MemoryLayout<Dir1>.size//实际占用空间大小

//枚举中所有原始值占用的内存大小是1
//这是因为原始值都是通过序号来存储的，并没有具体值存储在枚举中，枚举中仅存储有序号


//关联值内存计算
MemoryLayout.stride(ofValue: date)//分配空间大小
MemoryLayout.size(ofValue: date)//实际占用空间大小

//枚举中关联值占用的内存大小是数据类型的大小加上一个字节
//关联值是直接存储在枚举中的，因此需要加上成员的数据类型的大小
//并且还有序号来关联这个关联值。因此还必须加上一个字节
//此处digit占有24个字节，string占有8个字节，但因为他们是互斥关系，所以选用最大的24个字节。
//枚举必须有一个字节用来存储成员的序号，因此是24+1= 25个字节
//而通过内存对齐，需要分配32个字节

//枚举内存计算
enum Password {
    case number(Int,Int,Int,Int)
    case other
}

MemoryLayout<Password>.stride//分配空间大小
MemoryLayout<Password>.size//实际占用空间大小
MemoryLayout<Password>.alignment//对齐参数

//关联值存储在枚举中，会占用枚举变量的内存，原始值不占用枚举变量的内存
//枚举必须有一个字节用来存储枚举成员的序号
//枚举的关联值占用内存大小选用最大成员的内存大小
//分配空间大小是8字节对齐

//可选项
//可选项,也叫可选类型，可选项的目的就是允许将值设置为nil，因此如果想要获取或判断的值可能包含nil，那么它就应该用可选项来处理。
//在类型的后面加上？就可以设置为可选类型。
//1、可选项的认识
var name: String? = "wy"
//可选项可以设置为nil
name = nil

//2、可选项如果没有赋初始值，则说明是nil
var age: Int?
age = 10
age = nil

//可选类型的数据可以设置为nil
//正常情况下数据类型是没有默认值的，在使用前必须要赋值
//而如果设置为可选项，就有默认值，默认值就是nil
//理解：
//可选项可以理解为是一个盒子，如果赋值，里面就装有一个数据，强制解包就是获取盒子内的数据。当然此时盒子内仍然有数据
//如果不为nil，那么盒子里装的是：被包装类型的数据
//如果为nil，那么它是个空盒子

//强制解包
//强制解包就是将可选项的变量所包含的数据取出来

//3、强制解包取出盒子中的数据(通过!来强制解包)
var ages: Int? = 10
var ageInt: Int = ages!
ageInt += 10


//可选项绑定 正常使用方式
/*
 正常判断方式
 1、number为可选项，因此可以判断是否为nil
 2、在获取数据时需要强制解包
 */
let number = Int("123")
if number != nil {
    print("wy:字符串转换整数成功：\(number!)")
} else {
    print("wy:字符串转换中整数失败")
}

//可选项绑定方式
/*
 1、可以直接在判断条件中获取可选项
 2、特别要注意的是，此时会自动解包，因此直接使用number,而无需强制解包
 */
if let number = Int("123") {
    print("wy:字符串转换整数成功：\(number)")
} else {
    print("wy:字符串转换中整数失败")
}


if let first = Int("4"),
   let second = Int("42"),
   first < second && second < 100 {
    print("\(first) < \(second) < 100")
}

//等价于：
if let first = Int("4"){
    if let second = Int("42") {
        if first < second && second < 100 {
            print("\(first) < \(second) < 100")
        }
    }
}


//空合并运算符
//合并方式：
//a ?? b
//
//a 是可选项
//b 是可选项 或者 不是可选项
//b 跟 a 的存储类型必须相同
//如果 a 不为nil，就返回 a
//如果 a 为nil，就返回 b
//如果 b 不是可选项，返回 a 时会自动解包

//5、空合并运算符
//a和b都是可选项
//let a: Int? = 1
//let b: Int? = 2
//let c = a ?? b
//print(c)//Optional(1)

//a和b都是可选项，a是nil
//let a: Int? = nil
//let b: Int? = 2
//let c = a ?? b
//print(c)//Optional(2)

//a和b都是可选项，a和b都是nil
//let a: Int? = nil
//let b: Int? = nil
//let c = a ?? b
//print(c)//nil

//a是可选项，b不是可选项
//let a: Int? = 1
//let b: Int = 2
//let c = a ?? b
//print(c)//1

//a是可选项，b不是可选项，且a是nil
//let a: Int? = nil
//let b: Int = 2
//let c = a ?? b
//print(c)//2


//隐式解包
//可以直接使用!实现隐式解包
//6、隐式解包，num1既可以当做直接数，也可以当做可选项判断是否为nil
let num1: Int! = 10
let num2: Int = num1
if num1 != nil {
    print(num1+6)
}

//多重可选项
//可选项可以嵌套使用
//7、多重可选项
var num1: Int? = 10
var num2: Int?? = num1
var num3: Int??? = 10

//如果是nil，则不管几层包装都是空盒子

//字符串插值
//可选项在字符串插值或直接打印时，编译期会发出警告
//8、字符串插值
var wyAge: Int? = 10
print("My age is \(wyAge!)")
print("My age is \(String(describing: wyAge))")
print("My age is \(wyAge ?? 0)")

