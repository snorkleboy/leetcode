https://leetcode.com/problems/evaluate-division/description/
https://brilliant.org/wiki/floyd-warshall-algorithm/

Equations are given in the format A / B = k, where A and B are variables represented as strings, and k is a real number (floating point number). Given some queries, return the answers. If the answer does not exist, return -1.0.

Example:
Given a / b = 2.0, b / c = 3.0. 
queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ? . 
return [6.0, 0.5, -1.0, 1.0, -1.0 ].

The input is: vector<pair<string, string>> equations, vector<double>& values, vector<pair<string, string>> queries , where equations.size() == values.size(), and the values are positive. This represents the equations. Return vector<double>.

According to the example above:

equations = [ ["a", "b"], ["b", "c"] ],
values = [2.0, 3.0],
queries = [ ["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"] ]. 
The input is always valid. You may assume that evaluating the queries will result in no division by zero and there is no contradiction.



SOLUTION

create a dictionary of dict[numerator][divisor]=result

you start off knowing some; a/a=1, b/a=1/(a/b)

then you fill up table with rule of a/c = a/b * b/c. 
if you want dict[a][x], you need a dict[a][y] and dict[y][x] to link them together

after you iterate thorugh all node pairs for all tirtiary nodes ( basically checked possible link to new dict[a][b] for all pairs), you can get anser in o(1) time using o(n^2) space.

building takes o(n^3) where n is node.

you explore 
# @param {string[][]} equations
# @param {Float[]} values
# @param {string[][]} queries
# @return {Float[]}
def calc_equation(equations, values, queries)
    dists = generateTable(equations,values)
    queries.map{|query| dists[query[0]][query[1]] || -1}
end

def generateTable(equations, values)
    table = Hash.new{|h,k| h[k] = {}}
    equations.each_with_index do |equation,i|
        table[equation[0]][equation[1]] = values[i]
        table[equation[1]][equation[0]] = 1/values[i]
        table[equation[0]][equation[0]] = table[equation[1]][equation[1]] = 1.0
    end
    keys = table.keys
    
    keys.each do |mNode|
        keys.each do |i|
            keys.each do |j|
                table[i]
                table[j]
                if ( table[i].keys.include?(mNode) && table[mNode].keys.include?(j))
                    table[i][j] = table[i][mNode] * table[mNode][j]
                end
            end
        end
    end
    table
end
