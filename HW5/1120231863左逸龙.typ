#import "../problemst/pset.typ": pset, framed

#show: pset.with(
  class: "07112303",
  student: "左逸龙",
  title: "编译原理与设计 作业5",
  date: datetime.today()
)

= 设有 SDD 如下：

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 1.2em,
    row-gutter: 0.7em,
    [产生式], [语义规则],
    [$S -> B #sym.hash$], [`S.val = B.val`],
    [$B -> B_1 0$], [`B.val = 2 * B1.val`],
    [$B -> B_1 1$], [`B.val = 2 * B1.val + 1`],
    [$B -> 1$], [`B.val = 1`],
  )
]

给出 `101101` 的注释语法分析树。

#framed[
  对串
  `101101#`
  的推导为：

  $S -> B #sym.hash$

  $B -> B 1 -> B 0 1 -> B 1 0 1 -> B 1 1 0 1 -> B 0 1 1 0 1 -> 1 0 1 1 0 1$

  注释语法分析树如下：

  #align(center)[
    #image("figures/problem1_annotated_tree.svg", width: 92%)
  ]

]

= 含小数点的二进制数文法定义如下：

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.7em,
    [$S$], [$-> L . L | L$],
    [$L$], [$-> L B | B$],
    [$B$], [$-> 0 | 1$],
  )
]

== 根据上述文法设计一个 SDD，实现二进制数到十进制数的翻译，比如 `101.101` 翻译为 $5.625$。

#framed[
  可为
  $L$
  设置两个综合属性：
  `L.val`
  表示当前二进制串按整数部分计算的值，
  `L.len`
  表示位数。

  SDD 可写为：

  #align(center)[
    #grid(
      columns: (auto, 1fr),
      stroke: 0.5pt + black,
      inset: 4pt,
      align: (center, left),
      [产生式], [语义规则],
      [$S -> L_1 . L_2$], [`S.val = L1.val + L2.val / 2^L2.len`],
      [$S -> L$], [`S.val = L.val`],
      [$L -> L_1 B$], [`L.val = 2 * L1.val + B.val; L.len = L1.len + 1`],
      [$L -> B$], [`L.val = B.val; L.len = 1`],
      [$B -> 0$], [`B.val = 0`],
      [$B -> 1$], [`B.val = 1`],
    )
  ]

]

== 给出 `101.101` 翻译为 $5.625$ 的注释语法分析树。

#framed[
  注释语法分析树如下：

  #align(center)[
    #image("figures/problem2_annotated_tree.svg", width: 96%)
  ]

]

= （选做）在保证语义相同的情况下，改写 1 题中的 SDD，使文法不是左递归的。

#framed[
  改写后的文法为：

  $S -> B #sym.hash$

  $B -> 1 R$

  $R -> 0 R_1 | 1 R_1 | epsilon$

  其中
  $R$
  使用继承属性
  `R.in`
  记录已经读到的前缀值，综合属性
  `R.val`
  返回最终结果。

  对应 SDD 为：

  #align(center)[
    #grid(
      columns: (auto, 1fr),
      stroke: 0.5pt + black,
      inset: 4pt,
      align: (center, left),
      [产生式], [语义规则],
      [$S -> B #sym.hash$], [`S.val = B.val`],
      [$B -> 1 R$], [`R.in = 1; B.val = R.val`],
      [$R -> 0 R_1$], [`R1.in = 2 * R.in; R.val = R1.val`],
      [$R -> 1 R_1$], [`R1.in = 2 * R.in + 1; R.val = R1.val`],
      [$R -> epsilon$], [`R.val = R.in`],
    )
  ]

]

= 设包含有数组引用的复制表达式的 SDD 如下：

#text(size: 8pt)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    row-gutter: 0.65em,
    [产生式], [语义规则],
    [$S -> i = E ;$], [`gen(= E.place - i)`],
    [$S -> L = E ;$], [`gen([]= E.place - L.base[L.addr])`],
    [$E -> E_1 + E_2$], [`E.place=newtemp(); gen(+ E1.place E2.place E.place)`],
    [$E -> i$], [`E.place = i`],
    [$E -> L$], [`E.place=newtemp(); gen(=[] L.base[L.addr] - E.place)`],
    [$L -> i [ E ]$], [`L.base=i; L.addr=newtemp(); gen(* E.place L.elem.width L.addr)`],
    [$L -> L_1 [ E ]$], [`L.base=L1.base; L.type=L1.type; t=newtemp(); L.addr=newtemp(); gen(* E.place L.elem.width t); gen(+ L1.addr t L.addr)`],
  )
]

*说明：*

#numbering("a)", 1) `gen()` 是产生四元式代码的函数，参数依次为操作符、第一操作数、第二操作数、计算结果；

#numbering("a)", 2) `newtemp()` 是临时变量申请函数；

#numbering("a)", 3) 关于数组中用到的属性 `width` 的 SDD 如下：

#pad(left: 2em)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 1.2em,
    row-gutter: 0.7em,
    [产生式], [语义规则],
    [$D -> B i C$], [`w=B.width; i.width=C.width`],
    [$B -> "int"$], [`B.width = 4`],
    [$B -> "float"$], [`B.width = 8`],
    [$C -> epsilon$], [`C.width=w`],
    [$C -> [ "num" ] C_1$], [`C.width=num.value * C1.width; C.elem.width=C1.width`],
  )
]

#numbering("a)", 4) 语句中的数组说明：`int a[10][20], b[10][20]; c[10]。`

给出下列赋值语句的四元式代码：

== `x=a[i][j]+b[i][j]`

#framed[
  数组
  $a,b$
  为
  `int[10][20]`，
  所以第一维元素宽度为
  $80$，
  第二维元素宽度为
  $4$。

  四元式为：

  ```text
  (*, i, 80, t1)
  (*, j, 4, t2)
  (+, t1, t2, t3)
  (=[], a[t3], -, t4)
  (*, i, 80, t5)
  (*, j, 4, t6)
  (+, t5, t6, t7)
  (=[], b[t7], -, t8)
  (+, t4, t8, t9)
  (=, t9, -, x)
  ```

]

== `a[b[i][j]][c[k]]=a[i][j]`

#framed[
  先求右部
  `a[i][j]`
  的值，再求左部数组元素地址。

  四元式为：

  ```text
  (*, i, 80, t1)
  (*, j, 4, t2)
  (+, t1, t2, t3)
  (=[], a[t3], -, t4)
  (*, i, 80, t5)
  (*, j, 4, t6)
  (+, t5, t6, t7)
  (=[], b[t7], -, t8)
  (*, k, 4, t9)
  (=[], c[t9], -, t10)
  (*, t8, 80, t11)
  (*, t10, 4, t12)
  (+, t11, t12, t13)
  ([]=, t4, -, a[t13])
  ```

]

= 设有布尔表达式以及条件语句的 SDD 如下：

#text(size: 7.5pt)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.55em,
    [产生式], [语义规则],
    [$B -> E$], [`B.true=makelist(nextinstr); B.false=makelist(nextinstr+1); gen(J_T E.PLACE - 0); gen(J_F E.PLACE - 0)`],
    [$B -> E_1 == E_2$], [`B.PLACE=NEWTEMP; gen(== E1.PLACE E2.PLACE B.PLACE); B.true=makelist(nextinstr); B.false=makelist(nextinstr+1); gen(J_T B.PLACE - 0); gen(J_F B.PLACE - 0)`],
    [$B -> ! B_1$], [`B.true=B1.false; B.false=B1.true`],
    [$B -> ( B_1 )$], [`B.true=B1.true; B.false=B1.false`],
    [$B -> B_1 || M B_2$], [`backpatch(B1.false, M.instr); B.true=merge(B1.true, B2.true); B.false=B2.false`],
    [$B -> B_1 && M B_2$], [`backpatch(B1.true, M.instr); B.true=B2.true; B.false=merge(B1.false, B2.false)`],
    [$S -> "if" (B) M_1 S_1 N "else" M_2 S_2$], [`backpatch(B.true, M1.instr); backpatch(B.false, M2.instr); S.next=merge(S1.next, N.next, S2.next)`],
    [$S -> "while" M_1 (B) M_2 S_1$], [`backpatch(S1.next, M1.instr); backpatch(B.true, M2.instr); S.next=B.false; gen(J - - M1.instr)`],
    [$M -> epsilon$], [`M.instr=nextinstr`],
    [$N -> epsilon$], [`N.next=makelist(nextinstr); gen(J - - 0)`],
    [$S -> { L }$], [`S.next=L.next`],
    [$S -> i = E ;$], [`S.next=null`],
    [$L -> L_1 M S$], [`backpatch(L1.next, M.instr); L.next=S.next;`],
    [$L -> S$], [`L.next=S.next`],
  )
]

*SDD 的说明：*

#numbering("a)", 1) 四元式编号作为跳转地址使用。

#numbering("a)", 2) 函数 `makelist(x)` 表示出现了标号的引用时不知道地址的情况，函数参数 `x` 为标号的使用位置，单遍处理生成中间代码需要使用拉链-返填技术，假设通过标号表记录相关信息，此处为标号的引用出现，按标号引用记录入标号表。

#numbering("a)", 3) 函数 `backpatch(x,y)` 表示标号 `x` 的定义位置在 `y`，需要返填标号 `x` 的使用位置。

#numbering("a)", 4) 函数 `merge(x,y,z,...)` 表示标号 `x,y,z,...` 合并为一个标号。

#numbering("a)", 5) `nextinstr` 表示下一条四元式的编号。

*有程序段：*

```pascal
if (a==b&&(c==d||e==f))
    {while(!(x==y))
        x=x+y;
        s=x;}
else
    s=y;
z=s;
```

*问题：*

== 给出该程序段的语法分析树（表达式 $E$ 结构使用 4 题的）。

#framed[
  语法分析树如下：

  #align(center)[
    #image("figures/problem5_syntax_tree.svg", width: 96%)
  ]

]

== 给出该程序段语义处理后的四元式形式的目标代码（代码中的表达式 $E$ 结构使用 4 题的 SDD）。

#framed[
  四元式编号从
  $1$
  开始：

  ```text
  (1)  (==, a, b, t1)
  (2)  (J_T, t1, -, 4)
  (3)  (J_F, t1, -, 18)
  (4)  (==, c, d, t2)
  (5)  (J_T, t2, -, 10)
  (6)  (J_F, t2, -, 7)
  (7)  (==, e, f, t3)
  (8)  (J_T, t3, -, 10)
  (9)  (J_F, t3, -, 18)
  (10) (==, x, y, t4)
  (11) (J_T, t4, -, 16)
  (12) (J_F, t4, -, 13)
  (13) (+, x, y, t5)
  (14) (=, t5, -, x)
  (15) (J, -, -, 10)
  (16) (=, x, -, s)
  (17) (J, -, -, 19)
  (18) (=, y, -, s)
  (19) (=, s, -, z)
  ```

]

== 给出该程序段语义处理后的拉链-返填使用的标号表。

标号表按以下示例内容填写：

#align(center)[
  #grid(
    columns: (auto, auto, auto),
    column-gutter: 1.2em,
    row-gutter: 0.7em,
    [标号名], [定义否（1/0）], [返填顺序],
    [$L_i$], [$1$], [⑤$->$②$->$①],
    [...], [], [],
  )
]

#framed[
  #align(center)[
    #grid(
      columns: (auto, auto, auto),
      stroke: 0.5pt + black,
      inset: 4pt,
      align: (center, center, left),
      [标号名], [定义否（1/0）], [返填顺序],
      [$L_1=4$], [$1$], [②],
      [$L_2=18$], [$1$], [③$->$⑨],
      [$L_3=7$], [$1$], [⑥],
      [$L_4=10$], [$1$], [⑤$->$⑧],
      [$L_5=16$], [$1$], [⑪],
      [$L_6=13$], [$1$], [⑫],
      [$L_7=19$], [$1$], [⑰],
    )
  ]

]
