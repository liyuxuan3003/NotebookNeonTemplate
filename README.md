# NotebookNeonTemplate

NotebookNeonTemplate是一个开箱即用的LaTeX模板，适用于长文档，基于自定义文档类`notebook-neon`和自定义宏包`minimus`。

NotebookNeonTemplate是LumosLaTeX计划的一部分：https://github.com/liyuxuan3003/LumosLaTeX

## 引入方式

克隆模板仓库

```bash
git clone git@github.com/liyuxuan3003/NotebookNeonTemplate.git
```

初始化项目
```
cd NotebookNeonTemplate
./init.sh MyProject
```

初始化会自动完成项目重命名、子模块加载、移除模板的远程引用等操作，只能执行一次。

## 目录结构

项目的目录结构如下

```
NotebookNeonTemplate    # The root of git repo
|- .git
|- MyProject            # The sub dir of source files (run make here!)
.  |- build/
.  |- makefile-latex/
.  |- minimus/
.  |- pyjool
.  |- notebook-neon/
.  |- standalone-silicon/
.  |- Makefile
.  |- MyProject.tex
.  |- Chapter01.tex
.  |- Chapter02.tex
.  |- FigTikz.fig.tex
.  |- FigOctave.fig.m
.  |- FigMathematica.fig.wls
.  |- FigPython.fig.py
|- .gitignore
|- .gitmodules
|- init.sh
|- README.md
|- NotebookNeonTemplate.md
```

请注意，根目录下仅有`.gitignore`和`README.md`等文件，代码均位于一个二级目录下！

## 构建方式

模板提供`Makefile`进行编译，任何`make`命令都需要在二级目录下运行。

编译文档及其插图

```bash
make -j
```

清理文档输出目录

```bash
make clean
```

## 子模块

模板的具体使用方式，请参见各个子模块的文档。

| 子模块 | 文档 |
|--------|------|
| `notebook-neon` | [README](NotebookNeonTemplate/notebook-neon/README.md) |
| `minimus` | [README](NotebookNeonTemplate/minimus/README.md) |
| `makefile-latex` | [README](NotebookNeonTemplate/makefile-latex/README.md) |
| `standalone-silicon` | [README](NotebookNeonTemplate/standalone-silicon/README.md) |
| `pyjool` | [README](NotebookNeonTemplate/pyjool/README.md) |
