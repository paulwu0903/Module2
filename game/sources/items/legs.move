module game::legs;
    
// === Imports ===
use game::{
    gem::{ Gem },
    config::{ Config },
};


// === Constants ===
const EGemMax: u64 = 0;
const ENoGem: u64 = 1;
const EIdxNotValid: u64 = 2;

// === Structs ===
public struct Legs has key, store {
    id: UID, // Sui Object Id
    defense: u64,
    gems: vector<Gem>,
}

// === Public Functions ===
public fun add_gem(
    self: &mut Legs,
    config: &Config,
    new_gem: Gem,
){
    assert!(self.gems.length() < config.gem_amount(), EGemMax);
    self.gems.push_back(new_gem);
}

public fun remove_equipment_gem_gem(
    self: &mut Legs,
    idx: u64,
): Gem{
    assert!(self.gems.length() > 0, ENoGem);
    let gem = self.gems.swap_remove(idx);
    gem
}

public fun switch_gem(
    self: &mut Legs,
    idx: u64,
    new_gem: Gem,
): Gem{
    assert!(self.gems.length() > 0, ENoGem);
    assert!(idx < self.gems.length(), EIdxNotValid);
    let gem = self.gems.swap_remove(idx);
    self.gems.push_back(new_gem);
    gem
}
// === Public View Functions ===
public fun total_extra(
    self: &Legs,
): u64{
    if (self.gems.length() == 0){
        0  
    }else{ // some
        let mut res = 0;
        let mut idx = 0;
        while(idx < self.gems.length()){
            res = res + self.gems.borrow(idx).extra();
            idx = idx + 1;
        };  
        res
    }
}

public fun defense(
    self: &Legs,
): u64{
    self.defense
}
// === Public(Package) Functions ===
public(package) fun new(
    defense: u64,
    ctx: &mut TxContext,
): Legs{
    Legs {
        id: object::new(ctx),
        defense,
        gems: vector::empty<Gem>(),
    }
}
