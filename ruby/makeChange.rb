solution 1
kinda works 50/180
wrong answers on
# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change(coins, amount)
    coins.sort!
    num_coins = false
    while (coins.length > 0)
        num_coins = [num_coins,fill_purse(coins[0..-1],amount),fill_purse(coins[0..-2],amount)].select{|val| val}.min
        coins = coins[0..-3]
    end
    num_coins || -1
end

def fill_purse(coins, amount)
    num_coins = 0 
    while (amount > 0 && coins.length > 0)
        curr_coin = coins.pop
        if (curr_coin  <= amount)
            num_coins += amount/curr_coin
            amount = amount%curr_coin
        end
    end
    return amount == 0 ? num_coins : false 
end


solution 2:
dp, right answers, fails time wise. Might be probelm with ruby/java (which official solution is written in)


# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}

def coin_change(coins, amount)
    best_change_for_amount = [0]
    if (coins.empty? or amount < 0)
        return -1
    end
    if (amount == 0)
        return 0
    end

    filler(coins,amount,best_change_for_amount) || -1
    
end

def filler(coins,amount,best_change_for_amount)
    return best_change_for_amount[amount] if (best_change_for_amount[amount])
    best_num = false
    coins.each do |coin|
        with_coin = false
        if (amount >= coin)
            with_coin = best_change_for_amount[amount-coin] || filler(coins,amount-coin,best_change_for_amount)
            with_coin += 1 if (with_coin) 
        end
        best_num = [best_num,with_coin].select{|val| val}.min 
        
    end
    best_change_for_amount[amount] = best_num
end

