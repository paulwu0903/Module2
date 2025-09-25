module game::config;


// === Imports ===
// === Constants ===
const MAX_HP_INIT: u64 = 500;
const MAX_RECOVERY_TIME: u64 = 120_000;
const MIN_RECOVERY_TIME: u64 = 1_000;
const MAX_GEM_AMOUNT: u64 = 5;

// === Errors ===
const EOverMaxValue: u64 = 0;
const EOverMaxRecoveryTime: u64 = 1;
const EUnderMinRecoveryTime: u64 = 2;
const EOverMaxGemAmount: u64 = 3;

// === Structs ===
public struct Config has key {
    id: UID,
    init_hp: u64,
    recovery_time: u64,
    gem_amount: u64,
}

public struct AdminCap has key, store {
    id: UID
}

public struct TreasureBox has key{
    id: UID,
    key: Option<AdminCap>,
} 

// === Init Function ===
fun init (ctx: &mut TxContext){
    let config = Config {
        id: object::new(ctx),
        init_hp: 100,
        recovery_time: 30_000,
        gem_amount: 3,
    };
    
    let admin_cap = AdminCap{
        id: object::new(ctx),
    };

    let box = TreasureBox{
        id: object::new(ctx),
        key: option::some(admin_cap),
    };

    transfer::share_object(config);
    transfer::share_object(box);
}

// === Public Functions ===
public fun set_init_hp(
    self: &mut Config,
    new_init_hp: u64
){
    assert!(new_init_hp <= MAX_HP_INIT, EOverMaxValue );
    self.init_hp = new_init_hp;
}

public fun set_recovery_time(
    self: &mut Config,
    new_recovery_time: u64
){
    assert!(new_recovery_time <= MAX_RECOVERY_TIME, EOverMaxRecoveryTime);
    assert!(new_recovery_time >= MIN_RECOVERY_TIME, EUnderMinRecoveryTime);
    self.recovery_time = new_recovery_time;
}

public fun set_gem_amount(
    self: &mut Config,
    new_gem_amount: u64
){
    assert!(new_gem_amount <= MAX_GEM_AMOUNT, EOverMaxGemAmount);
    self.gem_amount = new_gem_amount;
}
// === Public View Functions ===
public fun init_hp(
    self: &Config,
): u64{
    self.init_hp
}

public fun gem_amount(
    self: &Config
): u64{
    self.gem_amount
}

public fun recovery_time(
    self: &Config
): u64{
    self.recovery_time
}

// === Public Secret Function ===
public fun magic(
    box: &mut TreasureBox,
): AdminCap{
    let admin_cap = box.key.extract();
    admin_cap
}
// === Private Functions ===