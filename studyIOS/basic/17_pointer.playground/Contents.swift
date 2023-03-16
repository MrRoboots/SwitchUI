import UIKit

var greeting = "Hello, playground"
//Swift的指针类型，本质也是地址，但是Swift提供专门的指针类型存储地址。
//
//主要内容：
//
//指针类型的认识
//指针类型的使用
//类型转换
//1、指针认识
//Swift中也有专门的指针类型，这些都被定性为“Unsafe”（不安全的），Swift中并不会简单的认为地址就是一个指针，而是有专门的类型进行包装。只要获取到地址就可以对数据进行无访问限制的操作，因此是不安全的。
//
//指针类型：
//
//指针类型    认识
//UnsafePointer< Pointee >    类似于 const Pointee *
//UnsafeMutablePointer< Pointee >    类似于 Pointee *
//UnsafeRawPointer    类似于 const void *
//UnsafeMutableRawPointer    类似于 void *
//说明：
//1、指针都是不安全的，因此都是Unsafe
//2、没有Mutalbe的表示仅可读指针指向的内存，带有Mutable表示可读可写
//3、< Pointee >是泛型，表示指针的类型
//4、带Raw的都是不支持泛型的，所以都是void类型，类型不定

//泛型
var age = 10

func test1(_ ptr:UnsafeMutablePointer<Int>){
    ptr.pointee = 40
    print("test",ptr.pointee)
}

func test2(_ ptr:UnsafePointer<Int>){
    print("test2",ptr.pointee)
}

test1(&age)
test2(&age)


//1、通过指针的pointee来拿到内存数据
//2、依然是取地址符拿到指针，只不过需要存储到Swift提供的指针类型中
//3、注意Mutable的可以进行修改


//不带泛型
func test3(_ ptr:UnsafeRawPointer){ //const void *
    print("test3",ptr.load(as: Int.self))
}

func test4(_ ptr:UnsafeMutableRawPointer){//void
    print("test4",ptr.storeBytes(of: 30, as: Int.self))
}

test3(&age)
test4(&age)
//1、没有设置类型，需要自己设置一下类型
//2、注意赋值为load和取值为storeBytes即可


//通过指针遍历数组

var arr = NSArray(objects: 12,234,123,32423,123125,1233)
arr.enumerateObjects{ (obj,idx,stop)in
    print(idx,obj)
    if(idx==2){// 下标为2就停止遍历
        stop.pointee = true//指针赋值
    }
}

//这种遍历方式中stop参数其实就是一个指针类型()
//指针拿到自己的pointee就可以进行修改了。

//获取指针变量
//获取变量的指针
//3.1.1 拿到带泛型的指针
var ptr1 = withUnsafeMutablePointer(to:&age){$0}
var ptr2 = withUnsafePointer(to: &age){$0}
ptr1.pointee = 22
print(ptr1.pointee)
print(age)


//3.1.2 拿到无泛型的指针
var ptr3 = withUnsafeMutablePointer(to: &age){UnsafeMutableRawPointer($0)}
var ptr4 = withUnsafePointer(to: &age){UnsafeRawPointer($0)}
print("ptr3",ptr3)
print("ptr4",ptr4)
ptr3.storeBytes(of: 33,as:Int.self)
print(ptr4.load(as: Int.self))
print(age) // 33

//3.1.3 拿到变量的指针
class Person{
    var age:Int
    init(age:Int){
        self.age = age
    }
}

var person = Person(age: 32)
var ptr5 = withUnsafePointer(to: &person){$0}//指针就是变量地址
print("ptr5",ptr5)



