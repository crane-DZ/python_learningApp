# python_learnApp · Python 学习小程序

把教材《Python 编程：从入门到实践（第 3 版）》按《Python 实验数据建模 12 周学习手册》的节奏，拆成**能在 Jupyter 里边敲边自检**的笔记本。

目标不是「学完 Python」，而是**能读写文件、能循环判断、能定义函数、能用列表和字典**——这四件事会了，后面的 pandas 和 sklearn 就只剩调 API。

## 现在有什么

| 路径 | 内容 |
|---|---|
| `notebooks/01_Python基础_第1-2周.ipynb` | 主课件：**10 关 / 27 小节 / 103 个检查点**，对应手册「第 1–2 周」 |
| `notebooks/_template/` | 空白母版，重置时用来还原 |
| `data/` | 配套数据（12 行实验记录 + 打卡文件 + 3 个运行文件） |
| `tools/reset_practice.ps1` | 一键重置（先备份、再还原） |
| `.vscode/tasks.json` | 两个任务：🔄 重置练习 / 📂 打开练习记录 |
| `book/` | 教材 PDF（188 MB，**只放本机，不进 git**） |

依赖：`ipykernel` + `numpy`（装在工程内的 `.venv`）。

## 怎么开始（3 步）

```powershell
uv sync           # 只需一次
```

2. 用 VS Code 打开**这个文件夹**（不是单个 .ipynb 文件），再打开 `notebooks/01_Python基础_第1-2周.ipynb`
3. 右上角 **Select Kernel** → 选 `Python (python_learnApp/.venv)`，然后从上往下 `Shift+Enter`

> **本机 uv 缓存被沙箱限制**：若 `uv sync` 报 `Failed to initialize cache at C:\Users\...\uv\cache`，
> 先设缓存目录再跑：`$env:UV_CACHE_DIR = "$PWD\.uvcache"; uv sync`（`.uvcache/` 已 gitignore）

## 这本笔记怎么组织

每小节固定四个单元：

| 单元 | 作用 |
|---|---|
| 📖 讲解（Markdown） | 要点表 + 书页码 + 书里对应练习编号 + 坑 |
| 示例（代码） | 直接能跑，先看输出建立直觉 |
| ✍️ 动手区（代码） | 只有注释要求，**自己敲**——手册原话：看懂和写出来隔着太平洋 |
| ✅ 自检（代码） | `check(lambda: 表达式)` 逐条判分，最后 `progress()` 报本关累计 |

自检三态：`✅ 通过` / `❌ 未通过`（写了但不对）/ `⬜ 还没写`（变量没定义）。
示例单元里的变量都带 `_demo` 后缀，所以**只跑示例不可能让自检变绿**——这条是验证过的。

## 关卡与教材对应

| 关 | 小节 | 书的位置 | 书里的练习 | 周次 |
|---|---|---|---|---|
| 1 | 1.1–1.3 变量、字符串、数字 | 第 2 章 p.60–84 | 2.1–2.12 | 第 1 周 |
| 2 | 2.1–2.3 列表、切片、元组 | 第 3 章、4.4–4.5 节 | 3.1–3.11、4.10–4.13 | 第 1 周 |
| 3 | 3.1–3.3 if 条件 | 第 5 章 p.136–161 | 5.1–5.13 | 第 1 周 |
| 4 | 4.1–4.3 字典 | 第 6 章 p.162–189 | 6.1–6.12 | 第 1 周 |
| 5 | 5.1–5.3 循环、缩进、推导式 | 第 4 章 p.106–135 | 4.1–4.9、4.14 | 第 2 周 |
| 6 | 6.1–6.3 while 与 input | 第 7 章 p.190–209 | 7.1–7.10 | 第 2 周 |
| 7 | 7.1–7.3 函数 | 第 8 章 p.210–247 | 8.1–8.16 | 第 2 周 |
| 8 | 8.1–8.3 文件与异常 | 第 10 章 p.282–314 | 10.1–10.14 | 第 2 周 |
| 9 | 9.1 报错怎么读 | 贯穿全书 | — | 第 2 周 |
| 10 | 10.1–10.2 五个过关练习 | 手册原文 | 读 CSV / 单位换算 / 字典计数 / 批量读 / numpy | 第 2 周 |

## 数据说明

```
data/
├── experiments_raw.csv   # 批次,温度_C,时间_min,收率_pct（12 行；温度 25/30/35/40 出现 4/3/3/2 次）
├── hello.txt             # 一行打卡，练读文件
├── learning_python.txt   # 三行 "In Python you can ..."，练 replace
└── runs/run01..03.txt    # 每次运行一个文件，1 行表头 + 3 行数据，练批量读
```

数据**故意写成字符串**（CSV 读出来全是 `str`），这样你才会真正体会 pandas 帮你做了什么。

## 练完一遍想重来（重置）

| 想保留 | 怎么做 | 结果 |
|---|---|---|
| 只清输出 | **Clear All Outputs** 或 **Restart** 内核 | 代码还在，计数归零 |
| 从空白重做 | `Ctrl+Shift+P` → **Tasks: Run Task** → **🔄 重置练习（先备份）** | 当前答案先备份到 `notebooks/_练习记录/时间戳.ipynb`，再整本还原成空白版 |
| 对照复习 | **📂 打开练习记录** 任务 | 打开备份目录，左边答案右边空白 |

命令行等价：`powershell -NoProfile -ExecutionPolicy Bypass -File tools\reset_practice.ps1`（加 `-NoBackup` 不备份）。

机制：脚本扫描 `notebooks/_template/` 下所有母版覆盖回 `notebooks/`，并删掉 `data/` 里的练习产物。以后新增课件，把空白版放进 `_template/` 就自动纳入重置范围。

## 发给朋友用

**方式 A：发压缩包（她需要装环境，约 15 分钟）**

```powershell
# 在本目录执行，排除书和虚拟环境
Compress-Archive -Path .\notebooks, .\data, .\tools, .\.vscode, .\pyproject.toml, .\uv.lock, .\README.md -DestinationPath ..\python_learnApp_share.zip
```

她要做的：装 VS Code + uv → 解压 → 打开文件夹 → `uv sync` → 选内核 → 开始。

**方式 B：Colab 直接打开（零安装，需要仓库公开 + Google 账号）**

Notebook 里第 3 个单元是「数据兜底」：检测不到 `data/` 就从 GitHub 拉。所以在 Colab 里：

1. 打开 <https://colab.research.google.com>
2. **File → Open notebook → GitHub** 标签页，粘贴仓库地址 `crane-DZ/python_learningApp`
3. 选中 `notebooks/01_Python基础_第1-2周.ipynb` → 运行

前提：GitHub 仓库必须是 **Public**，且最新提交已 push 上去。

## 验证记录（2026-11-11）

- 结构：123 个单元（39 markdown / 84 code），`cell_type` 合法、id 唯一、code 单元均带 `outputs`/`execution_count`
- 示例可跑：84 个代码单元顺序执行零异常
- 判分可信：只跑示例时 103 个检查点**一个都不会变绿**（示例变量统一 `_demo` 后缀）
- 答案可达：注入参考答案后 **103/103 全绿**

## 下一步

| 周次 | 内容 | 教材 |
|---|---|---|
| 第 3–4 周 | pandas 整理实验数据 | 《Python 数据科学手册》 |
| 第 5 周 | 画图（六张必画图） | 本书第 15–17 章 p.449 起 |
| 第 6–7 周 | 统计回炉 | 《Python 机器学习》 |
| 第 8–12 周 | sklearn 建模、解释、闭环 | 《机器学习实战（第 2 版）》等 |

暂不学：类与继承（第 9 章）、pytest（第 11 章）、三个项目（第二部分 p.336 起）。