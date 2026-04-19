#import "../problemst/pset.typ": pset, framed

#show: pset.with(
  class: "07112303",
  student: "左逸龙",
  title: "编译原理与设计 第1章作业",
  date: datetime.today()
)

= 令字母表 $A={0,1,2}$ 上的字符串 $x = 0 1$，$y = 2$，$z = 0 0 1$

== 写出下列符号串及它们的长度：$x^0$, $x y z$, $(x^3)(y^2)$, $(x y)^2$

#framed[
  $x^0 = epsilon$，长度为 $0$。

  $x y z = 012001$，长度为 $6$。

  $(x^3)(y^2) = 01010122$，长度为 $8$。

  $(x y)^2 = 012012$，长度为 $6$。
]

== 写出集合 $A^+$ 和 $A^*$ 的7个最短的字符串。

#framed[
  按长度优先、同长度按字典序排列：

  $A^+$ 的 $7$ 个最短字符串可写为
  $0, 1, 2, 00, 01, 02, 10$。

  $A^*$ 的 $7$ 个最短字符串可写为
  $epsilon, 0, 1, 2, 00, 01, 02$。
]

= 构造一个确定的有限自动机 $M$，它接受字母表 $Sigma={0,1}$ 上 $0$ 和 $1$ 的个数都是奇数的字符串。

#framed[
  设
  $q_0$
  表示 $0$ 和 $1$ 的个数都为偶数，
  $q_1$
  表示 $0$ 的个数为奇数、$1$ 的个数为偶数，
  $q_2$
  表示 $0$ 的个数为偶数、$1$ 的个数为奇数，
  $q_3$
  表示 $0$ 和 $1$ 的个数都为奇数。

  则可构造
  $M=(Q, Sigma, delta, q_0, F)$，
  其中
  $Q={q_0, q_1, q_2, q_3}$，
  $F={q_3}$。

  转移函数为：

  $delta(q_0, 0)=q_1$，$delta(q_0, 1)=q_2$；

  $delta(q_1, 0)=q_0$，$delta(q_1, 1)=q_3$；

  $delta(q_2, 0)=q_3$，$delta(q_2, 1)=q_0$；

  $delta(q_3, 0)=q_2$，$delta(q_3, 1)=q_1$。

  初态为
  $q_0$，
  终态为
  $q_3$。

  对应的状态图如下：

  #align(center)[
    #image("figures/q2_dfa.svg", width: 88%)
  ]
]

= 给定非确定的有限自动机 $M$ 的状态图如下：

#align(center)[
  #image("figures/fig_1.png", width: 90%)
]

== 写出非确定的有限自动机 $M$ 的另外两种描述形式；

#framed[
  字母表为
  $Sigma={a,b}$。

  五元组可写为
  $M=(Q, Sigma, delta, 0, F)$，
  其中
  $Q={0,1,2,3,4,5,6}$，
  $F={6}$。

  转移函数可写为：

  $delta(0,a)={1}$，$delta(0,b)=emptyset$；

  $delta(1,a)=emptyset$，$delta(1,b)=emptyset$，$delta(1,epsilon)={2}$；

  $delta(2,a)={2}$，$delta(2,b)={2}$，$delta(2,epsilon)={3}$；

  $delta(3,a)={4}$，$delta(3,b)=emptyset$；

  $delta(4,a)=emptyset$，$delta(4,b)={5}$；

  $delta(5,a)={6}$，$delta(5,b)=emptyset$；

  $delta(6,a)=delta(6,b)=emptyset$。
]

== 将 $M$ 确定化且最小化为确定的有限自动机 $M'$；

#framed[
  先作子集构造。记
  $A={0}$，
  $B={1,2,3}$，
  $C={2,3,4}$，
  $D={2,3}$，
  $E={2,3,5}$，
  $F={2,3,4,6}$，
  $T=emptyset$。

  则确定化后的转移为：

  $A$
  读入
  $a$
  到
  $B$，
  读入
  $b$
  到
  $T$；

  $B$
  读入
  $a$
  到
  $C$，
  读入
  $b$
  到
  $D$；

  $C$
  读入
  $a$
  到
  $C$，
  读入
  $b$
  到
  $E$；

  $D$
  读入
  $a$
  到
  $C$，
  读入
  $b$
  到
  $D$；

  $E$
  读入
  $a$
  到
  $F$，
  读入
  $b$
  到
  $D$；

  $F$
  读入
  $a$
  到
  $C$，
  读入
  $b$
  到
  $E$；

  $T$
  读入
  $a,b$
  都到
  $T$。

  其中
  $B$
  与
  $D$
  等价，可合并。

  最小化后重新记：

  $A={0}$；

  $B$
  表示把
  ${1,2,3}$
  和
  ${2,3}$
  合并后的状态；

  $C={2,3,4}$；

  $D={2,3,5}$；

  $E={2,3,4,6}$；

  $T=emptyset$。

  所以
  $M'=(Q', Sigma, delta', A, {E})$，
  其中
  $Q'={A,B,C,D,E,T}$。

  转移函数为：

  $delta'(A,a)=B$，$delta'(A,b)=T$；

  $delta'(B,a)=C$，$delta'(B,b)=B$；

  $delta'(C,a)=C$，$delta'(C,b)=D$；

  $delta'(D,a)=E$，$delta'(D,b)=B$；

  $delta'(E,a)=C$，$delta'(E,b)=D$；

  $delta'(T,a)=T$，$delta'(T,b)=T$。

  对应的最小 DFA 如下：

  #align(center)[
    #image("figures/q3_mprime.svg", width: 94%)
  ]
]

== 用确定的有限自动机 $M'$ 识别字符串 $a a b a a b a b a a a a b$ 为几个单词。

#framed[
  把字符串写成
  $a a b a a b a b a a a a b$。

  在
  $M'$
  上的状态变化为：

  $A, B, C, D, E, C, D, E, D, E, C, C, C, D$。

  所以前缀在第 $4$、$7$、$9$ 个字符处到达终态。

  按最长匹配，先识别出一个单词
  $a a b a a b a b a$；
  剩下
  $a a a b$
  不能被识别。

  因此只能识别出
  $1$
  个单词。
]

= 给出正规式 $((epsilon | a) b^*)^*$

== 构造 NFA；

#framed[
  原式
  $((epsilon | a) b^*)^*$
  可化简为
  $(a|b)^*$。

  下面直接按化简后的正规式
  $(a|b)^*$
  来构造 NFA。

  因为每一段
  $(epsilon|a)b^*$
  都可以只产生若干个
  $b$，
  也可以产生一个
  $a$
  再接若干个
  $b$，
  所以任意由
  $a,b$
  组成的串都能表示出来。

  因此可取一个状态的 NFA：

  $M=({q_0}, {a,b}, delta, q_0, {q_0})$，

  其中
  $delta(q_0,a)={q_0}$，
  $delta(q_0,b)={q_0}$。

  状态图如下：

  #align(center)[
    #image("figures/q4_abstar.svg", width: 46%)
  ]
]

== 给出 NFA 处理输入串 $a b a b b a b$ 的状态转换序列；

#framed[
  因为只有一个状态
  $q_0$，
  且读入
  $a,b$
  都回到
  $q_0$，
  所以状态转换序列为：

  $q_0, q_0, q_0, q_0, q_0, q_0, q_0, q_0$。
]

== 将 NFA 确定化和最小化为 DFA；

#framed[
  由于前面的 NFA 已经只有一个状态，
  所以确定化后仍只有一个状态，最小化后也不变。

  即
  $M'=({q_0}, {a,b}, delta, q_0, {q_0})$，
  其中
  $delta(q_0,a)=q_0$，
  $delta(q_0,b)=q_0$。

  状态图如下：

  #align(center)[
    #image("figures/q4_abstar.svg", width: 46%)
  ]
]

== 给出最小 DFA 处理输入串 $a b a b b a b$ 的状态转换序列。

#framed[
  与上面相同，状态转换序列为：

  $q_0, q_0, q_0, q_0, q_0, q_0, q_0, q_0$。
]

= 写出下列各个正规集的正规式或有限自动机。

== $Sigma={0,1}$，$1$ 的个数为奇数并且两个 $1$ 之间至少有一个 $0$ 隔开。

#framed[
  可写为正规式
  $0^*(100^*100^*)^*10^*$。
]

== $Sigma={a,b,c}$，包含偶数个 $a$ 的字符串。

#framed[
  可写为正规式
  $((b|c)^*a(b|c)^*a)^*(b|c)^*$。
]

== 二进制数且为 $4$ 的倍数。

#framed[
  这里默认允许前导
  $0$。

  可写为正规式
  $0|(0|1)^*00$。
]

== 大于 $101001$ 的二进制数。

#framed[
  这里默认按通常二进制表示，不写前导
  $0$。
  可写为正规式

  $10101(0|1)|1011(0|1)(0|1)|11(0|1)(0|1)(0|1)(0|1)|1(0|1)(0|1)(0|1)(0|1)(0|1)(0|1)(0|1)^*$。
]

== $Sigma={a,b}$，不包含子串 $b a a$ 的字符串。

#framed[
  构造 DFA：

  $q_0$
  表示当前后缀不是
  $b$
  或
  $b a$；

  $q_1$
  表示当前后缀为
  $b$；

  $q_2$
  表示当前后缀为
  $b a$；

  $q_d$
  表示已经出现了子串
  $b a a$。

  初态为
  $q_0$，
  终态为
  $F={q_0,q_1,q_2}$。

  转移函数为：

  $delta(q_0,a)=q_0$，$delta(q_0,b)=q_1$；

  $delta(q_1,a)=q_2$，$delta(q_1,b)=q_1$；

  $delta(q_2,a)=q_d$，$delta(q_2,b)=q_1$；

  $delta(q_d,a)=q_d$，$delta(q_d,b)=q_d$。

  状态图如下：

  #align(center)[
    #image("figures/q5_no_baa.svg", width: 96%)
  ]
]

== $C$ 中的非负整数常量语言，其中以 $0$ 开始的代表八进制常量，其余的数字为十进制常量。

#framed[
  可写为正规式
  $0(0|1|2|3|4|5|6|7)^*|(1|2|3|4|5|6|7|8|9)(0|1|2|3|4|5|6|7|8|9)^*$。
]
