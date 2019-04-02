Multiplicative persistence

From the Numberphile https://www.numberphile.com/videos/277777788888899

Uses my big number Lua library.

Recommended to run with luajit.

What I've got so far:

|P(n) |n               |
|-----|----------------|
|1    |2               |
|2    |25              |
|3    |39              |
|4    |77              |
|5    |679             |
|6    |6788            |
|7    |68889           |
|8    |2677889         |
|9    |26888999        |
|10   |3778888999      |
|11   |277777788888899 |
|12   |                |


Results of ./run.lua build, only showing the successively smaller solutions per-persistence of m = 2^a * 3^b * 5^c * 7^d.
From this we can claim n = 2...23...35...57...7, where 2's appear a times, 3's appear b times, 5's appear c times and 7's appear d times.
We can also compact these digits, replacing every set of 222 with 8 and every set of 33 with 9, and every 23 with 6.
From there we can sort these digits and find the smallest number whose multiplicative persistent number is one greater from the constructed number.

|a  |b  |c  |d  |P(m) |2^a * 3^b * 5^c * 7^d |2...23...35...57...7          |smallest form:    |
|---|---|---|---|-----|----------------------|------------------------------|------------------|
|0  |0  |0  |0  |1    |1                     |1                             |1                 |
|0  |0  |0  |2  |3    |49                    |77                            |77                |
|0  |0  |1  |1  |2    |35                    |57                            |57                |
|0  |0  |2  |0  |2    |25                    |55                            |55                |
|1  |0  |0  |3  |4    |686                   |2777                          |2777              |
|1  |3  |0  |1  |4    |378                   |23337                         |679               |
|0  |3  |0  |4  |6    |64827                 |3337777                       |377779            |
|2  |5  |0  |2  |6    |47628                 |223333377                     |267799            |
|7  |1  |0  |1  |5    |2688                  |222222237                     |6788              |
|1  |10 |0  |1  |7    |826686                |233333333337                  |2999997           |
|8  |3  |0  |2  |7    |338688                |2222222233377                 |2677889           |
|10 |3  |0  |0  |6    |27648                 |2222222222333777777           |67777778889       |
|1  |2  |0  |12 |8    |249143169618          |233777777777777               |27777777777779    |
|6  |6  |0  |5  |8    |784147392             |22222233333377777             |7777788999        |
|11 |7  |0  |0  |8    |4478976               |222222222223333333            |26888999          |
|12 |7  |0  |2  |9    |438939648             |222222222222333333377         |3778888999        |
|4  |20 |0  |5  |10   |937638166841712       |22223333333333333333333377777 |27777789999999999 |
|19 |4  |0  |6  |10   |4996238671872         |22222222222222222223333777777 |277777788888899   |

Checked up to a+b+c+d <= 462 so far.
