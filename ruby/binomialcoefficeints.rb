# Dynamic Programming | Set 9 (Binomial Coefficient)
# 2.5
# Following are common definition of Binomial Coefficients.
# 1) A binomial coefficient C(n, k) can be defined as the coefficient of X^k in the expansion of (1 + X)^n.

# 2) A binomial coefficient C(n, k) also gives the number of ways, disregarding order, that k objects can be chosen from among n objects; more formally, the number of k-element subsets (or k-combinations) of an n-element set.

# The Problem
# Write a function that takes two parameters n and k and returns the value of Binomial Coefficient C(n, k). For example, your function should return 6 for n = 4 and k = 2, and it should return 10 for n = 5 and k = 2.

# Recommended: Please solve it on “PRACTICE” first, before moving on to the solution.
# 1) Optimal Substructure
# The value of C(n, k) can be recursively calculated using following standard formula for Binomial Coefficients.

#    C(n, k) = C(n-1, k-1) + C(n-1, k)
#    C(n, 0) = C(n, n) = 1

class BinCoef 
    def initialize()
        @ans=[[1]]
    end

    def build(n,k)
        for i in (0..n)
            for j in (0..[i,k].min)
                p i,j
                if (j == 0 || j == i)
                    p @ans,i == j
                    @ans[i][j] = 1
                else
                    p 'here2',@ans
                    @ans[i][j] = @ans[i-1][j-1] + @ans[i-1][j]
                end
            end
        end
        return @ans[n][k]
    end
end
a=BinCoef.new()
a.build(4,2)