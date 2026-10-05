# Minecraft 服务器管理必备命令大全

> [!TIP]
> 本文只讲 **Java 版原版命令**，不需要装任何插件或 mod，纯净服、插件服、整合包服务器通用。
> 游戏规则（gamerule）名称采用 **1.21.11 起的新命名（snake_case）**；1.21.11 之前的旧名称在第六节给出对照表。
<!-- more -->

## 一、前言

开服容易，维护难。日常管理服务器 90% 的工作，其实就是几十条原版命令：给管理员、封禁捣乱的玩家、开白名单、定时保存、调整游戏规则。

本文按「命令基础 → 服务器管理 → 玩家 → 世界 → 游戏规则 → 选择器 → 脚本调试 → 版本差异 → 服务端配置」的顺序，把 Java 版最常用的命令整理成一张可随时查阅的速查表，所有命令语法均对照 [Minecraft Wiki](https://minecraft.wiki/w/Commands) 校对过。

## 二、命令基础

### 1. 语法记号

| 记号 | 含义 | 示例 |
| --- | --- | --- |
| `<参数>` | **必填**，占位符要替换成实际值，尖括号本身不要输入 | `/kick <玩家>` |
| `[参数]` | **可选**，省略时使用默认值 | `/kick <玩家> [理由]` |
| `(a\|b)` | **二选一**，只能填其中一个 | `/weather (clear\|rain\|thunder)` |

### 2. 在哪里执行

| 位置 | 是否需要 `/` 前缀 | 说明 |
| --- | --- | --- |
| 游戏内聊天栏 | 需要 | 按 `/` 键会自动补上前缀，按 `Tab` 可补全命令和参数 |
| 服务端控制台 | **不需要** | 直接输入 `stop`、`save-all` 等 |
| 命令方块 / 数据包函数 | 可加可不加 | 常用 `execute` 组合 |

> [!NOTE]
> 服务端控制台里命令**不加斜杠**，这是新手最容易忽略的一点；控制台运行的命令以 4 级权限执行。

### 3. 权限等级

Java 版的权限等级（Permission level）从 0 到 4 递增，高等级包含低等级的全部权限：

| 等级 | 名称 | 说明 |
| --- | --- | --- |
| 0 | All | 无特殊权限，普通玩家 |
| 1 | Moderator | 可绕过出生点保护 |
| 2 | Gamemaster | 可使用大部分命令、命令方块；可切换难度、使用目标选择器 |
| 3 | Admin | 多人游戏管理相关命令（`/ban`、`/kick`、`/op`、`/whitelist` 等） |
| 4 | Owner | 全部命令，包括服务器级操作（`/stop` 等） |

`/op` 授予的等级由 `server.properties` 中的 `op-permission-level` 决定（**默认 4**）。想给"半管理员"，把它改成 `3` 或 `2` 再 `/op` 即可。

## 三、服务器管理命令

### 1. 管理员与封禁

```bash
/op <玩家>                     # 授予管理员权限（等级由 op-permission-level 决定）
/deop <玩家>                   # 撤销管理员权限
/kick <玩家> [理由]             # 踢出玩家，可附带提示理由
/ban <玩家> [理由]              # 封禁玩家（写入 banned-players.json）
/ban-ip <IP或在线玩家> [理由]    # 封禁 IP（写入 banned-ips.json）
/banlist [ips|players]         # 查看封禁列表
/pardon <玩家>                  # 解除玩家封禁
/pardon-ip <IP>                 # 解除 IP 封禁
```

- 封禁类命令需要 **3 级权限**，且只在**专用服务端**可用（单人/局域网世界没有）。
- `/ban-ip` 也可以直接写一个**在线玩家名**，表示封禁该玩家当前使用的 IP。

> [!WARNING]
> 封禁是不可逆的管理动作，建议先用 `/kick` 警告；确认恶意行为后再 `/ban`，并顺手用 `/banlist` 复查。

### 2. 白名单

```bash
/whitelist on                  # 开启白名单（立即生效）
/whitelist off                 # 关闭白名单
/whitelist add <玩家>           # 添加玩家到白名单
/whitelist remove <玩家>        # 从白名单移除
/whitelist list                # 查看白名单
/whitelist reload              # 重新读取 whitelist.json（手工改文件后用）
```

要让白名单真正生效，还需要在 `server.properties` 中配置：

```properties
white-list=false          # 服务端启动时是否启用白名单（命令 /whitelist on 会临时覆盖）
enforce-whitelist=false   # 启用白名单时，是否把不在名单上的在线玩家踢出
```

### 3. 运行控制

```bash
/stop                          # 保存并安全关闭服务端
/save-all                      # 立即保存所有世界数据
/save-all flush                # 立即保存并强制写入磁盘
/save-off                      # 暂停自动保存（备份前常用）
/save-on                       # 恢复自动保存
/list                          # 查看在线玩家
/list uuids                    # 同时显示玩家 UUID
/reload                        # 重载数据包与函数（不会重读 server.properties）
```

> [!CAUTION]
> 不要用任务管理器或 `kill -9` 强杀进程：世界数据可能尚未落盘，会造成区块损坏。正确做法永远是 `/stop`。

## 四、玩家相关命令

### 1. 游戏模式与难度

```bash
/gamemode <模式> [玩家]         # 修改游戏模式，省略玩家时改自己
/defaultgamemode <模式>         # 新玩家进入时的默认模式
/difficulty [peaceful|easy|normal|hard]   # 省略难度时查询当前难度
```

| 模式 | 说明 |
| --- | --- |
| `survival` | 生存模式，会受伤、会饿 |
| `creative` | 创造模式，可飞行、无限方块 |
| `adventure` | 冒险模式，不能破坏方块，适合地图玩法 |
| `spectator` | 旁观模式，可穿墙观察 |

| 难度 | 说明 |
| --- | --- |
| `peaceful` | 和平，不生成敌对生物，自动回血 |
| `easy` | 简单 |
| `normal` | 普通 |
| `hard` | 困难，饥饿会致死 |

> [!NOTE]
> `/difficulty` 在多人服务端的修改只在本次运行中生效，重启后会从 `server.properties` 的 `difficulty` 重新加载。

### 2. 传送

```bash
/tp <目标玩家>                   # 把自己传送到目标玩家
/tp <玩家> <目标玩家>            # 把某玩家传送到目标玩家
/tp <玩家> <x> <y> <z>           # 传送到指定坐标（可带朝向参数）
/tp <玩家> ~ ~10 ~               # 相对坐标：在当前高度上方 10 格
```

- `~` 表示**相对坐标**（相对于执行者当前位置），`^` 表示**局部坐标**（相对于视线方向）。
- `/tp` 与 `/teleport` 完全等价，后者更清晰易读。
- 想随机分散玩家用 `/spreadplayers <中心x> <中心z> <最小间距> <最大范围> <是否按队伍分组> <目标>`；想观察某个玩家用 `/spectate <玩家> [观察者]`。

### 3. 物品、附魔与经验

```bash
/give <玩家> <物品> [数量]              # 给予物品，例如 /give Steve diamond 64
/clear [玩家] [物品] [最大数量]          # 清空物品，可只清指定物品
/enchant <玩家> <附魔> [等级]            # 给玩家手上的物品附魔
/xp add <玩家> <数量> [points|levels]    # 增加经验（默认 points）
/xp set <玩家> <数量> [levels]           # 设置为指定经验
/xp query <玩家> [points|levels]         # 查询经验
```

物品与附魔使用**命名空间 ID**（如 `minecraft:diamond`、`minecraft:sharpness`），`minecraft:` 前缀在 Java 版可以省略，例如 `/give Steve diamond 64`。

### 4. 状态效果与伤害

```bash
/effect give <玩家> <效果> [秒数] [等级] [隐藏粒子]   # 给予状态效果
/effect give <玩家> <效果> infinite [等级]            # 永久效果（用 /effect clear 清除）
/effect clear [玩家] [效果]                            # 清除效果，省略效果时清除全部
/damage <目标> <伤害值> [伤害类型] [at <坐标>|by <实体> [from <来源>]]   # 造成伤害
```

`/damage` 是较新版本才加入的命令，老服务端会提示未知命令；想给全体玩家上夜视可以用选择器组合：

```bash
/effect give @a[gamemode=survival] night_vision 999999 0
```

### 5. 聊天、标题与音效

```bash
/say <消息>                          # 以 [Server] 身份向所有人广播
/me <动作>                           # 发送动作消息
/msg <玩家> <消息>                   # 私聊（/tell、/w 等价）
/tellraw <目标> <JSON文本>            # 发送可点击、可着色的 JSON 文本
/title <目标> title <标题>            # 显示主标题
/title <目标> subtitle <副标题>       # 显示副标题
/title <目标> actionbar <文本>        # 在物品栏上方显示动作栏文本
/title <目标> times <淡入> <停留> <淡出>  # 设置标题时长（单位：刻）
/playsound <音效> [来源] [目标] [坐标] [音量] [音调]   # 播放音效
```

## 五、世界相关命令

### 1. 出生点与种子

```bash
/seed                            # 查看世界种子（需要 OP）
/setworldspawn [x y z] [角度]     # 设置世界出生点，省略坐标时设为执行者位置
/spawnpoint [玩家] [x y z] [角度]  # 设置某个玩家的个人重生点
```

### 2. 时间与天气

```bash
/time set <时间>                 # 设置时间
/time add <刻数>                 # 增加时间，例如 /time add 24000 表示过一天
/time query gametime             # 查询世界已运行的刻数
/weather (clear|rain|thunder) [持续秒数]   # 设置天气，省略时长时随机
/weather query                   # 查询当前天气
```

时间快捷值与对应刻数：

| 快捷值 | 刻数 | 含义 |
| --- | --- | --- |
| `day` | 1000 | 白天 |
| `noon` | 6000 | 正午 |
| `night` | 13000 | 夜晚 |
| `midnight` | 18000 | 午夜 |

### 3. 世界边界

```bash
/worldborder get                                  # 查询当前边界
/worldborder set <直径> [时间]                     # 设置边界直径，可选渐变时间（秒）
/worldborder add <直径增量> [时间]                 # 扩大或缩小边界
/worldborder center <x> <z>                       # 移动边界中心
/worldborder damage amount <每方块伤害>            # 边界外每秒伤害
/worldborder damage buffer <缓冲距离>              # 边界外多少格开始受伤
/worldborder warning distance <距离>               # 距边界多少格开始显示红色警告
/worldborder warning time <秒数>                   # 收缩前多少秒开始警告
```

### 4. 方块与区域操作

```bash
/setblock <坐标> <方块> [destroy|keep|replace]      # 放置单个方块
/fill <起点> <终点> <方块> [destroy|hollow|keep|outline|replace]   # 填充区域
/clone <起点> <终点> <目标点> [replace|masked] [force|move|normal]  # 复制区域
/forceload add <起点> [终点]                        # 强制加载区块（防止远处农场停摆）
/forceload remove <起点> [终点]                     # 取消强制加载
/forceload query [坐标]                             # 查询哪些区块被强制加载
```

填充与复制的处理模式：

| 模式 | 说明 |
| --- | --- |
| `replace` | 直接替换（默认） |
| `keep` | 只替换空气方块 |
| `hollow` | 只填充外壳 |
| `outline` | 只填充外框 |
| `destroy` | 替换并掉落原有方块（类似玩家挖掘） |
| `masked`（clone） | 只复制非空气方块 |

### 5. 定位结构与群系

```bash
/locate structure <结构>          # 定位结构，如 /locate structure mansion
/locate biome <生物群系>          # 定位生物群系，如 /locate biome desert
/locate poi <兴趣点>              # 定位兴趣点（1.19+）
```

> [!IMPORTANT]
> **1.19 起 `/locatebiome` 已合并进 `/locate biome`**，老教程里的 `/locatebiome desert` 在新版本会报错，请改用 `/locate biome desert`。

## 六、游戏规则（gamerule）

### 1. 基本用法

```bash
/gamerule <规则> [值]             # 省略值时查询当前值
```

值只有两种类型：`true`/`false` 的布尔值，以及整数。想一次查看全部规则，可以直接输入 `/gamerule` 后按 `Tab` 补全，或在创建世界时的"编辑游戏规则"界面查看。

### 2. 常用规则对照表

> [!IMPORTANT]
> **Java 1.21.11 起，所有游戏规则名改为 snake_case**（如 `keep_inventory`），并且不少规则被重新命名。下表左侧是新名称，右侧是 1.21.11 之前的旧名称；服务端版本 ≤ 1.21.10 时请用旧名称。

| 用途 | 1.21.11+ | ≤ 1.21.10（旧） |
| --- | --- | --- |
| 死亡不掉落 | `keep_inventory` | `keepInventory` |
| 关闭生物破坏（苦力怕炸方块等） | `mob_griefing` | `mobGriefing` |
| 停止昼夜更替 | `advance_time` | `doDaylightCycle` |
| 停止天气变化 | `advance_weather` | `doWeatherCycle` |
| 关闭生物自然生成 | `spawn_mobs` | `doMobSpawning` |
| 只关幻翼生成 | `spawn_phantoms` | `doInsomnia` |
| 立即重生 | `immediate_respawn` | `doImmediateRespawn` |
| 关闭自然回血 | `natural_health_regeneration` | `naturalRegeneration` |
| 摔落伤害开关 | `fall_damage` | `fallDamage` |
| 死亡消息 | `show_death_messages` | `showDeathMessages` |
| 进度公告 | `show_advancement_messages` | `announceAdvancements` |
| 命令方块输出 | `command_block_output` | `commandBlockOutput` |
| 命令执行反馈 | `send_command_feedback` | `sendCommandFeedback` |
| 方块掉落 | `block_drops` | `doTileDrops` |
| 生物掉落 | `mob_drops` | `doMobLoot` |
| 实体掉落（矿车、船等） | `entity_drops` | `doEntityDrops` |
| 随机刻速度（影响作物/刷怪） | `random_tick_speed` | `randomTickSpeed` |
| 出生保护半径 | `respawn_radius` | `spawnRadius` |
| 命令链长度上限 | `max_command_sequence_length` | `maxCommandChainLength` |
| 允许 PvP | `pvp` | —（较新版本新增） |
| 定位栏显示 | `locator_bar` | —（较新版本新增） |
| 弹射物可破坏方块 | `projectiles_can_break_blocks` | —（较新版本新增） |

举例：

```bash
# 1.21.11 及以后
/gamerule keep_inventory true
/gamerule mob_griefing false
/gamerule advance_time false

# 1.21.10 及以前
/gamerule keepInventory true
/gamerule mobGriefing false
/gamerule doDaylightCycle false
```

### 3. 两条容易踩坑的规则变化

**（1）火相关规则已被替换。** 旧的 `doFireTick` 和 `allowFireTicksAwayFromPlayer` 在 1.21.11 中被移除，改用整数规则 `fire_spread_radius_around_player`：

```bash
/gamerule fire_spread_radius_around_player 0     # 火完全不蔓延
/gamerule fire_spread_radius_around_player -1    # 无限距离蔓延
/gamerule fire_spread_radius_around_player 128   # 默认值
```

**（2）有几条规则的值被"反转"了。** 新名称表达的是正向语义，所以旧命令里的 `true`/`false` 需要反过来：

| 1.21.11+ | ≤ 1.21.10（旧） | 说明 |
| --- | --- | --- |
| `raids` | `disableRaids` | 新名 `true` = 允许袭击（旧名 `false` 才是允许） |
| `elytra_movement_check` | `disableElytraMovementCheck` | 新名 `true` = 开启鞘翅速度检查 |
| `player_movement_check` | `disablePlayerMovementCheck` | 新名 `true` = 开启玩家移动检查 |

## 七、目标选择器

### 1. 基础选择器

| 选择器 | 含义 |
| --- | --- |
| `@p` | 最近的玩家 |
| `@a` | 所有玩家 |
| `@r` | 随机一名玩家 |
| `@e` | 所有实体 |
| `@s` | 命令执行者自己 |
| `@n` | 最近的实体（较新版本） |

### 2. 常用参数

```bash
@a[distance=..10]              # 10 格内的所有玩家
@e[type=zombie]                # 所有僵尸
@e[type=!player]               # 所有非玩家实体
@a[gamemode=survival]           # 生存模式玩家
@p[level=10..]                 # 等级 ≥10 的最近玩家
@a[tag=admin]                  # 带 admin 标签的玩家
@e[type=item,distance=..10]     # 10 格内的掉落物
```

常用参数一览：`type`（实体类型）、`distance`（距离，`..10` 表示 ≤10，`10..` 表示 ≥10）、`gamemode`、`level`、`tag`、`name`、`x/y/z` + `dx/dy/dz`（区域）、`sort`、`limit`、`nbt`。

### 3. 组合示例

```bash
# 清理附近 10 格内的掉落物
/kill @e[type=item,distance=..10]

# 给所有生存玩家夜视（等级 0 = I 级）
/effect give @a[gamemode=survival] night_vision 999999 0

# 把所有玩家传送到出生点上方
/tp @a 0 100 0

# 只给最近的玩家发一把钻石剑
/give @p diamond_sword 1
```

## 八、数据、脚本与调试命令

```bash
/data get entity <目标> [路径]                  # 查看实体 NBT
/data get block <坐标> [路径]                   # 查看方块实体 NBT
/tag <目标> add <标签>                          # 给实体加标签
/tag <目标> remove <标签>                       # 移除标签
/tag <目标> list                               # 列出标签
/scoreboard objectives add <名称> <准则>         # 新建计分板目标
/scoreboard players set <对象> <目标> <分值>      # 设置分数
/advancement grant <目标> only <进度>            # 授予进度
/attribute <目标> <属性> get [倍率]               # 查询实体属性
/function <函数> [参数]                          # 执行数据包函数
/schedule function <函数> <时间> [append|replace] # 定时执行函数
/tick query                                    # 查询服务器刻率
/tick rate <速率>                               # 调整刻率（20 = 原速）
/tick freeze / /tick unfreeze                   # 冻结/恢复游戏刻（调试常用）
/random value <最小值>..<最大值>                 # 生成随机数
/debug start / /debug stop                      # 开始/结束性能分析
/perf start / /perf stop                        # 性能监控
/reload                                        # 重载数据包
```

> [!NOTE]
> `/tick`、`/random` 等是较新版本加入的命令，老服务端会出现"未知的命令"提示；`/reload` 只重载数据包，**不会**重新读取 `server.properties`。

## 九、Java 版与基岩版差异

很多教程把两个版本的命令混着写，实际差异不小，照抄会报错：

| 项目 | Java 版 | 基岩版 |
| --- | --- | --- |
| 游戏规则命名 | `keep_inventory`（1.21.11+） | `keepinventory`（全小写无下划线） |
| 状态效果 | `/effect give <玩家> <效果> [秒数] [等级]` | `/effect <玩家> <效果> [秒数] [等级]` |
| 保存世界 | `/save-all`、`/save-off` | `/save hold`、`/save query` |
| 经验 | `/xp add <玩家> <数量> points` | `/xp <数量> [玩家]` |
| 强制加载 | `/forceload add` | `/tickingarea add` |
| 定位群系 | `/locate biome <群系>` | `/locate biome <群系>`（语法接近） |
| NBT 数据 | `/data`、`/attribute` 等完整支持 | 大部分不支持 |

本文所有命令均以 **Java 版**为准；基岩版服务端（BDS）请以官方文档为准。

## 十、服务端配置速查（server.properties）

命令管"运行时"，配置文件管"启动时"。以下是最常改的几项（改完需重启服务端）：

```properties
motd=一个 Minecraft 服务器            # 服务器列表里显示的介绍
server-port=25565                    # 监听端口
online-mode=true                     # 是否验证正版账号（离线服需改为 false）
max-players=20                       # 最大玩家数
difficulty=normal                    # 默认难度
gamemode=survival                    # 新玩家默认游戏模式
pvp=true                             # 是否允许玩家互相攻击
white-list=false                     # 是否启用白名单
enforce-whitelist=false              # 白名单启用时踢出不在名单上的玩家
op-permission-level=4                # /op 授予的权限等级（1-4）
enable-command-block=false           # 是否启用命令方块
allow-flight=false                   # 是否允许飞行（生存模式下开飞行插件时需开）
spawn-protection=16                  # 出生点保护半径（0 关闭）
view-distance=10                     # 视距（影响性能最明显的一项）
simulation-distance=10               # 模拟距离（影响刷怪与作物生长）
max-tick-time=60000                  # 单刻超时时间，卡服时可适当调大
player-idle-timeout=0                # 挂机踢出时间（分钟，0 = 不踢）
hardcore=false                       # 极限模式（死亡后无法重生）
```

> [!TIP]
> 改完 `white-list`、`view-distance` 这类键值后记得**重启**；`/whitelist on|off` 只在运行时生效，不会写回配置文件。

## 十一、注意事项与常见问题

> [!IMPORTANT]
> - **前缀**：游戏内要加 `/`，控制台**不加**；
> - **记号**：`<>` 必填、`[]` 可选，尖括号和方括号本身不要输入；
> - **权限**：封禁、白名单、`/op` 等需要 3 级权限；`/stop`、`/save-off` 等需要 4 级；
> - **版本差异**：1.21.11 起游戏规则改名为 snake_case；`/locatebiome`、`doFireTick` 等已被移除；
> - **数据安全**：备份前先 `/save-off` + `/save-all`，备份完再 `/save-on`；
> - **安全关闭**：永远用 `/stop`，不要直接杀进程。

**常见报错对照：**

| 报错 | 原因与解决 |
| --- | --- |
| `Unknown or incomplete command` | 命令拼错或版本不支持（如老版本的 `/locatebiome`） |
| `You do not have permission to perform this command` | 权限等级不足，检查 `op-permission-level` 与是否 `/op` |
| `That player does not exist` | 玩家名写错，或玩家不在白名单/不在线（`/ban` 需要精确 ID） |
| `Cannot execute command, expected a valid ...` | 参数类型不对，例如把布尔值写成了 `1`/`0` |
| `The world border is already ...` | 世界边界参数不合法 |
| `Authentication failed`（客户端连不上） | `online-mode` 与账号状态不匹配，或服务器未开放端口 |

## 十二、相关资源

- [Minecraft Wiki - 命令（英文）](https://minecraft.wiki/w/Commands)：最权威的命令语法与历史版本
- [中文 Minecraft Wiki - 命令](https://zh.minecraft.wiki/w/%E5%91%BD%E4%BB%A4)：中文对照
- [Minecraft Wiki - 游戏规则](https://minecraft.wiki/w/Game_rule)：全部规则与旧名对照
- [Minecraft Wiki - 权限等级](https://minecraft.wiki/w/Permission_level)：0-4 级权限说明
- [Minecraft Wiki - server.properties](https://minecraft.wiki/w/Server.properties)：服务端配置全部选项
- [我的世界整合包服务器搭建教程](/2025/08/08/00/)：本站的开服实战教程

> [!TIP]
> 2023 年社区维基已从 Fandom 迁移到 **minecraft.wiki**，网上大量老教程里的 fandom 链接内容不再更新，查命令请优先看新站。

## 总结

管理 Minecraft 服务端不需要背下所有命令，只要记住四类就够用：

1. **管人**：`/op`、`/kick`、`/ban`、`/whitelist`；
2. **管服务器**：`/stop`、`/save-all`、`/save-off`、`/list`；
3. **管世界**：`/time`、`/weather`、`/gamerule`、`/worldborder`、`/locate`；
4. **提效**：目标选择器 + `/execute` + `/tick`。

最关键的一条：**游戏规则名称在 1.21.11 改成了 snake_case**，抄老教程时要先看版本；如果你维护的是老版本服务端，请用第六节的旧名称。

> [!TIP]
> 祝你开服顺利，玩得愉快！

---

#### 有问题可以联系我
我的邮箱：boke@shimoxi.dpdns.org


---

> 作者: [石墨烯积木](https://www.san3.cn)  
> URL: https://www.san3.cn/2025/10/17/14/  

