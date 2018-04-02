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
coins = [186,419,83,408]
am = 6249
coin_change(coins, am)
