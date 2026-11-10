# python_learnApp · Python 学习小程序

把教材《Python 编程：从入门到实践（第 3 版）》按《Python 实验数据建模 12 周学习手册》的节奏，拆成**能在 Jupyter 里边敲边自检**的笔记本。

目标不是「学完 Python」，而是**能读写文件、能循环判断、能定义函数、能用列表和字典**——这四件事会了，后面的 pandas 和 sklearn 就只剩调 API。

## 现在有什么

| 路径 | 内容 |
|---|---|
| `notebooks/01_Python基础_第1-2周.ipynb` | 主课件：9 关、53 个自检点，对应手册「第 1–2 周」 |
| `data/` | 配套数据（12 行实验记录 + 3 个运行文件），用来练读文件 |
| `book/` | 教材 PDF（188 MB，**只放本机，不入 git**） |
| `src/python_learnapp/` | uv 生成的包骨架，暂时没用上 |
| `pyproject.toml` / `uv.lock` | 依赖：`ipykernel` + `numpy` |

## 怎么开始（3 步）

```powershell
# 1. 装依赖（只需要一次）
uv sync
```

2. 用 VS Code 打开**这个文件夹**（不是单个 .ipynb 文件），再打开 `notebooks/01_Python基础_第1-2周.ipynb`
3. 右上角 **Select Kernel** → 选 `Python (python_learnApp/.venv)`，然后从上往下 `Shift+Enter`

> **本机 uv 缓存被沙箱限制**：若 `uv sync` 报 `Failed to initialize cache at C:\Users\...\uv\cache`，
> 先设缓存目录再跑：`$env:UV_CACHE_DIR = "$PWD\.uvcache"; uv sync`
> （`.uvcache/` 已加入 .gitignore）

## 练完一遍想重来（重置）

按保留程度分三档：

| 想保留 | 怎么做 | 结果 |
|---|---|---|
| 只清输出 | 工具栏 **Clear All Outputs** 或 **Restart** 内核 | 代码还在，自检计数归零 |
| 从空白重做 | `Ctrl+Shift+P` → **Tasks: Run Task** → **🔄 重置练习（先备份）** | 当前答案先备份到 `notebooks/_练习记录/时间戳.ipynb`，再整本还原成空白版 |
| 对照复习 | **📂 打开练习记录** 任务 | 打开备份目录，左边答案右边空白 |

命令行等价（没有 VS Code 或想写进脚本时）：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\reset_practice.ps1
# 加 -NoBackup 就不备份，直接覆盖（不建议）
```

**机制**：`notebooks/_template/` 放空白母版，重置时脚本把它覆盖回 `notebooks/`，并顺手删掉 `data/mine.txt`、`data/my_notes.txt` 这类产物。
以后新增课件（第 2 本、第 3 本）时，把空白版复制进 `notebooks/_template/`，就会自动纳入一键重置范围。

> 重置后 VS Code 会提示「文件已在磁盘上更改」→ 点 **Revert**；再点 **Restart** 重启内核，让 `check()` 从 0 计。

## 这本笔记怎么组织

每一关固定五个单元：

| 单元 | 作用 |
|---|---|
| 📖 讲解（Markdown） | 一张要点表 + 书页码 + 三个必踩的坑 |
| 示例（代码） | 直接能跑，先看输出建立直觉 |
| ✍️ 动手区（代码） | 只有注释要求，**自己敲**——手册原话：看懂和写出来隔着太平洋 |
| ✅ 自检（代码） | `check(lambda: 表达式)`，跑通打 ✅ |
| 进度 | `progress()` 统计本关通过数 |

自检三种状态：`✅ 通过` / `❌ 未通过`（写了但不对）/ `⬜ 还没写`（变量没定义）。

## 九关与书的对应

| 关 | 主题 | 书页码 | 周次 |
|---|---|---|---|
| 0 | 环境 + 自检工具箱 | p.43–59 | — |
| 1 | 变量、字符串、数字 | p.60–84 | 第 1 周 |
| 2 | 列表、切片、元组 | p.85–105、123–131 | 第 1 周 |
| 3 | if 条件判断 | p.136–161 | 第 1 周 |
| 4 | 字典 | p.162–189 | 第 1 周 |
| 5 | for 循环与列表推导式 | p.106–122 | 第 2 周 |
| 6 | while 循环与 input | p.190–209 | 第 2 周 |
| 7 | 函数 | p.210–247 | 第 2 周 |
| 8 | 文件读写与异常 | p.282–314 | 第 2 周 |
| 9 | 五个过关练习 | 手册原文 | 第 2 周 |

第 9 关直接用了手册「五个练习，做完就算过关」那五条：读 CSV、`unit_convert()`、字典计数排序、批量读文件夹、numpy 矩阵。

## 数据说明

```
data/
├── experiments_raw.csv   # 批次,温度_C,时间_min,收率_pct（12 行；温度 25/30/35/40 分别出现 4/3/3/2 次）
├── hello.txt             # 一行打卡，练读文件
└── runs/run01..03.txt    # 每次运行一个文件，1 行表头 + 3 行数据，练批量读
```

数据是**故意写成字符串**的（CSV 读出来全是 `str`），这样你才会真正体会 pandas 帮你做了什么。

## 进度

- [ ] 关 1–4（第 1 周）
- [ ] 关 5–8（第 2 周）
- [ ] 关 9 五个过关练习全绿
- [ ] 产出物：`read_csv.py` + `unit_convert()` + 批量拼表脚本

## 下一步计划

| 周次 | 内容 | 教材 |
|---|---|---|
| 第 3–4 周 | pandas 整理实验数据 | 《Python 数据科学手册》 |
| 第 5 周 | 画图（六张必画图） | 本书第 15–17 章 p.449 起 |
| 第 6–7 周 | 统计回炉 | 《Python 机器学习》 |
| 第 8–12 周 | sklearn 建模、解释、闭环 | 《机器学习实战（第 2 版）》等 |

暂不学：类与继承（第 9 章）、pytest（第 11 章）、三个项目（第二部分 p.336 起）。