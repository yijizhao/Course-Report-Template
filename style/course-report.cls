%% =========================================================================
%% Course Report Template (XeLaTex)
%% 
%% Author: 赵苡积 (Yiji Zhao, School of Information Science and Engineering, Yunnan University)
%% GitHub: https://github.com/yijizhao
%% 
%% =========================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{style/course-report}

% 继承 ctexart 以支持中文
\LoadClass[a4paper,UTF8,zihao=-4]{ctexart}

% 导入宏包
\RequirePackage{geometry}
\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{booktabs} % 三线表
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{amsmath}
\RequirePackage{lmodern} % 提供任意大小的矢量数学字体，消除cmex字体大小替换警告
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{fancyhdr} %页眉页脚
\RequirePackage{url} % 处理网址格式
\RequirePackage[hidelinks]{hyperref} % 支持超链接，hidelinks参数用于隐藏默认的红框

\RequirePackage{xeCJKfntef} % 用于支持中文的自动换行下划线

% 字体设置
\setmainfont{Times New Roman} % 英文要求小四号Times New Roman

% 行间距设置
\setstretch{1.5} % 行间距1.5倍
% 页眉页脚设置
\pagestyle{fancy}
\fancyhf{} % 清空默认的所有页眉和页脚设置
\renewcommand{\headrulewidth}{0pt} % 彻底去掉页眉的横线
\cfoot{\zihao{-5}\thepage} % 页脚居中（cfoot），使用小五号字（\zihao{-5}）显示连续页码（\thepage）

% 图表标题格式设置
\captionsetup{font={small}, labelsep=quad} % small 近似于五号宋体
\captionsetup[table]{skip=0.5\baselineskip} % 表格编号和标题距正文段前0.5倍行距

% 章节标题格式设置
\ctexset{
    section={
        format=\zihao{3}\heiti,
        name={,、},
        number=\chinese{section},
        aftername={}, % 强制置空编号后的默认大空格
    },
    subsection={
        format=\zihao{4}\bfseries,
        number=\arabic{section}.\arabic{subsection},
        aftername={\ \ }, % 给标题编号后留空格
    }
}

% 封面信息定义
\newcommand{\coursetitle}[1]{\def\@coursetitle{#1}} % 报告大标题
\newcommand{\expname}[1]{\def\@expname{#1}}
\newcommand{\studentname}[1]{\def\@studentname{#1}}
\newcommand{\studentid}[1]{\def\@studentid{#1}}
\newcommand{\major}[1]{\def\@major{#1}}
\newcommand{\expdate}[1]{\def\@expdate{#1}}

% 声明一个不可见的盒子，用于测量实验名称的真实物理宽度
\newbox\expnamebox 
% 封面生成命令 [cite: 3]
\newcommand{\makecover}{
    \begin{titlepage}
        \centering
        \vspace*{1.5cm}
        % 请在此处插入学校 Logo 图片
        \includegraphics[width=0.4\textwidth]{style/logo.png}\par 
        \vspace{1cm}
        {\zihao{1}\heiti \@coursetitle\par}
        \vspace{0.5cm}
        \vspace{1.5cm}
        \zihao{4}
        \renewcommand{\arraystretch}{1.5}
        % 将实验名称装入预设的盒子中进行测量
        \sbox{\expnamebox}{\@expname}
        \begin{tabular}{rc}
            \makebox[5em][s]{\bfseries 题\qquad 目：} & 
            % 核心判断逻辑：如果文字宽度小于 300pt，强制补全底线；否则自动换行
            \ifdim\wd\expnamebox<300pt
                \underline{\makebox[300pt][c]{\@expname}}
            \else
                \parbox[t]{300pt}{\linespread{1.3}\selectfont\centering\CJKunderline{\@expname}}
            \fi \\[1.5ex]
            \makebox[5em][s]{\bfseries 姓\qquad 名：} & \underline{\makebox[300pt][c]{\@studentname}} \\[1ex]
            \makebox[5em][s]{\bfseries 学\qquad 号：} & \underline{\makebox[300pt][c]{\@studentid}} \\[1ex]
            \makebox[5em][s]{\bfseries 专\qquad 业：} & \underline{\makebox[300pt][c]{\@major}} \\[1ex]
            \makebox[5em][s]{\bfseries 日\qquad 期：} & \underline{\makebox[300pt][c]{\@expdate}} \\
        \end{tabular} %
        \vfill
    \end{titlepage}
    \setcounter{page}{1}
}


% 代码块高亮样式配置
\lstset{
    % 设置基础字体，并使用 \linespread{1.0} 强制覆盖全局的 1.5 倍行距，使代码紧凑
    basicstyle=\linespread{1.0}\ttfamily\small, 
    keywordstyle=\color{blue},
    commentstyle=\color{green!50!black},
    stringstyle=\color{red},
    showstringspaces=false,
    numbers=left,
    numberstyle=\tiny\color{gray},
    frame=none, % 去掉边框，完美解决跨页断框问题
    breaklines=true,
    xleftmargin=2em, % 因为没有边框了，给左侧行号留出缩进空间
    aboveskip=3ex, % 减小代码块与正文的上方间距
    belowskip=3ex  % 减小代码块与正文的下方间距
}


%参考文献风格
\bibliographystyle{style/gbt7714-numerical}

% ================== 参考文献设置 ==================
% 使用 natbib 兼容 GBT7714，并原生支持自动压缩与右上角上标
\RequirePackage[numbers,sort&compress,super,square]{natbib}

% 设置参考文献列表的字号和极致紧凑的间距
\renewcommand{\bibfont}{\zihao{5}} % 强制五号字体
\setlength{\bibsep}{1pt} % 极致紧凑：条目间的垂直间距为 0pt

% 强制标签左对齐（natbib 官方支持做法）
\renewcommand{\bibnumfmt}[1]{\makebox[\labelwidth][c]{[#1]}}

\makeatletter
% 将参考文献标题格式化，并自动加入目录
\renewcommand\bibsection{%
    \section{\refname}%
    \addcontentsline{toc}{section}{\refname}%
}
\makeatother
% ==================================================