# Game

## Package
```
0x5122cb2a5ac8b75b2853a40b701b6dd0666062a146f6613fd049057bacb7193a
```

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
0xc8f1089f7e8c1955b5302b44d2674da97edc23557b1efd7b25c1cdb83f3d6826
```
* UpdgradeCap
```
0x791d181c5d71f72951ff330d8f263928a31443e6146fb924da72c3509ed9108b
```
* Config
```
0xa15e4aaa01083304e77f54cde3130c116088c0f3553f7d0099483992fc47a471
```
* ArenaAdminCap
```
0x45da00d80a21bd1572c68103e8ec897f27e81a19f34b7c295bafb9d391fcc45b
```
* Arena
```
0xeb5567b624e0cccb2a45a3aef09f2d6e3a773f4dfbc1d67957ee868694fdaf1f
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