Multiplicative persistence

From the Numberphile https://www.numberphile.com/videos/277777788888899

Uses my big number Lua library.

Recommended to run with luajit.

What I've got so far:

|base \ P(n) |2  |3   |4     |5            |6                      |7       |8                  |9        |10         |11              |12     |13     |
|------------|---|----|------|-------------|-----------------------|--------|-------------------|---------|-----------|----------------|-------|-------|
|2           |   |    |      |             |                       |        |                   |         |           |                |       |       |
|3           |22 |222 |      |             |                       |        |                   |         |           |                |       |       |
|4           |22 |333 |      |             |                       |        |                   |         |           |                |       |       |
|5           |23 |233 |33334 |444444444444 |3344444444444444444444 |        |                   |         |           |                |       |       |
|6           |23 |35  |444   |24445        |                       |        |                   |         |           |                |       |       |
|7           |24 |36  |245   |4445         |44556                  |5555555 |444555555555555666 |         |           |                |       |       |
|8           |24 |37  |256   |2777         |333555577              |        |                   |         |           |                |       |       |
|9           |25 |38  |57    |477          |45788                  |2577777 |                   |         |           |                |       |       |
|10          |25 |39  |77    |679          |6788                   |68889   |2677889            |26888999 |3778888999 |277777788888899 |       |       |
|11          |26 |3a  |69    |269          |3579                   |26778   |47788a             |67899aaa |           |                |       |       |
|12          |26 |3a  |6b    |777          |aab                    |        |                   |         |           |                |       |       |
|13          |27 |3b  |5a    |9a           |27a                    |8ac     |35ab               |9bbb     |2999bbc    |28cccccc        |       |       |
|14          |27 |3c  |5b    |99           |359                    |ccc     |359ab              |cdddd    |           |                |       |       |
|15          |28 |3d  |5e    |28c          |8ae                    |5bbb    |bbbcc              |2999bde  |           |                |       |       |
|16          |28 |3e  |5f    |bb           |2ab                    |3dde    |379bdd             |         |           |                |       |       |
|17          |29 |3f  |5g    |9f           |ce                     |3dd     |9cf                |2aff     |55ddf      |39ddgg          |degggg |       |
|18          |29 |3f  |5e    |8d           |2bb                    |2ceg    |aabf               |8gghh    |           |                |       |       |
|19          |2a |3g  |5f    |ab           |dh                     |2bc     |7bg                |dii      |4aah       |3bgii           |eefhh  |adeffh |
|20          |2a |3h  |6d    |7j           |di                     |6de     |cgg                |2bhi     |cdgg       |2degj           |77bbhj |       |

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
