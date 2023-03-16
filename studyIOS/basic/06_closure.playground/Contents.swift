import UIKit

var greeting = "Hello, playground"

//闭包表达式简化了函数的调用，闭包可以捕获局部变量，在局部变量的作用域外也可以进行操作
//主要内容：
//闭包表达式
//闭包使用
//闭包原理

//闭包表达式认识
//闭包表达式用来实现功能，类似于函数的作用，只是写法不一样
//
//定义格式：
//
//{
//    (参数列表) -> 返回值类型 in
//    函数体代码
//}

/*
 1、闭包表达式的写法
 */
//1.1 函数
func sum(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
print("sum\(sum(10, 20))")

//1.2 闭包表达式
var fn = {
    (v1: Int,v2: Int) -> Int in
    return v1 + v2
}

//let result = fn(10,20)
//
////1.3 匿名闭包表达式
//{
//   (v1: Int,v2: Int) -> Int in
//   return v1 + v2
//}(10,20)


/*
 2、闭包表达式的简写
 */
func test2 (){
    //2.1 函数
    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    
    //2.2 闭包表达式正常格式
    exec(v1: 10, v2: 20, fn: {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    })
    
    //2.3 简写：参数类型
    exec(v1: 10, v2: 20, fn: {
        v1, v2 in return v1 + v2
    })
    
    //2.4 简写：return
    exec(v1: 10, v2: 20, fn: {
        v1, v2 in v1 + v2
    })
    
    //2.5 简写：参数
    exec(v1: 10, v2: 20, fn: { $0 + $1 })
    
    //2.6 简写：只写操作符
    exec(v1: 10, v2: 20, fn: + )
    
    
    //===================================================
    
    func exe(v1:Int,v2:Int,fn:(Int,Int)->Int){
        print("exe:\(fn(v1,v2))")
    }
    
    exe(v1: 1, v2: 2, fn: {(v1,v2)-> Int in
        return v1+v2
    })
    
    exe(v1: 1, v2: 2, fn: {v1,v2 in return v1 + v2})
    
    exe(v1: 1, v2: 2, fn: {v1,v2 in v1+v2})
    
    exe(v1: 1, v2: 2, fn: {$0+$1})
    
    exe(v1: 1, v2: 2, fn: +)
    
    //===================================================
    
}
test2()

//尾随闭包
//如果将一个很长的闭包表达式作为函数的最后一个实参，可读性较差，此时可以使用尾随闭包增加代码的可读性。
//尾随闭包就是将闭包表达式书写在调用函数的括号外面

func test3 () {
    /*
     3、尾随闭包
     */
    //3.1 函数定义
    func exec1(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print("test3: \(fn(v1, v2))")
    }
    
    //3.2 函数调用时尾随闭包
    exec1(v1: 10, v2: 20) { $0 + $1 }
}

test3()

//可以看fn闭包表达式作为exec函数的参数，但是本身是放在了括号的后边，这就是所谓的尾随
//需要注意的是，如果闭包表达式是函数的唯一实参，而且使用了尾随闭包的语法，就不需要在函数后面写()

/*
 4、数组排序实例
 */
func test4(){
    
    var nums = [12,324,123,1,32,43,545]
    
    nums.sort(by: {
        (i1:Int,i2:Int)->Bool in
        return i1<i2
    })
    
    //正常
    nums.sort(by: {i1,i2 in
        return i1<i2
    })
    
    //没有return
    nums.sort(by: {i1,i2 in i1<i2})
    
    //没有参数
    nums.sort(by: {$0<$1})
    
    //只有运算符
    nums.sort(by: <)
    
    //尾随闭包
    nums.sort(){$0<$1}
    
    //最后一个参数不能写()
    nums.sort{$0<$1}

    print(nums)
}

test4()


/*
 1、闭包认识
 */
func test5 () {
    //定义一个函数类型
    typealias Fn = (Int) -> Int
    //返回一个函数
    func getFn() -> Fn {
        var num = 0
        //plus函数会捕获num变量
        //plus函数和捕获的num变量形成了闭包
        func plus(_ i: Int) -> Int {
            num += i
            print("num:\(num)")
            return num
        }
        return plus
    }
    var fn1 = getFn()
    var fn2 = getFn()
    fn1(1) // 1
    fn2(2) // 2
    fn1(3) // 4
    fn2(4) // 6
}
test5()


/*
 3、捕获变量的时机
 */
func test7() {
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        var num = 11
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        //捕获的是14，而非11
        num = 14
        return plus
    }
    var fn1 = getFn()
    fn1(1)//15
}
test7()

//可以看到只有在返回这个plus函数地址的时候才会去捕获，所以并不是在定义函数的时候捕获，而是在创建函数变量的时候捕获
//其实这里就算没有return,只要是创建了plus函数对象就会捕获的

//数组循环闭包分析
/*
 5、数组循环闭包分析
 */
func test9() {
    //定义一个数组，元素是函数
    var functions: [() -> Int] = []
    for i in 1...3 {
        functions.append{ i }
    }
    for f in functions {
        print("\(f())")
    }
}

test9()


//自动闭包
//如果我们传入的参数是需要作为包，但是写成包的样式可读性会很差，就可以设置成自动闭包，系统帮我们闭包

/*
 6、自动闭包
 使用关键字@autoclosure修饰参数
 */
func test10() {
    func getFirstPositive(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int {
        return v1 > 0 ? v1 : v2()
    }
    //下面三条语句等效
    getFirstPositive(10, 20)//自动闭包
}
test10()
