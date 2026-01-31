# Game

## Objects
* Random
```
0x8
```
* Clock
```
0x6
```
* TreasureBox
```
0xf99db3b78fc02c1aa8c3284d443bcc25c3cc8f2bcd670b53e48fa7faf3215538
```
* Config
```
0x366e2806be63b698b3a204498ad6e085d1e8a6f396a82ad74d0b1f11c68138dc
```
* ArenaAdminCap
```
0xfaedafe882a29ce43e2f905c10f8115e579fb51219d7d8786e620fb49e95ee34
```
* Arena
```
0xea3bbe7c1fddfb2194b364342bb1c00c000b1eae833c2c7deb99dcc32562d7f5
```

# Sui CLI 執行合約 Function 指令:
```shell=
sui client call --package <PackageId> --module <ModuleName> --function <FunctionName> --args (<param>)* --typeargs (<type>*) 
```

## Ex: 建立 Role 
```
sui client call --package <Package Id> --module role --function new --args <Config Object Id> <自訂角色名> <true: man, false: woman> <Clock Object Id>
```

```rust=
entry fun new(
    config: &Config,
    name: String,
    sex: bool,
    clock: &Clock,
    ctx: &mut TxContext,
){
    ...
}
```


## Ex: 打獵(Weapon)
```
sui client call --package <Package Id> --module wilderness --function hunt_for_weapon --args <Role Object Id> <Random Object Id>
```

```rust=
entry fun hunt_for_weapon(
    _: &Role,
    rand: &Random,
    ctx: &mut TxContext
){
    ...
}
```

## Ex: 鑲嵌寶石(Weapon)
```
sui client call --package <Package ID> --module weapon --function add_gem --args <Weapon Object Id> <Config Object Id> <Gem Object Id>
```

```rust=
public fun add_gem(
    self: &mut Weapon,
    config: &Config,
    new_gem: Gem,
){
    ...
}
```

## Ex: 穿裝備(Weapon)
```
sui client call --package <Package Id> --module role --function fill_weapon --args <Role Object Id> <Weapon Object Id> 
```

```rust=
public fun fill_weapon(
    self: &mut Role, 
   new_weapon: Weapon, 
    ctx: &mut TxContext
){
    ...
}
```

## Ex: 參加競技場
```
sui client call --package <Package Id> --module arena --function list_role --args <Arena Object Id> <Role Object Id> <Clock Object Id>
```

```rust=
entry fun list_role(
    self: &mut Arena,
    role: Role,
    clock: &Clock,
    ctx: &TxContext
){
    ...
}
```

## Ex: 退出競技場
```
sui client call --package <Package Id> --module arena --function delist_role --args <Arena Object Id> <Role Object Id>
```

```rust=
entry fun delist_role(
    self: &mut Arena,
    id: ID,
){
    ...
}
```

##Ex: PK
```
sui client call --package <Package Id> --module arena --function pk --args <Arena Object Id> <Config Object Id> <Attacker Role Object Id> <Defender Role Object Id> <Random Object Id> <Clock Object Id>
```

```rust=
entry fun pk(
    self: &mut Arena,
    config: &Config,
    attacker_id: ID,
    defender_id: ID,
    rand: &Random,
    clock: &Clock,
    ctx: &mut TxContext,
){
    ...
}
```