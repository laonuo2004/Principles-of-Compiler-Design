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
  先增广文法并给产生式编号：

  $(0) quad S' -> S$

  $(1) quad S -> c A$

  $(2) quad S -> c c B$

  $(3) quad B -> c c B$

  $(4) quad B -> b$

  $(5) quad A -> c A$

  $(6) quad A -> a$

  构造 LR(0) 项目集族后，没有出现移进-归约冲突或归约-归约冲突。

  因此该文法是 LR(0) 文法。

  LR(0) 分析表如下：

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto),
      column-gutter: 1.3em,
      row-gutter: 0.8em,
      [状态], [$a$], [$b$], [$c$], [$"EOF"$], [$S$], [$A$], [$B$],
      [$0$], [], [], [$s_2$], [], [$1$], [], [],
      [$1$], [], [], [], [acc], [], [], [],
      [$2$], [$s_5$], [], [$s_3$], [], [], [$4$], [],
      [$3$], [$s_5$], [$s_9$], [$s_6$], [], [], [$7$], [$8$],
      [$4$], [$r_1$], [$r_1$], [$r_1$], [$r_1$], [], [], [],
      [$5$], [$r_6$], [$r_6$], [$r_6$], [$r_6$], [], [], [],
      [$6$], [$s_5$], [], [$s_10$], [], [], [$7$], [],
      [$7$], [$r_5$], [$r_5$], [$r_5$], [$r_5$], [], [], [],
      [$8$], [$r_2$], [$r_2$], [$r_2$], [$r_2$], [], [], [],
      [$9$], [$r_4$], [$r_4$], [$r_4$], [$r_4$], [], [], [],
      [$10$], [$s_5$], [$s_9$], [$s_6$], [], [], [$7$], [$11$],
      [$11$], [$r_3$], [$r_3$], [$r_3$], [$r_3$], [], [], [],
    )
  ]

]

== 判断上述文法 (2) 是否为 LR(0) 文法。若是，构造 LR(0) 分析表。若不是，说明理由。

#framed[
  先增广文法并给产生式编号：

  $(0) quad S' -> S$

  $(1) quad S -> A a A b$

  $(2) quad S -> B b B a$

  $(3) quad B -> epsilon$

  $(4) quad A -> epsilon$

  初始项目集为：

  $I_0={S' -> dot S, S -> dot A a A b, S -> dot B b B a, B -> dot, A -> dot}$。

  其中
  $B -> dot$
  和
  $A -> dot$
  都是归约项目。

  在 LR(0) 分析表中，归约项目需要在所有终结符列上归约，所以在
  $I_0$
  中会同时填入
  $r_3$
  和
  $r_4$，
  产生归约-归约冲突。

  因此该文法不是 LR(0) 文法。

]

= 设有下列文法：

(1) $S -> S a b | b R, quad R -> S | a$

(2) $S -> a A, quad A -> c A d | epsilon$

== 判断上述文法 (1) 是否为 SLR(1) 文法。若是，构造 SLR(1) 分析表。若不是，说明理由。

#framed[
  先增广文法并给产生式编号：

  $(0) quad S' -> S$

  $(1) quad S -> S a b$

  $(2) quad S -> b R$

  $(3) quad R -> S$

  $(4) quad R -> a$

  由文法可得：

  $"FOLLOW"(S)={a,"EOF"}$，
  $"FOLLOW"(R)={a,"EOF"}$。

  构造 LR(0) 项目集族时，有项目集：

  $I_4={S -> S dot a b, R -> S dot}$。

  其中
  $S -> S dot a b$
  在读入
  $a$
  时需要移进，
  而
  $R -> S dot$
  需要在
  $"FOLLOW"(R)$
  上归约。

  因为
  $a in "FOLLOW"(R)$，
  所以在
  $"ACTION"[4,a]$
  处同时需要填入移进和归约，产生移进-归约冲突。

  因此该文法不是 SLR(1) 文法。

]

== 判断上述文法 (2) 是否为 SLR(1) 文法。若是，构造 SLR(1) 分析表。若不是，说明理由。

#framed[
  先增广文法并给产生式编号：

  $(0) quad S' -> S$

  $(1) quad S -> a A$

  $(2) quad A -> c A d$

  $(3) quad A -> epsilon$

  由文法可得：

  $"FOLLOW"(S)={"EOF"}$，
  $"FOLLOW"(A)={d,"EOF"}$。

  构造 LR(0) 项目集族后，在归约项目处只按 FOLLOW 集填表，没有出现冲突。

  因此该文法是 SLR(1) 文法。

  SLR(1) 分析表如下：

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto, auto, auto, auto),
      column-gutter: 1.3em,
      row-gutter: 0.8em,
      [状态], [$a$], [$c$], [$d$], [$"EOF"$], [$S$], [$A$],
      [$0$], [$s_2$], [], [], [], [$1$], [],
      [$1$], [], [], [], [acc], [], [],
      [$2$], [], [$s_4$], [$r_3$], [$r_3$], [], [$3$],
      [$3$], [], [], [], [$r_1$], [], [],
      [$4$], [], [$s_4$], [$r_3$], [$r_3$], [], [$5$],
      [$5$], [], [], [$s_6$], [], [], [],
      [$6$], [], [], [$r_2$], [$r_2$], [], [],
    )
  ]

]

= 设有下列文法：

(1) $E -> E + T | T, quad T -> T F | F, quad F -> (E) | F^* | a | b$

(2) $S -> a A d | b B d | a B e | b A e, quad A -> g, quad B -> g$

(3) $S -> A | x b, quad A -> a A b | B, quad B -> x$

== 判断上述文法 (1) 属于哪类 LR 文法？

#framed[
  该文法是 SLR(1) 文法，但不是 LR(0) 文法。

  例如 LR(0) 项目集中有：

  $I={T -> F dot, F -> F dot *}$。

  在 LR(0) 中，
  $T -> F dot$
  需要在所有终结符上归约，
  而
  $F -> F dot *$
  在读入
  $*$
  时需要移进，所以有移进-归约冲突。

  但在 SLR(1) 中，
  $T -> F$
  只在
  $"FOLLOW"(T)$
  上归约，而
  $*$
  不在
  $"FOLLOW"(T)$
  中，
  因此冲突可以消除。

  所以该文法属于 SLR(1) 文法。

]

== 判断上述文法 (2) 属于哪类 LR 文法？

#framed[
  该文法是 LR(1) 文法，但不是 LALR(1) 文法。

  在 LR(1) 项目集中，读入
  $a g$
  后有归约项目：

  $A -> g dot, d$
  和
  $B -> g dot, e$。

  读入
  $b g$
  后有归约项目：

  $B -> g dot, d$
  和
  $A -> g dot, e$。

  二者的 LR(0) 核相同，但向前看符号不同。

  若合并为 LALR(1) 项目集，则同一状态中会同时出现
  $A -> g dot$
  和
  $B -> g dot$
  在
  $d,e$
  上的归约，产生归约-归约冲突。

  因此该文法属于 LR(1) 文法，但不属于 LALR(1) 文法。

]

== 判断上述文法 (3) 属于哪类 LR 文法？

#framed[
  该文法是 LALR(1) 文法，但不是 SLR(1) 文法。

  由文法可得：

  $"FOLLOW"(A)={"EOF", b}$，
  $"FOLLOW"(B)={"EOF", b}$。

  在 LR(0) 项目集中有：

  $I={S -> x dot b, B -> x dot}$。

  其中
  $S -> x dot b$
  在读入
  $b$
  时需要移进，
  而
  $B -> x dot$
  在 SLR(1) 中要按
  $"FOLLOW"(B)$
  归约。

  因为
  $b in "FOLLOW"(B)$，
  所以 SLR(1) 分析表中出现移进-归约冲突。

  但 LR(1) 项目可以用向前看符号区分这两种情况，且合并同心项目集后不产生新冲突。

  因此该文法属于 LALR(1) 文法。

]

= 设有下列正规表达式文法：

$R -> R + R | R times R | R^* | (R) | a$

== 判定该文法具有二义性。

#framed[
  该文法具有二义性。

  以串
  $a + a + a$
  为例，它有两种不同的推导。

  一种推导为：

  $R => R + R => R + R + R => a + R + R => a + a + R => a + a + a$。

  另一种推导为：

  $R => R + R => a + R => a + R + R => a + a + R => a + a + a$。

  两种推导对应的结合方式分别为
  $(a+a)+a$
  和
  $a+(a+a)$。

  因此该文法具有二义性。

]

== 构造识别该文法的关于 LR(0) 项目有效的可归前缀的 DFA。

#framed[
  先增广文法并给产生式编号：

  $(0) quad R' -> R$

  $(1) quad R -> R + R$

  $(2) quad R -> R times R$

  $(3) quad R -> R^*$

  $(4) quad R -> (R)$

  $(5) quad R -> a$

  LR(0) 项目集族为：

  $I_0={R' -> dot R, R -> dot R + R, R -> dot R times R, R -> dot R *, R -> dot (R), R -> dot a}$。

  $I_1={R' -> R dot, R -> R dot + R, R -> R dot times R, R -> R dot *}$。

  $I_2={R -> dot R + R, R -> dot R times R, R -> dot R *, R -> dot (R), R -> (dot R), R -> dot a}$。

  $I_3={R -> a dot}$。

  $I_4={R -> R + dot R, R -> dot R + R, R -> dot R times R, R -> dot R *, R -> dot (R), R -> dot a}$。

  $I_5={R -> R times dot R, R -> dot R + R, R -> dot R times R, R -> dot R *, R -> dot (R), R -> dot a}$。

  $I_6={R -> R * dot}$。

  $I_7={R -> R dot + R, R -> R dot times R, R -> R dot *, R -> (R dot)}$。

  $I_8={R -> R + R dot, R -> R dot + R, R -> R dot times R, R -> R dot *}$。

  $I_9={R -> R times R dot, R -> R dot + R, R -> R dot times R, R -> R dot *}$。

  $I_10={R -> (R) dot}$。

  根据上述项目集族和 GOTO 函数，得到识别可归前缀的 DFA 如下：

  #align(center)[
    #image("figures/problem4_2_lr0_dfa.svg", width: 96%)
  ]

]

== 文法中部分符号的语义：

#numbering("①", 1) 非终结符号 $R$ 定义正规表达式；

#numbering("①", 2) 终结符号 $+$ 代表正规表达式运算中的或 ($|$) 运算；

#numbering("①", 3) 终结符号 $times$ 代表正规表达式运算中的连接 ($.$) 运算；

#numbering("①", 4) 终结符号 $*$ 代表正规表达式运算中的闭包 ($*$) 运算。

根据正规表达式中运算符的优先级及结合性，构造上述正规表达式文法的无冲突 SLR(1) 分析表。

#framed[
  仍使用上一问的产生式编号。

  按正规式运算的优先级和结合性处理冲突：

  $*$
  优先级最高，
  $times$
  次之，
  $+$
  最低；
  $+$
  和
  $times$
  均按左结合处理。

  因此在
  $I_8$
  中，遇到
  $+$
  时按左结合归约为
  $R + R$，
  遇到
  $times$
  或
  $*$
  时移进。

  在
  $I_9$
  中，遇到
  $+$
  或
  $times$
  时归约为
  $R times R$，
  遇到
  $*$
  时移进。

  无冲突 SLR(1) 分析表如下：

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto),
      column-gutter: 1.1em,
      row-gutter: 0.75em,
      [状态], [$a$], [$($], [$)$], [$+$], [$times$], [$*$], [$"EOF"$],
      [$0$], [$s_3$], [$s_2$], [], [], [], [], [],
      [$1$], [], [], [], [$s_4$], [$s_5$], [$s_6$], [acc],
      [$2$], [$s_3$], [$s_2$], [], [], [], [], [],
      [$3$], [], [], [$r_5$], [$r_5$], [$r_5$], [$r_5$], [$r_5$],
      [$4$], [$s_3$], [$s_2$], [], [], [], [], [],
      [$5$], [$s_3$], [$s_2$], [], [], [], [], [],
      [$6$], [], [], [$r_3$], [$r_3$], [$r_3$], [$r_3$], [$r_3$],
      [$7$], [], [], [$s_10$], [$s_4$], [$s_5$], [$s_6$], [],
      [$8$], [], [], [$r_1$], [$r_1$], [$s_5$], [$s_6$], [$r_1$],
      [$9$], [], [], [$r_2$], [$r_2$], [$r_2$], [$s_6$], [$r_2$],
      [$10$], [], [], [$r_4$], [$r_4$], [$r_4$], [$r_4$], [$r_4$],
    )
  ]

  GOTO 表中非终结符
  $R$
  的转移为：

  $0 -> 1$，
  $2 -> 7$，
  $4 -> 8$，
  $5 -> 9$。

]
