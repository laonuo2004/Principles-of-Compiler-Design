#import "../problemst/pset.typ": pset, framed

#show: pset.with(
  class: "07112303",
  student: "左逸龙",
  title: "编译原理与设计 作业2",
  date: datetime.today()
)

= 给出文法 $G$，写出 $G$ 的语言 $L(G)$，并给出 $L(G)$ 中一个长度为 $3$ 的句子的最左推导和最右推导。

$G: N -> D | N D quad D -> 0 | 1 | 2 | ... | 9$

#framed[
  由产生式可知，
  $N$
  可以推出一个或多个数字。

  因此
  $L(G)={d_1 d_2 ... d_n | n >= 1, d_i in {0,1,2,...,9}}$。

  取长度为
  $3$
  的句子
  $123$。

  最左推导为：

  $N => N D => N D D => D D D => 1 D D => 1 2 D => 1 2 3$。

  最右推导为：

  $N => N D => N 3 => N D 3 => N 2 3 => D 2 3 => 1 2 3$。
]

= 指出下列文法 $G_i$ 所属的文法类，并给出文法所表示的语言集合。

== $G_1$:

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.7em,
    [$S$], [$-> a A | b B$],
    [$A$], [$-> A 0 | epsilon$],
    [$B$], [$-> B 0 0 | epsilon$],
  )
]

#framed[
  该文法为
  $2$
  型文法。

  由
  $A$
  可推出任意多个
  $0$，
  由
  $B$
  可推出偶数个
  $0$。

  因此
  $L(G_1)={a 0^n | n >= 0} union {b 0^(2 n) | n >= 0}$。
]

== $G_2$:

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    [$A$], [$-> a A b | c$],
  )
]

#framed[
  该文法为
  $2$
  型文法。

  每使用一次
  $A -> a A b$
  就在
  $c$
  两边各增加一个
  $a$
  和
  $b$。

  因此
  $L(G_2)={a^n c b^n | n >= 0}$。
]

== $G_3$:

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.7em,
    [$O$], [$-> a | a E$],
    [$E$], [$-> a O$],
  )
]

#framed[
  该文法为
  $3$
  型文法。

  由
  $O -> a$
  可结束推导，每经过一次
  $O -> a E -> a a O$
  就多生成两个
  $a$。

  因此
  $L(G_3)={a^(2 n + 1) | n >= 0}$。
]

= 设文法 $G(Z)$ 为

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.7em,
    [$Z$], [$-> U 0 | V 1$],
    [$U$], [$-> Z 1 | 1$],
    [$V$], [$-> Z 0 | 0$],
  )
]

== 写出 $G(Z)$ 语言的正规式表示。

#framed[
  由文法有

  $Z -> U 0 | V 1 -> Z 1 0 | 1 0 | Z 0 1 | 0 1$。

  所以每次递归都会在后面接上
  $10$
  或
  $01$，
  最后也以
  $10$
  或
  $01$
  结束。

  因此正规式为
  $((10)|(01))((10)|(01))^*$。
]

== 写出 $G(Z)$ 语言的长度为 $6$ 的全部句子。

#framed[
  长度为
  $6$
  时，由三个
  $10$
  或
  $01$
  连接而成。

  全部句子为：

  $101010, 101001, 100110, 100101$；

  $011010, 011001, 010110, 010101$。
]

= 设有文法 $G(S)$：$S -> S S * | S S + | a$

== 指出下列字符串哪些是该文法的句子：

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.7em,
    [$S_1:$], [$a a + a a * + a$],
    [$S_2:$], [$a a + a a a * + +$],
    [$S_3:$], [$a S + a *$],
  )
]

#framed[
  $S_1$
  不是句子。按后缀式看，最后还剩一个
  $a$
  不能合并。

  $S_2$
  是句子，可看作
  $((a+a)+(a+(a * a)))$
  的后缀式。

  $S_3$
  不是句子，因为其中含有非终结符
  $S$。
]

== 对属于该文法的句子 $S_i$，画出其分析树；

#framed[
  $S_2$
  属于该文法，需要画出
  $S_2$
  的分析树。

  #align(center)[
    #image("figures/problem4_2_parse_tree.svg", width: 90%)
  ]
]

== 写出 $G(S)$ 的语言。

#framed[
  $G(S)$
  的语言为所有由操作数
  $a$
  和二元运算符
  $+$
  、
  $*$
  构成的合法后缀表达式。
]

= 文法 $G(N)$ 和 $G(S)$ 为

#grid(
  columns: (1fr, 1fr),
  column-gutter: 4em,
  [
    $G(N):$

    #pad(left: 2em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.8em,
        row-gutter: 0.7em,
        [$N$], [$-> N E | E | N D | D$],
        [$E$], [$-> 0 | 2 | 4 | 6 | 8$],
        [$D$], [$-> 0 | 1 | 2 | ... | 9$],
      )
    ]
  ],
  [
    $G(S):$

    #pad(left: 2em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 0.8em,
        [$S$], [$-> S (S) S | epsilon$],
      )
    ]
  ],
)

== 证明文法 $G(N)$、$G(S)$ 均为二义文法。

#framed[
  对
  $G(N)$，
  串
  $0$
  有两种推导：

  $N => E => 0$；

  $N => D => 0$。

  因此
  $G(N)$
  是二义文法。

  对
  $G(S)$，
  串
  `()()`
  有两种推导：

  $S => S(S)S => epsilon(epsilon)S => ()S => ()S(S)S => ()epsilon(epsilon)epsilon => ()()$；

  $S => S(S)S => S(S)S(S)S => epsilon(epsilon)epsilon(epsilon)epsilon => ()()$。

  因此
  $G(S)$
  也是二义文法。
]

== 改写文法 $G(N)$、$G(S)$ 为等价的非二义文法。

#framed[
  对
  $G(N)$，
  可改写为：

  $N -> D R$

  $R -> D R | epsilon$

  $D -> 0 | 1 | 2 | ... | 9$

  该文法生成所有非空数字串，且每一位只由
  $D$
  推出。

  对
  $G(S)$，
  可改写为：

  $S -> (S) S | epsilon$

  该文法生成所有括号匹配串，且每次确定最左边一对括号。
]

= 给出下面语言的上下文无关文法描述。

== $L_1={a b^n a | n >= 0}$，$Sigma={a,b}$

#framed[
  构造文法
  $G_1=({S,A}, {a,b}, P, S)$，
  其中产生式为：

  $S -> a A a$

  $A -> b A | epsilon$
]

== $L_2={a^n b^n c^i | n >= 1, i >= 0}$，$Sigma={a,b,c}$

#framed[
  构造文法：

  $S -> A C$

  $A -> a A b | a b$

  $C -> c C | epsilon$
]

== $L_3={a^i b^j | i >= j >= 1}$，$Sigma={a,b}$

#framed[
  构造文法：

  $S -> a S | A$

  $A -> a A b | a b$
]

== $L_4={a^n b^n a^m b^m | n,m >= 0}$，$Sigma={a,b}$

#framed[
  构造文法：

  $S -> A B$

  $A -> a A b | epsilon$

  $B -> a B b | epsilon$
]

== $L_5={a^n b^m a^m b^n | n,m >= 0}$，$Sigma={a,b}$

#framed[
  构造文法：

  $S -> a S b | T$

  $T -> b T a | epsilon$
]

== $L_6={w | w in {a, b, c}^*}$，其中 $w$ 是回文串，回文串即从前往后读和从后往前读都是一样的串。

#framed[
  构造文法：

  $S -> a S a | b S b | c S c | a | b | c | epsilon$
]
