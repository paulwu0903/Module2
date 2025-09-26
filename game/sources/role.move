module game::role;

// === Imports ===
use std::{
    string::{ String },
};

use sui::{
    clock::{ Clock },
};
use game::{
    chest::{ Chest },
    head::{ Head },
    legs::{ Legs },
    shoes::{ Shoes },
    weapon::{ Weapon },
    config::{ Config },
};

// === Errors ===
const EPending: u64 = 0;

// === Structs ===
public struct Role has key, store{
    id: UID, // Sui Object Id
    name: String,
    sex: bool, // true: Man, false: Woman
    birth: u64,
    hp: u64,
    chest: Option<Chest>,
    legs: Option<Legs>,
    shoes: Option<Shoes>,
    head: Option<Head>,
    weapon: Option<Weapon>,
    pending_to: u64,
}


// === Entry Functions ===
entry fun new(
    config: &Config,
    name: String,
    sex: bool,
    clock: &Clock,
    ctx: &mut TxContext,
){
    let role = Role{
        id: object::new(ctx),
        name,
        sex,
        birth: clock.timestamp_ms(),
        hp: config.init_hp(),
        chest: option::none(),
        legs: option::none(),
        shoes: option::none(),
        head: option::none(),
        weapon:option::none(),
        pending_to: clock.timestamp_ms(),
    };
    transfer::transfer(role, ctx.sender());
}

// === Public Functions ===
#[allow(lint(self_transfer))]
public fun fill_chest(
    self: &mut Role, 
    new_chest: Chest, 
    ctx: &mut TxContext
){
    if (self.chest.is_none()){
        self.chest.fill(new_chest);
    }else{ // some
        let chest = self.chest.extract();
        self.chest.fill(new_chest);
        transfer::public_transfer(chest, ctx.sender());
    };
}
#[allow(lint(self_transfer))]
public fun fill_shoes(
    self: &mut Role, 
    new_shoes: Shoes, 
    ctx: &mut TxContext
){
    if (self.shoes.is_none()){
        self.shoes.fill(new_shoes);
    }else{ // some
        let shoes = self.shoes.extract();
        self.shoes.fill(new_shoes);
        transfer::public_transfer(shoes, ctx.sender());
    };
}
#[allow(lint(self_transfer))]
public fun fill_head(
    self: &mut Role, 
    new_head: Head, 
    ctx: &mut TxContext
){
    if (self.head.is_none()){
        self.head.fill(new_head);
    }else{ // some
        let head = self.head.extract();
        self.head.fill(new_head);
        transfer::public_transfer(head, ctx.sender());
    };
}
#[allow(lint(self_transfer))]
public fun fill_legs(
    self: &mut Role, 
    new_legs: Legs, 
    ctx: &mut TxContext
){
    if (self.legs.is_none()){
        self.legs.fill(new_legs);
    }else{ // some
        let legs = self.legs.extract();
        self.legs.fill(new_legs);
        transfer::public_transfer(legs, ctx.sender());
    };
}
#[allow(lint(self_transfer))]
public fun fill_weapon(
    self: &mut Role, 
   new_weapon: Weapon, 
    ctx: &mut TxContext
){
    if (self.weapon.is_none()){
        self.weapon.fill(new_weapon);
    }else{ // some
        let weapon = self.weapon.extract();
        self.weapon.fill(new_weapon);
        transfer::public_transfer(weapon, ctx.sender());
    };
}

// === Public View Functions ===
public fun attack_points(
    self: &Role,
): u64{
    if (self.weapon.is_none()){
        0
    }else{ //some
        let total_extra = self.weapon.borrow().total_extra();
        let attack = self.weapon.borrow().attack() + total_extra;
        attack
    }
}

public fun defense_points(
    self: &Role,
): u64{
    let chest_defense = if (self.chest.is_none()){
        0
    }else{ //some
        let total_extra = self.chest.borrow().total_extra();
        let defense = self.chest.borrow().defense() + total_extra;
        defense
    };

    let shoes_defense = if (self.shoes.is_none()){
        0
    }else{ //some
        let total_extra = self.shoes.borrow().total_extra();
        let defense = self.shoes.borrow().defense() + total_extra;
        defense
    };

    let head_defense = if (self.head.is_none()){
        0
    }else{ //some
        let total_extra = self.head.borrow().total_extra();
        let defense = self.head.borrow().defense() + total_extra;
        defense
    };

    let legs_defense = if (self.legs.is_none()){
        0
    }else{ //some
        let total_extra = self.legs.borrow().total_extra();
        let defense = self.legs.borrow().defense() + total_extra;
        defense
    };

    let total_defense = chest_defense + shoes_defense + head_defense + legs_defense;
    total_defense
}

public fun pending_to(
    self: &Role,
):u64{
    self.pending_to
}

public fun hp(
    self: &Role
): u64{
    self.hp
}


// === Public(Package) Functions ===
public(package) fun hurt(
    self: &mut Role,
){
    self.hp = self.hp - 10;
}

public(package) fun set_pending(
    self: &mut Role,
    config: &Config,
    clock: &Clock,
){
    self.pending_to = clock.timestamp_ms() + config.recovery_time();
}

public(package) fun recover(
    self: &mut Role,
    config: &Config,
    clock: &Clock,
){
    assert!(self.pending_to <= clock.timestamp_ms(), EPending);
    self.hp = config.init_hp();
} 

public(package) fun check_pending(
    self: &Role,
    clock: &Clock
){ 
    assert!(self.pending_to <= clock.timestamp_ms(), EPending);  
}

// === Private Functions ===