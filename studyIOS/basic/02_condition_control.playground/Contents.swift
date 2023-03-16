import UIKit
//条件控制语句
//if、while、for、switch、guard语句

var greeting = "Hello, playground"

//if
let age = 4
if age >= 5 {
    print("大于22")
} else if age < 5 {
    print("小于5")
}


//while循环
var num = 5
while num > 0 {
    print("num is \(num)")
    num -= 1
}

//repeat...while循环  相当于do...while
print("===repeat...while===")
var num2 = -1
repeat {
    print("num is \(num)")
} while num > 0


//for循环语句
//Swift给我们显式的提供了for循环的区间，并且增加很多范围区间的种类，对于for循环有跟多的可操作性
//显式区间
//闭区间
/*
 1、简单循环获取i值（变量）
 */
for var i in 1...3 {
    i += 5
    print(i)
}
print("=========")
/*
 2、循环获取数组值
 */
let name = ["A","B","C","D"]
for i in 0...3 {
    print(name[i])
}
print("=========")
/*
 3、可以将区间设置为变量来使用
 */
let range = 1...3
for i in range {
    print(name[i])
}
print("=========")
/*
 4、也可以用变量分开设置区间的左右范围
 */
let a = 1
var b = 2
for i in a...b {
    print(name[i])
}
print("=========")
/*
 5、不获取变量值
 */
for _ in 1...3 {
    print("WY")
}



/*
 半开区间
 */
for i in 1..<5 {
    print(i)
}

//增强for
/*
 1、直接获取数组中的数据
 */

print("=========增强for")
let names = ["A","B","C","D"]
for name in names[0...3] {
    print(name)
}

//单侧区间：
//让区间朝一个方向尽可能远
/*
 2、单侧区间
 */
//单侧区间就是只设置其中一侧的范围，另一侧是无限远
//当然不可能是真的无限远，否则就死循环了，而是到达数组的最大下标
print("=========单侧区间")
for name in names[1...] {
    print(name)
}

//设置区间类型
//Swift内置了区间类型供我们方便使用

var range1: ClosedRange<Int> = 1...3
var range2: Range<Int> = 1..<3
var range3: PartialRangeThrough<Int> = ...5

range1 = 2...4
print("===========设置区间类型")
for i in range1 {
    print(i)
}

//字符、字符串也能使用区间运算符，但是默认不能用在for- in中
let stringRange = "a"..."f"
stringRange.contains("d")//true
stringRange.contains("h")//false


print("===========where过滤变量值")
//where过滤变量值
/*
 where过滤
 */
var numbers = [10,20,-11,-22]
var sum = 0
for num in numbers where num > 0 {
    sum += num
}
print(sum)

//设置区间间隔
print("===========设置区间间隔")
let hours = 10
let hourInterval = 2
//tickMark的取值：从4开始，累加2，到达10结束，包含10
for tickMark in stride(from: 4, through: hours, by: hourInterval){
    print(tickMark)
}//4，6，8，10

//tickMark的取值：从4开始，累加2，到达10结束，不包含10
for tickMark in stride(from: 4, to: hours, by: hourInterval){
    print(tickMark)
}//4，6，8

//可以分别设置累加值和终止值
//终止值有两种，如果是through，则包含最后一个值，如果是to则不包含

//switch
/*
 1、基础写法
 */
var number = 1
switch number {
case 1:
    print("number is 1")
    break
case 2:
    print("number is 1")
    break
default:
    print("number is other")
    break
}

/*
 2、fallthrouth
 */
print("=============fallthrouth")
switch number {
case 1:
    print("number is 1")
    fallthrough
case 2:
    print("number is 1")
default:
    print("number is other")
}

/*
 3、支持Character、String类型
 */
print("=============支持Character、String类型")
var str = "WY"
switch str {
case "A":
    print("A")
case "B":
    print("B")
case "WY":
    print("WY")
default:
    break
}

//case、default后面不能写大括号{}
//与其他语言不一样的是默认已经有break，所以可以显式的写breake，不写也不会贯穿到后面条件
//如果我们想要实现贯穿效果，需要加上fallthrough
//需要注意的是switch也支持Character、String类型
//注意：
//switch必须要能够实现处理所有的情况，其他情况可以放在default，如果已经确定已经包含所有情况，是可以不写default的
//case、default后面至少要有一条语句，如果不想做任何事情，就可以加个break

//组合条件匹配
/*
 组合匹配
 */
print("=============组合匹配")
var str2 = "WY"
switch str2 {
case "A":
    print("A")
case "B","WY":
    print("B or WY")
default:
    break
}//B or WY
//可以有多个条件组合匹配，中间用,分割

/*
 2、区间匹配
 */
print("=============区间匹配")
let count = 60
switch count {
case 0:
    print("none")
case 1..<60:
    print("a few")
case 10...100:
    print("dozens of")
default:
    print("other")
}//dozens of

//元组匹配
print("=============元组匹配")
/*
 3、元组匹配
 */
let point = (1,1)
switch point {
case (0,0):
    print("the origin")
case (_,0):
    print("on the x-axis")
case (0,_):
    print("on the y-axis")
case (-2...2,-2...2):
    print("inside the 2*2 box")
default:
    print("outside of the box")
}//inside the 2*2 box
//判断的类型也可以是元组，元组是否在这个区间内
//可以使用下划线_忽略这个值


//值绑定
//可以在匹配的过程中获取其中的某个值
/*
 5、值绑定
 */
print("=============值绑定")
let point2 = (2,0)
switch point {
case (let x,0):
    print("on the x-axis with an x value of \(x)")
case (0,var y):
    y += 2
    print("on the x-axis with an x value of \(y)")
default:
    print("值绑定 default")
    break
}// on the x-axis with an x value of 2

print("=============switch where过滤")
//where过滤
let point3 = (1,-1)
switch point3 {
case let (x,y) where x == y:
    print("on the line x == y")
case let (x,y) where x == -y:
    print("on the line x == -y")
case let (x,y):
    print("other")
}//on the line x == -y

print("=============Guard语句")
//Guard语句
//主要用于提前退出，条件不符合的时候退出，判断值是否成立用它就很方便了
func test(v:Bool){
    guard v else{
        print("当v为false时进入")
        return
    }
    print("当v为true时进入")
}

test(v: false)
test(v: true)

//当guard语句的条件为false时，就会执行大括号里面的代码
//当guard语句的条件为true时，就会跳过guard语句
//guard语句特别适合用来“提前退出”



