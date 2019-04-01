Multiplicative persistence

From the Numberphile https://www.numberphile.com/videos/277777788888899

Uses my big number Lua library.

Recommended to run with luajit.

What I've got so far:

| P(n)  | n               |
|-------|-----------------|
| 1     | 2               |
| 2     | 25              |
| 3     | 39              |
| 4     | 77              |
| 5     | 679             |
| 6     | 6788            |
| 7     | 68889           |
| 8     | 2677889         |
| 9     | 26888999        |
| 10    | 3778888999      |
| 11    | 277777788888899 |
| 12    |                 |


results of ./run.lua build (which only shows successively lower solutions per-persistence of 2^a * 3^b * 5^c * 7^d)

a	b	c	d	n	2^a * 3^b * 5^c * 7^d
0	0	0	0	1	1
0	0	0	2	3	49
0	0	1	1	2	35
0	0	2	0	2	25
1	0	0	3	4	686
1	3	0	1	4	378
0	3	0	4	6	64827
2	5	0	2	6	47628
7	1	0	1	5	2688
1	10	0	1	7	826686
8	3	0	2	7	338688
10	3	0	0	6	27648
1	2	0	12	8	249143169618
6	6	0	5	8	784147392
11	7	0	0	8	4478976
12	7	0	2	9	438939648
4	20	0	5	10	937638166841712
19	4	0	6	10	4996238671872

Checked up to a+b+c+d=n <= 446 so far.
