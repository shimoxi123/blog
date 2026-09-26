# Minecraft 服务器管理必备命令大全

> [!TIP]
> 本文整理了 Minecraft 原版服务器的所有常用命令，无需任何插件或 mod，适用于纯净服和整合包服务器。
<!-- more -->

## 前言

作为一名服务器管理员，掌握 Minecraft 的原版命令是必不可少的技能。本文将详细介绍开服过程中最常用的命令，帮助你更好地管理服务器。


## 🔧 服务器管理命令

### 玩家权限管理

管理玩家权限是服主最基础的操作：

```bash
/op <玩家名>              # 给予玩家管理员权限
/deop <玩家名>            # 移除玩家的管理员权限
/kick <玩家名> [理由]     # 踢出玩家
/ban <玩家名> [理由]      # 封禁玩家
/ban-ip <IP地址> [理由]   # 封禁IP地址
/pardon <玩家名>          # 解除玩家封禁
/pardon-ip <IP地址>       # 解除IP封禁
/banlist                  # 查看封禁列表
```

> [!WARNING]
> 谨慎使用 ban 命令，建议先使用 kick 给予警告。

### 白名单管理

如果想让服务器只对特定玩家开放，白名单是最好的选择：

```bash
/whitelist on             # 开启白名单
/whitelist off            # 关闭白名单
/whitelist add <玩家名>   # 添加白名单
/whitelist remove <玩家名># 移除白名单
/whitelist list           # 查看白名单列表
/whitelist reload         # 重载白名单
```

### 服务器控制

```bash
/stop                     # 正确停止服务器（会自动保存）
/save-all                 # 立即保存所有世界数据
/save-on                  # 开启自动保存
/save-off                 # 关闭自动保存（慎用）
/list                     # 查看在线玩家列表
```

> [!CAUTION]
> 永远不要使用强制关闭！使用 /stop 命令可以防止数据损坏。

## 🌍 世界管理命令

### 基础世界设置

```bash
/seed                     # 查看世界种子
/setworldspawn [x y z]    # 设置世界出生点
/spawnpoint [玩家] [x y z]# 设置玩家重生点
/difficulty <难度>        # 设置难度
```

**难度选项：**
- `peaceful` - 和平
- `easy` - 简单
- `normal` - 普通
- `hard` - 困难

### 时间与天气控制

```bash
/time set <时间>          # 设置时间
/time add <时间>          # 增加时间
/weather <天气> [持续秒数]# 设置天气
```

**时间快捷值：**
- `day` - 白天 (1000)
- `noon` - 正午 (6000)
- `night` - 夜晚 (13000)
- `midnight` - 午夜 (18000)

**天气选项：**
- `clear` - 晴天
- `rain` - 雨天
- `thunder` - 雷暴

### 游戏模式设置

```bash
/gamemode <模式> [玩家]   # 更改游戏模式
/defaultgamemode <模式>   # 设置默认游戏模式
```

**模式选项：**
- `survival` (s) - 生存模式
- `creative` (c) - 创造模式
- `adventure` (a) - 冒险模式
- `spectator` (sp) - 旁观模式

## ⚙️ 游戏规则配置

使用 `/gamerule <规则> <值>` 可以精细调整游戏机制：

### 死亡相关

```bash
/gamerule keepInventory true        # 死亡不掉落物品
/gamerule showDeathMessages true    # 显示死亡消息
/gamerule doImmediateRespawn true   # 立即重生（跳过死亡界面）
```

### 生物控制

```bash
/gamerule doMobSpawning false       # 关闭生物自然生成
/gamerule mobGriefing false         # 生物不破坏方块（苦力怕不炸方块）
/gamerule doInsomnia false          # 关闭幻翼生成
```

### 环境控制

```bash
/gamerule doDaylightCycle false     # 停止时间流动
/gamerule doWeatherCycle false      # 关闭天气变化
/gamerule doFireTick false          # 火不蔓延不熄灭
```

### 其他实用规则

```bash
/gamerule announceAdvancements true # 显示成就公告
/gamerule commandBlockOutput false  # 关闭命令方块输出
/gamerule naturalRegeneration true  # 自然生命恢复
/gamerule fallDamage true          # 摔落伤害开关
```

## 👤 玩家辅助命令

### 传送命令

```bash
/tp <目标玩家>                    # 传送到某玩家
/tp <玩家> <目标玩家>             # 传送某玩家到目标玩家
/tp <玩家> <x> <y> <z>            # 传送到坐标
/tp ~ ~10 ~                       # 相对坐标传送（向上10格）
```

> [!NOTE]
> 使用 ~ 表示相对坐标，^ 表示局部坐标。

### 物品管理

```bash
/give <玩家> <物品ID> [数量]      # 给予物品
/clear [玩家] [物品] [数量]       # 清除物品
/enchant <玩家> <附魔ID> [等级]   # 附魔手持物品
```

**常用物品ID示例：**
- `minecraft:diamond` - 钻石
- `minecraft:iron_ingot` - 铁锭
- `minecraft:golden_apple` - 金苹果

### 效果与经验

```bash
/effect give <玩家> <效果ID> [秒数] [等级]  # 给予药水效果
/effect clear <玩家> [效果]                 # 清除药水效果
/xp add <玩家> <数量> points               # 给予经验点
/xp add <玩家> <数量> levels               # 给予经验等级
```

### 消息命令

```bash
/msg <玩家> <消息>                # 私聊玩家
/say <消息>                       # 服务器公告（所有人可见）
/title <玩家> title <文本>        # 显示标题
/me <动作>                        # 显示动作消息
```

## 🎯 选择器系统

选择器可以让命令更加灵活：

### 基础选择器

```bash
@p  # 最近的玩家
@a  # 所有玩家
@r  # 随机玩家
@e  # 所有实体
@s  # 命令执行者
```

### 选择器参数示例

```bash
@a[distance=..10]           # 10格内所有玩家
@e[type=zombie]             # 所有僵尸
@a[gamemode=survival]       # 所有生存模式玩家
@p[level=10..]              # 等级10及以上最近玩家
@e[type=!player]            # 所有非玩家实体
@a[tag=admin]               # 所有带有admin标签的玩家
```

**实用组合示例：**

```bash
# 清除附近10格内所有掉落物
/kill @e[type=item,distance=..10]

# 给予所有生存模式玩家夜视效果
/effect give @a[gamemode=survival] night_vision 999999 1

# 传送所有玩家到出生点
/tp @a 0 100 0
```

## 🔍 调试与高级命令

### 实体管理

```bash
/summon <实体ID> [x y z]          # 召唤实体
/kill [目标]                      # 杀死实体或玩家
/data get entity <选择器>         # 查看实体数据
```

### 世界相关

```bash
/locate structure <结构类型>      # 定位结构
/locatebiome <生物群系>           # 定位生物群系
/forceload add <坐标>             # 强制加载区块
/forceload remove <坐标>          # 取消强制加载
```

### 性能与调试

```bash
/reload                           # 重载数据包
/debug start                      # 开始性能分析
/debug stop                       # 停止性能分析
/perf start                       # 开始性能监控
```

## 💡 实用技巧

### 服务器日常维护

建议设置一个定时保存的习惯：

```bash
# 每小时手动执行一次
/save-all
/say 服务器已保存数据
```

### 新手友好设置

如果你的服务器面向新手玩家，可以使用以下配置：

```bash
/gamerule keepInventory true      # 死亡不掉落
/gamerule doInsomnia false        # 关闭幻翼
/gamerule mobGriefing false       # 苦力怕不炸方块
/difficulty easy                  # 简单难度
```

### 生存挑战设置

想要增加难度？试试这些：

```bash
/gamerule naturalRegeneration false  # 关闭自然恢复
/gamerule doImmediateRespawn false   # 不立即重生
/difficulty hard                     # 困难难度
/gamerule doDaylightCycle true       # 时间流动
```

## ⚠️ 注意事项

> [!IMPORTANT]
> 1. **命令前缀**：在游戏内需要加 `/` 符号，在服务器控制台可省略
> 2. **参数说明**：`<>` 表示必填参数，`[]` 表示可选参数
> 3. **权限要求**：管理员命令需要 OP 权限
> 4. **版本差异**：部分命令可能因版本不同而有差异
> 5. **数据安全**：定期使用 `/save-all` 保存服务器数据
> 6. **正确关闭**：使用 `/stop` 而非强制关闭，防止数据损坏

> [!TIP]
> - 定期备份服务器数据，可以避免意外损失
> - 合理设置游戏规则，平衡游戏体验
> - 使用白名单可以有效防止恶意玩家
> - 封禁前先警告，给玩家改正的机会
> - 学会使用选择器可以大大提升管理效率

## 📚 相关资源

- [Minecraft Wiki - 命令](https://minecraft.fandom.com/zh/wiki/命令)
- [我的世界整合包服务器搭建教程](/2025/08/08/00/)
- [Minecraft 游戏规则完整列表](https://minecraft.fandom.com/zh/wiki/游戏规则)

## 总结

掌握这些原版命令，你就能轻松管理自己的 Minecraft 服务器了。建议将常用命令做成快捷脚本，提高管理效率。如果你在使用过程中遇到问题，欢迎在评论区留言交流！

> [!TIP]
> 祝你开服顺利，玩得愉快！

---

#### 有问题可以联系我
我的邮箱：boke@shimoxi.dpdns.org


---

> 作者: [石墨烯积木](https://www.san3.cn)  
> URL: https://www.san3.cn/2025/10/17/14/  

