module game::wilderness;

// === Imports ===
use sui::{
    random:: { Self, Random },
};

use game::{
    chest::{ Self },
    gem::{ Self },
    shoes::{ Self },
    head::{ Self },
    legs::{ Self },
    weapon::{ Self },
    role::{ Role },
};

// === Constants ===


// === Structs ===
public struct Wilderness has key, store{
    id: UID, // Sui Object Id
}


// === Entry Functions ===
entry fun hunt_for_chest(
    _: &Role,
    rand: &Random,
    ctx: &mut TxContext
){
    let defense = gen_rand(rand, 1, 100, ctx);
    let chest = chest::new(defense, ctx);
    transfer::public_transfer(chest, ctx.sender());
}

entry fun hunt_for_shoes(
    _: &Role,
    rand: &Random,
    ctx: &mut TxContext
){
    let defense = gen_rand(rand, 1, 100, ctx);
    let shoes = shoes::new(defense, ctx);
    transfer::public_transfer(shoes, ctx.sender());
}

entry fun hunt_for_weapon(
    _: &Role,
    rand: &Random,
    ctx: &mut TxContext
){
    let attack = gen_rand(rand, 1, 400, ctx);
    let weapon = weapon::new(attack, ctx);
    transfer::public_transfer(weapon, ctx.sender());
}

entry fun hunt_for_head(
    _: &Role,
    rand: &Random,
    ctx: &mut TxContext
){
    let defense = gen_rand(rand, 1, 100, ctx);
    let head = head::new(defense, ctx);
    transfer::public_transfer(head, ctx.sender());
}

entry fun hunt_for_legs(
    _: &Role,
    rand: &Random,
    ctx: &mut TxContext
){
    let defense = gen_rand(rand, 1, 100, ctx);
    let legs = legs::new(defense, ctx);
    transfer::public_transfer(legs, ctx.sender());
}

entry fun hunt_for_gem(
    _: &Role,
    rand: &Random,
    ctx: &mut TxContext
){
    let extra = gen_rand(rand, 1, 30, ctx);
    let gem = gem::new(extra, ctx);
    transfer::public_transfer(gem, ctx.sender());
}

// === Private Functions ===
fun gen_rand(
    rand: &Random, 
    min: u64,
    max: u64,
    ctx: &mut TxContext
):u64{
    let mut generator = random::new_generator(rand, ctx);
    let rand_num = random::generate_u64_in_range(&mut generator, min, max);
    rand_num
}