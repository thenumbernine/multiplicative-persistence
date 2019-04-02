Multiplicative persistence

From the Numberphile https://www.numberphile.com/videos/277777788888899

Uses my big number Lua library.

Recommended to run with luajit.

What I've got so far:

|P(n) \ base |2 |3   |4   |5                      |6     |7                  |8         |9       |10              |11       |12  |13       |14    |15      |16     |17     |18    |19     |20     |
|------------|--|----|----|-----------------------|------|-------------------|----------|--------|----------------|---------|----|---------|------|--------|-------|-------|------|-------|-------|
|2           |  |22  |22  |23                     |23    |24                 |24        |25      |25              |26       |26  |27       |27    |28      |28     |29     |29    |2a     |2a     |
|3           |  |222 |333 |233                    |35    |36                 |37        |38      |39              |3a       |3a  |3b       |3c    |3d      |3e     |3f     |3f    |3g     |3h     |
|4           |  |    |    |33334                  |444   |245                |256       |57      |77              |69       |6b  |5a       |5b    |5e      |5f     |5g     |5e    |5f     |6d     |
|5           |  |    |    |444444444444           |24445 |4445               |2777      |477     |679             |269      |777 |9a       |99    |28c     |bb     |9f     |8d    |ab     |7j     |
|6           |  |    |    |3344444444444444444444 |      |44556              |333555577 |45788   |6788            |3579     |aab |27a      |359   |8ae     |2ab    |ce     |2bb   |dh     |di     |
|7           |  |    |    |                       |      |5555555            |          |2577777 |68889           |26778    |    |8ac      |ccc   |5bbb    |3dde   |3dd    |2ceg  |2bc    |6de    |
|8           |  |    |    |                       |      |444555555555555666 |          |        |2677889         |47788a   |    |35ab     |359ab |bbbcc   |379bdd |9cf    |aabf  |7bg    |cgg    |
|9           |  |    |    |                       |      |                   |          |        |26888999        |67899aaa |    |9bbb     |cdddd |2999bde |       |2aff   |8gghh |dii    |2bhi   |
|10          |  |    |    |                       |      |                   |          |        |3778888999      |         |    |2999bbc  |      |        |       |55ddf  |      |4aah   |cdgg   |
|11          |  |    |    |                       |      |                   |          |        |277777788888899 |         |    |28cccccc |      |        |       |39ddgg |      |3bgii  |2degj  |
|12          |  |    |    |                       |      |                   |          |        |                |         |    |         |      |        |       |degggg |      |eefhh  |77bbhj |
|13          |  |    |    |                       |      |                   |          |        |                |         |    |         |      |        |       |       |      |adeffh |       |

This post has some other good information on searches: https://www.reddit.com/r/askmath/comments/b60mhl/why_are_the_search_spaces_for_multiplicative/

This tool is also being used to search for a persistence-12 in base 10, which has not yet been found.
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
