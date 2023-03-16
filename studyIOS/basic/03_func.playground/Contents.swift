import UIKit

var greeting = "Hello, playground"

//Swift的函数在定义和调用上都提供了更多的更方便的可操作空间，比如参数标签、可变参数，并且函数类型的使用使得任意的普通函数就有block的特征，接下来认识Swift中函数的使用。

///函数的定义
///参数标签、默认参数、可变参数
///修改外部变量
///函数类型


//不带参数
func pi() -> Double {
    return 3.1415
}
print(pi())

//带参数
/// 求和【概述】
///
/// 将两个整数相加【更详细的描述】
/// - Parameters:
///   - v1: v1 第一个整数
///   - v2: v2 第二个证书
/// - Returns: 2个整数的和
///
/// - Note : 传入2个整数即可【批注】
func sum(v1: Int,v2: Int) -> Int {
    v1 + v2
}
print(sum(v1: 10, v2: 20))

//所有的函数前面都用func来修饰
//函数名()的()里写的是参数，这里是虚参，也就是参数名称
//函数的参数默认是常量，而且只能是常量
//返回值是写在参数的后面，并且使用->隔开,sum函数返回的是Int类型
//在调用时也需要加上参数名称，这样传值会更准确
//在sum函数中我写了文档注释，这样便于后续维护，而且在调用函数时可以更加明确函数的职责
//因为是单一的表达式，所以无需写return，编译期会自动判断

//若没有返回值有三种写法
//返回Void，Void其实就是()，Void是()空元祖的别名(注意Void的V是大写，跟其他语言不一样）
//返回()，也就是直接返回空元组
//也可以不写返回值就表示没有返回值
//如果整个函数体只是简单的单一表达式，可以不写return来返回，编译器会自动帮我们增加return
//形参默认是let，也只能是let，所以以后就不要写就行了

print("===============返回元组")
func calculate(v1: Int,v2: Int) -> (sum: Int,diffence: Int,average: Int) {
    let sum = v1+v2
    return(sum,v1-v2,sum>>1)
}

let result = calculate(v1: 20, v2: 10)
result.sum
result.diffence
result.average
result.0
result.1
result.2
//以元组的形式返回就可以一次性得到多个返回值
//函数接收的时候就直接用一个let或var就行，因为他们是不确定数据类型的，所以可以接收任意类型
//接收后使用上就和正常的元组一样了,可以通过标识符取用，也可以使用下标取用

print("===============参数标签")
//参数标签
//Swift有参数标签这个东西，我们常见的参数名称是为了在函数内部有更好的语义化，而参数标签是为了再外界调用时有更好的语义化
//函数标签的案例
func goToWork(at time: String) {
    //内部语义化：this time is time
    print("this time is \(time)")
}

goToWork(at: "08:00")

//省略参数标签
func sum(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
sum(v1:10, v2:20)

//在函数定义中使用的是time时间，这样更易读,this time is 08:00
//在函数调用时用go to work at 08:00这样来写更易读
//所以在定义函数时需要加上at这个参数标签
//函数的一个参数既有在函数内部使用的函数名称，也有在函数外使用的函数标签
//函数标签可以省略，使用_就可以省略，此时外部调用时就无需使用参数标签
//注意：
//这种加_省略和不写参数标签是不一样的
//这种情况在调用时就可以直接传值，如果是定义时不写参数标签，在外部调用时仍然要写参数名称，而不能直接写参数

//默认参数
//可以在定义函数时添加默认参数时，这样在调用函数时可以不传入这个参数的值
func check(name: String = "nobody", age: Int,job: String = "none") -> () {
    print("name=\(name),age=\(age),job=\(job)")
}
check(age: 18)
check(name: "wy", age: 18, job: "iOS")
check(age: 18,job: "iOS")

//在这个函数中name和job参数有自己的默认参数值
//因此在调用时函数时可以不给name和job传值。函数内部会使用默认参数值来计算
//但是age必须要传值，因为没有默认参数值
//注意：
//因为在传值时会使用到参数标签所以不会有歧义，可以任意决定传值的参数，这与C语言不同

//可变参数
//在Swift中使用可变参数会很方便，当然了和其他语言一样其实在内部也是编译成一个数组
func sumAdd(_ numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}
sumAdd(10,20,30,40)
sumAdd(10, 20)

//传入的参数中在数据类型的后面加上..，这样就是可变参数了
//在函数内部把这个参数看做数组来处理
//注意：
//一个函数最多只能有1个可变参数
//紧跟在可变参数后面的参数不能省略参数标签/参数名称,否则无法区分这个值是哪个参数的

//函数内修改外部变量的值(inout的使用）
//函数的参数只能是常量，所以正常情况下无法修改这个参数，如果想要修改参数，就需要使用inout来修饰这个参数，这样做并且不仅可以修改参数内部，还可以修改外部的变量。
//本质是将值传递改为了指针传递
//inout的使用
func swapValues(_ v1: inout Int, _ v2: inout Int) -> Void {
    let tmp = v1
    v1 = v2
    v2 = tmp
}

var num1 = 10
var num2 = 20
swapValues(&num1, &num2)//传入地址（其实就是指针，虽然Swift中没有指针变量的概念）
//不同于其他语言，Swift的虚参只能是常量，不能是变量，所以无法修改
//而且如果是值传递，也无法修改外部变量的值
//我们可以使用inout来修饰，就可以修改外部变量的值
//但注意此时调用函数时传入的值要传入变量地址，而不是变量本身
//注意：
//可变参数不可以加inout
//inout参数不可以有默认值

//函数类型
//数据类型为：()->() 或者()->Void
func test(){
    print("lalala")
}

//数据类型为：(Int,String) -> (Int,Double)
func test2(a: Int,b: String) -> (Int,Double) {
    return(7,7.0)
}

//函数的函数类型就是参数数据类型+返回值数据类型
//test()函数的函数类型就是() -> ()
//test2()函数的数据类型为：(Int,String) -> (Int,Double)

//作为变量
//（Int,Int) -> Int
func sum2(a:Int,b:Int) -> Int {
    a+b
}

//1、通过函数的数据类型定义一个函数变量
var fn: (Int,Int) -> Int;
//2、赋值一个函数
fn = sum2(a:b:)
//3、调用
fn(2,3)

//定义一个函数类型的变量，就可以将这个函数赋值给这个变量，之后通过这个变量来调用函数
//通过函数变量调用时不需要参数标签和参数名称，直接传值
//我这里为了更方便的说明，所以把定义变量和赋值参数分开写了，其实也可以写到一起

//作为参数传递
//加法
func sum3(v1: Int, v2: Int) -> Int {
    v1+v2
}

//减法
func difference(v1: Int,v2: Int) -> Int {
    v1-v2
}

//通过传入的函数和对变量进行对应的加减操作
//(Int, Int) -> Int 是mathFn参数的数据类型
func printResult(_ mathFn: (Int, Int) -> Int , _ a: Int, _ b:Int) {
    print("Result: \(mathFn(a,b))")
}

printResult(sum3, 20, 10)
printResult(difference, 20, 10)

//在printResult函数中第一个参数就是一个函数，这里传递到时候参数的数据类型就是函数类型
//(Int, Int) -> Int 是mathFn参数的数据类型
//在PrintResult函数中就可以使用传入的函数进行调用了，通过传入的函数和对变量进行对应的加减操作

//作为返回值
//+1
func next(_ input: Int) -> Int {
    input + 1
}

//-1
func previous(_ input: Int) -> Int {
    input - 1
}

//通过传入的Bool值判断返回哪个函数
// (Int) -> Int是返回值类型，是个函数类型，因此返回函数
// 因为返回的是函数所以只写名称，不需要带参数
func forward(_ forward: Bool) -> (Int) -> Int {
    forward ? next : previous
}
forward(true)(3)//4
forward(false)(4)//2

//函数重载
//定义上与C函数的函数重载一样，没什么特殊的
//
//函数重载的方法名必须相同，参数必须不同
//
//参数不同包括：
//
//参数个数不同
//参数类型不同
//参数标签不同

//返回值类型是否相同与函数重载无关
//默认参数值和函数重载一起使用会产生二义性，但是不会编译报错，需要注意

//起别名typealias
//也就是给类型起个别名，可以给任意的类型起别名
public typealias Void = ()

//所以可以看到Void是空元组的别名，等价于就是空元组
