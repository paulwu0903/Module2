module game::gem;

// === Structs ===
public struct Gem has key, store{
    id: UID, // Sui Object Id
    extra: u64,
}

// === Public(Package) Functions ===
public(package) fun new(
    extra: u64,
    ctx: &mut TxContext,
): Gem{
    Gem { 
        id: object::new(ctx), 
        extra,
    }
}

// === Public View Functions ===
public fun extra(
    self: &Gem
): u64{
    self.extra
}
