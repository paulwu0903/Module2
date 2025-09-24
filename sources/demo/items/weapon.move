module module_2::weapon;
    
// === Imports ===
use module_2::{
    gem::{ Gem },
    config::{ Config },
};

// === Constants ===
const EGemMax: u64 = 0;
const ENoGem: u64 = 1;
const EIdxNotValid: u64 = 2;

// === Structs ===
public struct Weapon has key, store {
    id: UID, // Sui Object Id
    attack: u64,
    gems: vector<Gem>,
}


// === Public Functions ===
public fun add_gem(
    self: &mut Weapon,
    config: &Config,
    new_gem: Gem,
){
    assert!(self.gems.length() <= config.gem_amount(), EGemMax);
    self.gems.push_back(new_gem);
}

public fun remove_equipment_gem_gem(
    self: &mut Weapon,
    idx: u64,
): Gem{
    assert!(self.gems.length() > 0, ENoGem);
    let gem = self.gems.swap_remove(idx);
    gem
}

public fun switch_gem(
    self: &mut Weapon,
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
    self: &Weapon,
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

public fun attack(
    self: &Weapon,
): u64{
    self.attack
}
// === Public(Package) Functions ===
public(package) fun new(
    attack: u64,
    ctx: &mut TxContext,
): Weapon{
    Weapon {
        id: object::new(ctx),
        attack,
        gems: vector::empty<Gem>(),
    }
}
