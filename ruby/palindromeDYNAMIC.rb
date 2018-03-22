#finds palindromes from each index
#every subpalindrome is a substring thats a palindrome
#searches for odd and even palindromes by passing in 2 stating indexs

#leet rank says this is dyamic programming becuase 

# @param {String} s
# @return {Integer}
def count_substrings(s)
    count = 0
    for i in (0...s.length)
        count += getPalindromes(s,i,i)
        count += getPalindromes(s,i,i+1)
    end
    count
end

def getPalindromes(s,i,j)
    palinLength = 0
    left = s[i-palinLength]
    right = s[j+palinLength]
    while (left && right && left == right)
        palinLength += 1
        left = s[i-palinLength]
        right = s[j+palinLength]
    end
    p palinLength
    palinLength
end
