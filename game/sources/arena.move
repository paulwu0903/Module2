module game::arena;

// === Imports ===
use sui::{
    vec_map::{ Self, VecMap },
    clock::{ Clock },
    random::{ Self, Random },
};

use game::{
    role::{ Role },
    config:: { Config, AdminCap },
};


// === Structs ===
public struct Arena has key {
    id: UID,
    win_points: VecMap<ID, u64>,
    participants: VecMap<ID, Role>,
    role_owners: VecMap<ID, address>,
    is_active: bool,
}

public struct ArenaAdminCap has key, store{
    id: UID,
}

// === Errors ===
const EArenaClosed: u64 = 0;
const ETooWeak: u64 = 1;


// === Init Functions ===
fun init(ctx: &mut TxContext){
    let admin_cap = ArenaAdminCap{
        id: object::new(ctx),
    };
    transfer::public_transfer(admin_cap, ctx.sender());
}

// === Admin Entry Functions ===
entry fun new(
    _: &ArenaAdminCap,
    ctx: &mut TxContext
){
    let arena = Arena {
        id: object::new(ctx),
        win_points: vec_map::empty(),
        participants: vec_map::empty(),
        role_owners: vec_map::empty(),
        is_active: false,
    };
    transfer::share_object(arena);
}

entry fun active(
    self: &mut Arena,
    _: &ArenaAdminCap,
){
    self.is_active = true;
}

entry fun deactive(
    self: &mut Arena,
    _: &ArenaAdminCap,
){
    self.is_active = false;
}

// === Entry Function ===
entry fun list_role(
    self: &mut Arena,
    role: Role,
    clock: &Clock,
    ctx: &TxContext
){
    assert!(self.is_active, EArenaClosed);
    assert!(role.attack_points() > 0, ETooWeak);
    assert!(role.defense_points() > 0, ETooWeak);
    role.check_pending(clock);
    let id = object::id(&role);
    self.participants.insert(id, role);
    self.role_owners.insert(id, ctx.sender());

    if (!self.win_points.contains(&id)){
        self.win_points.insert(id, 0);  
    };
}

entry fun delist_role(
    self: &mut Arena,
    id: ID,
){
    assert!(self.is_active, EArenaClosed);
    let (_, role) = self.participants.remove(&id);
    let (_, owner) = self.role_owners.remove(&id);
    transfer::public_transfer(role, owner);
}

entry fun pk(
    self: &mut Arena,
    config: &Config,
    attacker_id: ID,
    defender_id: ID,
    rand: &Random,
    clock: &Clock,
    ctx: &mut TxContext,
){
    let attacker_points = self.participants.get(&attacker_id).attack_points();
    let defender_points = self.participants.get(&defender_id).defense_points();
    let total_points = attacker_points + defender_points;
    let random = gen_rand(rand, 1, total_points, ctx);
    
    if (random < attacker_points){ // attacker win 
        let (_, attacker_points) = self.win_points.remove(&attacker_id);
        self.win_points.insert(attacker_id, attacker_points + 1);
        let defender_hp = {
            let defender = self.participants.get_mut(&defender_id);
            defender.hurt();
            defender.hp()
        };
        if (defender_hp == 0){
            let (_, mut role) = self.participants.remove(&defender_id);
            role.set_pending(config, clock);
            let (_, owner) = self.role_owners.remove(&defender_id);
            transfer::public_transfer(role, owner);  
        };
    }else{ // defender win
        let (_, defender_points) = self.win_points.remove(&defender_id);
        self.win_points.insert(defender_id, defender_points + 1);
        let attacker_hp = {
            let attacker = self.participants.get_mut(&attacker_id);
            attacker.hurt();
            attacker.hp()
        };
        if (attacker_hp == 0){
            let (_, mut role) = self.participants.remove(&attacker_id);
            role.set_pending(config, clock);
            let (_, owner) = self.role_owners.remove(&attacker_id);
            transfer::public_transfer(role, owner);  
        };
    };   
}

entry fun pk_with_admin_cap(
    self: &mut Arena,
    _: &AdminCap,
    config: &Config,
    attacker_id: ID,
    defender_id: ID,
    rand: &Random,
    clock: &Clock,
    ctx: &mut TxContext,
){
    let attacker_points = self.participants.get(&attacker_id).attack_points()* 120/ 100;
    let defender_points = self.participants.get(&defender_id).defense_points();
    let total_points = attacker_points + defender_points;
    let random = gen_rand(rand, 1, total_points, ctx);
    
    if (random < attacker_points){ // attacker win 
        let (_, attacker_points) = self.win_points.remove(&attacker_id);
        self.win_points.insert(attacker_id, attacker_points + 1);
        let defender_hp = {
            let defender = self.participants.get_mut(&defender_id);
            defender.hurt();
            defender.hp()
        };
        if (defender_hp == 0){
            let (_, mut role) = self.participants.remove(&defender_id);
            role.set_pending(config, clock);
            let (_, owner) = self.role_owners.remove(&defender_id);
            transfer::public_transfer(role, owner);  
        };
    }else{ // defender win
        let (_, defender_points) = self.win_points.remove(&defender_id);
        self.win_points.insert(defender_id, defender_points + 1);
        let attacker_hp = {
            let attacker = self.participants.get_mut(&attacker_id);
            attacker.hurt();
            attacker.hp()
        };
        if (attacker_hp == 0){
            let (_, mut role) = self.participants.remove(&attacker_id);
            role.set_pending(config, clock);
            let (_, owner) = self.role_owners.remove(&attacker_id);
            transfer::public_transfer(role, owner);  
        };
    };   
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

