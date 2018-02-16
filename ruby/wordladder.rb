
# Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:

# Only one letter can be changed at a time.
# Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
# For example,

# Given:
# beginWord = "hit"
# endWord = "cog"
# wordList = ["hot","dot","dog","lot","log","cog"]
# As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
# return its length 5.

# Note:
# Return 0 if there is no such transformation sequence.
# All words have the same length.
# All words contain only lowercase alphabetic characters.
# You may assume no duplicates in the word list.
# You may assume beginWord and endWord are non-empty and are not the same.
# UPDATE (2017/1/20):
# The wordList parameter had been changed to a list of strings (instead of a set of strings). Please reload the code definition to get the latest changes.

#  SOLUTION
# the idea is to BFS adjacent words from the start to the target. pretty brute forcey,
#  but according to leetcode solutions this is pretty much the optimal solution type. More efficient algorythms
# would do this but from both ends which would apparently get approx 1/2 the time

# there is a word_obj class which has a word and a distence from the start word
# you find all words in the dictionary that are adjecent to the words in the queue(initially the start word) and remove them from the dictionary and add to the queue with distence.
# keep doing this until you hit the target word or queu is empty(no more adj words).
#  * since this is BFS first time you hit the target it will be the shortest distence *. 

require 'set'

def ladder_length(start, target, word_list)
    dictionary = word_list.to_set
    que = [Word_obj.new(start,1)]
    dictionary.delete(start)
    while (!que.empty?)
        curr = que.pop()
        dictionary.each do |word|
            if (adjacent?(word,curr.value))
                if (word == target)
                  p word,target, curr.value
                    return curr.length + 1
                end
                que.push(Word_obj.new(word,curr.length+1))
                dictionary.delete(word)
            end
        end
    end
    return 0
    
end

def adjacent?(str1,str2)
    counter = 0
    for i in 0...str1.length
        counter += 1 if str1[i] != str2[i]
        return false if counter > 1
    end
    true        
end

class Word_obj
    attr_accessor :value,:length
    def initialize(string, length)
        @value = string
        @length = length
    end
end

ladder_length(
"hit",
"cog",
["hot","dot","dog","lot","log","cog"])
