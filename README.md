# NotebookNeonTemplate

开箱即用的LaTeX笔记模板，基于 [NotebookNeon](https://github.com/liyuxuan3003/NotebookNeon) 文档类和 [Minimus](https://github.com/liyuxuan3003/Minimus) 宏包。

## 使用

```bash
git clone --branch github --recurse-submodules https://github.com/liyuxuan3003/NotebookNeonTemplate.git MyProject
cd MyProject
bash init.sh MyNote
```

## 目录结构

初始化前后的目录变化：

```
初始化前                        初始化后
── MyProject                    ── MyNote
   ├── Notebook/                   ├── MyNote/
   │   ├── Notebook.tex            │   ├── MyNote.tex
   │   ├── Makefile                │   ├── Makefile
   │   ├── Chapter01.tex           │   ├── Chapter01.tex
   │   ├── Reference.bib           │   ├── Reference.bib
   │   ├── makefile-latex/         │   ├── makefile-latex/
   │   ├── minimus/                │   ├── minimus/
   │   ├── notebook-neon/          │   ├── notebook-neon/
   │   ├── standalone-silicon/     │   ├── standalone-silicon/
   │   └── pyjool/                 │   └── pyjool/
   ├── README.md                   ├── README.md （新）
   └── init.sh                     ├── NotebookNeon.md （原README）
                                   └── init.sh
```

## 子模块

| 子模块 | 文档 |
|--------|------|
| `notebook-neon` | [README](https://github.com/liyuxuan3003/NotebookNeon) |
| `minimus` | [README](https://github.com/liyuxuan3003/Minimus) |
| `makefile-latex` | [README](https://github.com/liyuxuan3003/MakefileLaTeX) |
| `standalone-silicon` | [README](https://github.com/liyuxuan3003/StandaloneSilicon) |
| `pyjool` | [README](https://github.com/liyuxuan3003/PyJool) |
