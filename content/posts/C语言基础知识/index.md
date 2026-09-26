---
title: "C语言基础知识"
date: 2025-09-21T16:30:00+08:00
url: "/2025/09/21/16"
draft: false
description: "C语言入门基础知识，包含语法、数据类型、控制结构等核心概念"
comment: true
weight: 0
tags:
  - "编程"
  - "C语言"
  - "基础教程"
categories:
  - "编程语言"
summary: "C语言入门基础知识，包含语法、数据类型、控制结构等核心概念"
featured_image_preview: "https://img.san3.cn/img/fa46a0757f3ce26e.webp"
images:
  - "https://img.san3.cn/img/fa46a0757f3ce26e.webp"
---
C语言是一门通用的、过程化的计算机程序设计语言，由丹尼斯·里奇在1972年为了重写UNIX操作系统而开发。C语言具有高效、灵活、功能丰富、表达力强和较高的移植性等特点。

## 1. 基本语法结构

### Hello World程序

```c
#include <stdio.h>

int main()
{
    printf("Hello,World!\n");
    return 0;
}
```

### 程序结构说明
- `#include <stdio.h>`: 预处理指令，包含标准输入输出库
- `int main()`: 主函数，程序执行的入口点
- `printf()`: 标准输出函数
- `return 0`: 返回值，表示程序正常结束

## 2. 数据类型

### 基本数据类型

| 类型 | 关键字 | 字节数 | 取值范围 |
|------|--------|--------|----------|
| 字符型 | char | 1 | -128 ~ 127 |
| 整型 | int | 4 | -2,147,483,648 ~ 2,147,483,647 |
| 短整型 | short | 2 | -32,768 ~ 32,767 |
| 长整型 | long | 8 | 更大范围 |
| 单精度浮点 | float | 4 | 约7位有效数字 |
| 双精度浮点 | double | 8 | 约15位有效数字 |

### 变量声明和初始化

```c
int age=25;
float height=175.5;
char grade='A';
double pi=3.14159265359;
```

## 3. 输入输出

### 基本输入输出函数

```c
#include <stdio.h>

int main()
{
    int number;
    char name[50];

    // 输出
    printf("请输入您的姓名: ");

    // 输入
    scanf("%s", name);
    printf("请输入一个数字: ");
    scanf("%d", &number);

    // 格式化输出
    printf("你好 %s，你输入的数字是 %d\n", name, number);

    return 0;
}
```

### 常用格式化符号
- `%d`: 整数
- `%f`: 浮点数
- `%c`: 字符
- `%s`: 字符串
- `%x`: 十六进制

## 4. 运算符

### 算术运算符
```c
int a=10, b=3;
int sum=a+b;        // 加法: 13
int diff=a-b;       // 减法: 7
int product=a*b;    // 乘法: 30
int quotient=a/b;   // 除法: 3
int remainder=a%b;  // 取余: 1
```

### 比较运算符
```c
int x=5, y=10;
printf("%d\n", x==y);  // 等于: 0 (false)
printf("%d\n", x!=y);  // 不等于: 1 (true)
printf("%d\n", x<y);   // 小于: 1 (true)
printf("%d\n", x>y);   // 大于: 0 (false)
printf("%d\n", x<=y);  // 小于等于: 1 (true)
printf("%d\n", x>=y);  // 大于等于: 0 (false)
```

### 逻辑运算符
```c
int a=1, b=0;
printf("%d\n", a&&b);  // 逻辑与: 0
printf("%d\n", a||b);  // 逻辑或: 1
printf("%d\n", !a);      // 逻辑非: 0
```

## 5. 控制结构

### if-else语句
```c
int score=85;

if (score>=90)
{
    printf("优秀\n");
}
else if (score>=80)
{
    printf("良好\n");
}
else if (score>=60)
{
    printf("及格\n");
}
else
{
    printf("不及格\n");
}
```

### switch语句
```c
char grade='B';

switch (grade)
{
    case 'A':
        printf("优秀\n");
        break;
    case 'B':
        printf("良好\n");
        break;
    case 'C':
        printf("及格\n");
        break;
    default:
        printf("需要努力\n");
        break;
}
```

### 循环结构

#### for循环
```c
// 打印1到10
for (int i=1; i<=10; i++)
{
    printf("%d ", i);
}
printf("\n");
```

#### while循环
```c
int count=1;
while (count<=5)
{
    printf("第%d次循环\n", count);
    count++;
}
```

#### do-while循环
```c
int num;
do
{
    printf("请输入一个正数 (输入0退出): ");
    scanf("%d", &num);
    if (num>0)
    {
        printf("你输入了: %d\n", num);
    }
} while (num!=0);
```

## 6. 数组

### 一维数组
```c
// 声明和初始化
int numbers[5]={1, 2, 3, 4, 5};
int scores[]={95, 87, 92, 78, 88};  // 自动推断大小

// 访问数组元素
printf("第一个元素: %d\n", numbers[0]);
numbers[2]=100;  // 修改元素

// 遍历数组
for (int i=0; i<5; i++)
{
    printf("numbers[%d] = %d\n", i, numbers[i]);
}
```

### 字符数组（字符串）
```c
char name[20]="张三";
char greeting[]="Hello World";

printf("姓名: %s\n", name);
printf("问候: %s\n", greeting);
```

## 7. 函数

### 函数定义和调用
```c
#include <stdio.h>

// 函数声明
int add(int a, int b);
void printInfo(char name[], int age);

int main()
{
    int result=add(10, 20);
    printf("10 + 20 = %d\n", result);

    printInfo("小明", 18);

    return 0;
}

// 函数定义
int add(int a, int b)
{
    return a+b;
}

void printInfo(char name[], int age)
{
    printf("姓名: %s, 年龄: %d\n", name, age);
}
```

### 递归函数示例
```c
// 计算阶乘
int factorial(int n)
{
    if (n<=1)
    {
        return 1;
    }
    return n*factorial(n-1);
}

int main()
{
    printf("5! = %d\n", factorial(5));  // 输出: 120
    return 0;
}
```

## 8. 指针基础

### 指针声明和使用
```c
#include <stdio.h>

int main()
{
    int num=42;
    int *ptr=&num;  // ptr指向num的地址

    printf("num的值: %d\n", num);
    printf("num的地址: %p\n", &num);
    printf("ptr的值(地址): %p\n", ptr);
    printf("ptr指向的值: %d\n", *ptr);

    // 通过指针修改值
    *ptr=100;
    printf("修改后num的值: %d\n", num);

    return 0;
}
```

## 9. 结构体

### 结构体定义和使用
```c
#include <stdio.h>
#include <string.h>

// 定义学生结构体
struct Student {
    char name[50];
    int age;
    float score;
};

int main() {
    // 创建结构体变量
    struct Student student1;

    // 赋值
    strcpy(student1.name, "李四");
    student1.age=20;
    student1.score=95.5;

    // 输出
    printf("姓名: %s\n", student1.name);
    printf("年龄: %d\n", student1.age);
    printf("分数: %.1f\n", student1.score);

    return 0;
}
```

## 10. 实用示例

### 简单计算器
```c
#include <stdio.h>

int main() {
    char operator;
    double num1, num2, result;

    printf("请输入运算符 (+, -, *, /): ");
    scanf("%c", &operator);

    printf("请输入两个数字: ");
    scanf("%lf %lf", &num1, &num2);

    switch (operator) {
        case '+':
            result=num1+num2;
            break;
        case '-':
            result=num1-num2;
            break;
        case '*':
            result=num1*num2;
            break;
        case '/':
            if (num2!=0) {
                result=num1/num2;
            } else {
                printf("错误: 除数不能为0\n");
                return 1;
            }
            break;
        default:
            printf("错误: 无效的运算符\n");
            return 1;
    }

    printf("%.2lf %c %.2lf = %.2lf\n", num1, operator, num2, result);

    return 0;
}
```
