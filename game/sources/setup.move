module game::setup;

use game::{
    arena::{ Self, ArenaAdminCap },
};


// === Admin Functions ===
public fun setup(
    cap: &ArenaAdminCap,
    ctx: &mut TxContext,
){
    let mut arena = arena::new_(cap, ctx);
    arena.active_();
    arena.share_object_();
}