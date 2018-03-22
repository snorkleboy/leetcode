https://www.hackerrank.com/challenges/coin-change/problem
In this problem you will be given a list of coin denominations and a target amount. Determine the number of ways the target amount can be arrived at using the denominations available.

Input Format

The first line contains two space-separated integers describing the respective values of  and , where:  is the number of units 
 is the number of coin types 
The second line contains  space-separated integers describing the respective values of each coin type :  (the list of distinct coins available in infinite amounts).

Constraints

Each  is guaranteed to be distinct.
Hints

Solve overlapping subproblems using Dynamic Programming (DP): 
You can solve this problem recursively but will not pass all the test cases without optimizing to eliminate the overlapping subproblems. Think of a way to store and reference previously computed solutions to avoid solving the same subproblem multiple times. * Consider the degenerate cases: 
- How many ways can you make change for  cents? - How many ways can you make change for  cents if you have no coins? * If you're having trouble defining your solutions store, then think about it in terms of the base case . - The answer may be larger than a -bit integer.

Output Format

Print a long integer denoting the number of ways we can get a sum of  from the given infinite supply of  types of coins.

Sample Input 0

4 3
1 2 3
Sample Output 0

4
Explanation 0

There are four ways to make change for  using coins with values given by :

Thus, we print  as our answer.

Sample Input 1

10 4
2 5 3 6
Sample Output 1

5
Explanation 1

There are five ways to make change for  units using coins with values given by :

Thus, we print  as our answer.
'

#first attempt. #strategy is that waysToMakeChange(total) = waysToMakeChange(total-coin.value)+1
# as in you can use a coin if it fits into the sum and you can make change of the remainder, and
# the total number of combinations is thisCoin + all the combinations to make change for the remainder

# Idea was to start start at n = 0, find n-coin for each coin (the remainder)
# if remainder is 0 then this is a new way
# otherwise the number of combinations of change for the remainder + 1 is the new number of ways
# kind of works, but it doubles up finding solutions like 2,1,1 1,1,2 .

#!/bin/ruby
class Ways1
    @ways = [0]
    def self.Num(n, c)
        c = c.select{|coin| coin<=n}
        return 0 if (c.empty?)
        for i in 1..n
            @ways[i] = self.MakeWays(i,c)
            
        p @ways
        end
        @ways[n]
    end

    def self.MakeWays(n,c)
        newWays = 0
        c.each do |coin|
            remainder = n - coin
            if (remainder == 0)
                    newWays +=  1
            elsif(remainder > 0)
                newWays += @ways[remainder] || Ways.MakeWays(remainder,c)
            end
                        p ['n',n,'newways',newWays,'coin',coin,'remainder',remainder]

        end
        return newWays
    end
end

# much simplier, forum inspired answer

# similar strategy, but has double dynamic relationship-
# waysToMakeChange(n,coin) = WaysTomakeChange(n-coin[last.value],coin[0...last])
# as in you start from two simple bases, not just one like in previous scenerio
# you start with one coin and a sum of 0 (one way to make change for 0, which is no coins)
# then you iterate up until N.

# there is one may to make change for every N with only one coin to use
# on the next coin, the number of ways of making change for n is the number of ways that previous coins could sum up to it(ways[n]), *plus the number of ways that previous coins could sum up to n-coin.value(ways[n-coin.value])* . Each combination at ways[amount-coin.value] would be a combination for ways[amount] if coin.value was pushed into each of those combination, so each way at ways[amount-coin] is an aditional way for ways[amount] from this new coin. 



def GetChangeCombos(n, c)
    ways = Array.new(n+1,0)
    ways[0] = 1
    c.select!{|c| c<n}
    return 0 if (c.empty?)
    for coin in c
        for amount in coin..n
            ways[amount] =ways[amount] + ways[amount - coin]
        end 
    end
    ways[n]
end

