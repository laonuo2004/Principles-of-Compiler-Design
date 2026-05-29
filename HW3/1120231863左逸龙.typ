#import "../problemst/pset.typ": pset, framed

#show: pset.with(
  class: "07112303",
  student: "左逸龙",
  title: "编译原理与设计 作业3",
  date: datetime.today()
)

= 设有下列文法 $G(A)$：

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.7em,
    [$A$], [$-> B C c | e D B$],
    [$B$], [$-> epsilon | b C D$],
    [$C$], [$-> D a B | c a$],
    [$D$], [$-> epsilon | d D$],
  )
]

== 计算每个候选式的 FIRST 集合，若候选式的 FIRST 集合包含 $epsilon$，计算左侧非终结符号的 FOLLOW 集合。

#framed[
  先计算各非终结符的 FIRST 集合：

  $"FIRST"(D)={epsilon,d}$；

  $"FIRST"(B)={epsilon,b}$；

  $"FIRST"(C)={a,c,d}$。

  因此各候选式的 FIRST 集合为：

  $"FIRST"(B C c)={a,b,c,d}$；

  $"FIRST"(e D B)={e}$；

  $"FIRST"(epsilon)={epsilon}$；

  $"FIRST"(b C D)={b}$；

  $"FIRST"(D a B)={a,d}$；

  $"FIRST"(c a)={c}$；

  $"FIRST"(d D)={d}$。

  其中
  $B -> epsilon$
  和
  $D -> epsilon$
  的 FIRST 集合含有
  $epsilon$，
  需要计算
  $"FOLLOW"(B)$
  和
  $"FOLLOW"(D)$。

  由产生式可得：

  $"FOLLOW"(A)={"EOF"}$；

  $"FOLLOW"(B)={a,c,d,"EOF"}$；

  $"FOLLOW"(D)={a,b,c,d,"EOF"}$。
]

== 根据计算结果，构造该文法的 LL(1) 分析表，说明该文法是否为 LL(1) 文法。

#framed[
  预测分析表如下：

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto, auto, auto, auto),
      column-gutter: 0.9em,
      row-gutter: 0.7em,
      [$ $], [$a$], [$b$], [$c$], [$d$], [$e$], [$"EOF"$],
      [$A$], [$A -> B C c$], [$A -> B C c$], [$A -> B C c$], [$A -> B C c$], [$A -> e D B$], [],
      [$B$], [$B -> epsilon$], [$B -> b C D$], [$B -> epsilon$], [$B -> epsilon$], [], [$B -> epsilon$],
      [$C$], [$C -> D a B$], [], [$C -> c a$], [$C -> D a B$], [], [],
      [$D$], [$D -> epsilon$], [$D -> epsilon$], [$D -> epsilon$], [$D -> epsilon$，$D -> d D$], [], [$D -> epsilon$],
    )
  ]

  在
  $M[D,d]$
  处同时需要填入
  $D -> epsilon$
  和
  $D -> d D$，
  出现冲突。

  因此该文法不是 LL(1) 文法。
]

= 设有下列文法 $G("program")$：

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.7em,
    [$<"program">$], [$-> "begin" <"stmt"> "end"$],
    [$<"stmt">$], [$-> d " ; " <"stmt"> | s <"tail">$],
    [$<"tail">$], [$-> epsilon | " ; " s <"tail">$],
  )
  
  *文法的 $V_T = {"begin, end, d, ;, s"}$*
]

== 构造该文法的 LL(1) 分析表。

#framed[
  由文法可得：

  $"FIRST"(<"program">)={"begin"}$；

  $"FIRST"(<"stmt">)={d,s}$；

  $"FIRST"(<"tail">)={epsilon,";"}$。

  又有
  $"FOLLOW"(<"stmt">)={"end"}$，
  $"FOLLOW"(<"tail">)={"end"}$。

  先给产生式编号：

  $(1) quad <"program"> -> "begin" <"stmt"> "end"$；

  $(2) quad <"stmt"> -> d " ; " <"stmt">$；

  $(3) quad <"stmt"> -> s <"tail">$；

  $(4) quad <"tail"> -> epsilon$；

  $(5) quad <"tail"> -> " ; " s <"tail">$。

  因此 LL(1) 分析表为：

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto, auto, auto),
      column-gutter: 1.4em,
      row-gutter: 0.7em,
      [$ $], [$"begin"$], [$d$], [$s$], [$";"$], [$"end"$],
      [$<"program">$], [$(1)$], [], [], [], [],
      [$<"stmt">$], [], [$(2)$], [$(3)$], [], [],
      [$<"tail">$], [], [], [], [$(5)$], [$(4)$],
    )
  ]
]

== 给出句子 `begind;send` 的 LL(1) 分析过程。

#framed[
  句子
  `begind;send`
  可分成记号串：

  `begin d ; s end`。

  LL(1) 分析过程如下：

  #align(center)[
    #grid(
      columns: (auto, auto, auto),
      column-gutter: 1.2em,
      row-gutter: 0.7em,
      [分析栈], [输入串], [动作],
      [`<program> EOF`], [`begin d ; s end EOF`], [$<"program"> -> "begin" <"stmt"> "end"$],
      [`begin <stmt> end EOF`], [`begin d ; s end EOF`], [匹配 `begin`],
      [`<stmt> end EOF`], [`d ; s end EOF`], [$<"stmt"> -> d " ; " <"stmt">$],
      [`d ; <stmt> end EOF`], [`d ; s end EOF`], [匹配 `d`],
      [`; <stmt> end EOF`], [`; s end EOF`], [匹配 `;`],
      [`<stmt> end EOF`], [`s end EOF`], [$<"stmt"> -> s <"tail">$],
      [`s <tail> end EOF`], [`s end EOF`], [匹配 `s`],
      [`<tail> end EOF`], [`end EOF`], [$<"tail"> -> epsilon$],
      [`end EOF`], [`end EOF`], [匹配 `end`],
      [`EOF`], [`EOF`], [接受],
    )
  ]
]

= 判断下面文法是否是 LL(1) 文法？如果不是，改写为 LL(1) 文法。

== $S -> A b | B a$, $A -> a A | a$, $B -> a$

#framed[
  该文法不是 LL(1) 文法。

  因为
  $S -> A b$
  和
  $S -> B a$
  的 FIRST 集合都含有
  $a$，
  且
  $A -> a A$
  和
  $A -> a$
  也有相同的 FIRST 集合。

  分析原文法可知，
  $A$
  产生
  $a^+$，
  所以
  $S -> A b$
  产生
  $a^+ b$；
  而
  $S -> B a$
  只能产生
  $a a$。
  原文法对应的语言为
  $a^+ b union {a a}$。

  提取左公因子并保持语言等价，可改写为：

  $S -> a T$

  $T -> b | a R$

  $R -> U | epsilon$

  $U -> a U | b$
]

== $M -> M a H | H$, $H -> b (M) | (M) | b$

#framed[
  该文法不是 LL(1) 文法。

  因为
  $M -> M a H$
  存在直接左递归，
  且
  $H -> b (M)$
  和
  $H -> b$
  都以
  $b$
  开始。

  消除左递归并提取左公因子，可改写为：

  $M -> H R$

  $R -> a H R | epsilon$

  $H -> b T | (M)$

  $T -> (M) | epsilon$
]

== $S -> A B$, $A -> B a | epsilon$, $B -> D b | D$, $D -> d | epsilon$

#framed[
  该文法不是 LL(1) 文法。

  因为
  $B -> D b$
  和
  $B -> D$
  都可能以
  $d$
  开始。
  同时
  $A -> B a$
  中
  $B$
  可推出
  $epsilon$，
  也会和
  $A -> epsilon$
  产生冲突。

  注意
  $B$
  实际上表示可选的
  $d$
  后接可选的
  $b$。
  因此可改写为：

  $S -> B R$

  $R -> a B | epsilon$

  $B -> D E, quad D -> d | epsilon, quad E -> b | epsilon$
]

== $A -> b a B | epsilon$, $B -> A b b | a$

#framed[
  该文法不是 LL(1) 文法。

  因为
  $A -> epsilon$
  需要看
  $"FOLLOW"(A)$，
  而由
  $B -> A b b$
  可知
  $b in "FOLLOW"(A)$。
  又有
  $"FIRST"(b a B)={b}$，
  所以产生冲突。

  以
  $A$
  为开始符号，可改写为：

  $A -> b a C | epsilon$

  $C -> a | b E$

  $E -> b | a C b b$
]

== $A -> B a | a$, $B -> C b | b$, $C -> A c | c$

#framed[
  该文法不是 LL(1) 文法。

  因为文法中存在间接左递归：

  $A -> B a -> C b a -> A c b a$。

  由此可得
  $A -> A c b a | c b a | b a | a$。

  消除左递归后，可改写为：

  $A -> a R | b a R | c b a R$

  $R -> c b a R | epsilon$
]
