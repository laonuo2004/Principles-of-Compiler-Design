#import "../problemst/pset.typ": pset, framed

#show: pset.with(
  class: "07112303",
  student: "左逸龙",
  title: "编译原理与设计 作业4",
  date: datetime.today()
)

= 设有下列文法：

(1) $S -> c A | c c B, quad B -> c c B | b, quad A -> c A | a$

(2) $S -> A a A b | B b B a, quad B -> epsilon, quad A -> epsilon$

== 判断上述文法 (1) 是否为 LR(0) 文法。若是，构造 LR(0) 分析表。若不是，说明理由。

#framed[

]

== 判断上述文法 (2) 是否为 LR(0) 文法。若是，构造 LR(0) 分析表。若不是，说明理由。

#framed[

]

= 设有下列文法：

(1) $S -> S a b | b R, quad R -> S | a$

(2) $S -> a A, quad A -> c A d | epsilon$

== 判断上述文法 (1) 是否为 SLR(1) 文法。若是，构造 SLR(1) 分析表。若不是，说明理由。

#framed[

]

== 判断上述文法 (2) 是否为 SLR(1) 文法。若是，构造 SLR(1) 分析表。若不是，说明理由。

#framed[

]

= 设有下列文法：

(1) $E -> E + T | T, quad T -> T F | F, quad F -> (E) | F^* | a | b$

(2) $S -> a A d | b B d | a B e | b A e, quad A -> g, quad B -> g$

(3) $S -> A | x b, quad A -> a A b | B, quad B -> x$

== 判断上述文法 (1) 属于哪类 LR 文法？

#framed[

]

== 判断上述文法 (2) 属于哪类 LR 文法？

#framed[

]

== 判断上述文法 (3) 属于哪类 LR 文法？

#framed[

]

= 设有下列正规表达式文法：

$R -> R + R | R times R | R^* | (R) | a$

== 判定该文法具有二义性。

#framed[

]

== 构造识别该文法的关于 LR(0) 项目有效的可归前缀的 DFA。

#framed[

]

== 文法中部分符号的语义：

#numbering("①", 1) 非终结符号 $R$ 定义正规表达式；

#numbering("①", 2) 终结符号 $+$ 代表正规表达式运算中的或 ($|$) 运算；

#numbering("①", 3) 终结符号 $times$ 代表正规表达式运算中的连接 ($.$) 运算；

#numbering("①", 4) 终结符号 $*$ 代表正规表达式运算中的闭包 ($*$) 运算。

根据正规表达式中运算符的优先级及结合性，构造上述正规表达式文法的无冲突 SLR(1) 分析表。

#framed[

]



