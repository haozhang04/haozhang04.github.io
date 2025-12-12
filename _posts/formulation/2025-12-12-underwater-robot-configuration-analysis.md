---
layout: post
title: 水下机器人涵推构型分析
date: 2025-12-12
categories: [formulation]
tags: [underwater robot, dynamics, control]
description: 水下机器人涵推构型分析，包括电机混控、四棱锥模型、长方形模型及 SO3 控制器设计。
---

## 1.1 电机混控

无人机（或水下机器人）每个旋翼提供的升力和反作用力矩如图所示。定义第 $i$ 个螺旋桨的转子坐标系为 $O_i$，转子坐标系的 $z$ 轴与电机轴重合。记第 $i$ 个螺旋桨提供的升力和反作用力矩分别 $F_i$ 和 $\tau_i$，对于逆时针 (CCW) 旋转的螺旋桨反作用力矩为负，对于顺时针 (CW) 旋转的桨反作用力矩为正。$F_i$ 和 $\tau_i$ 与螺旋桨转速 $\omega_i$ 的关系可以近似为：

$$
F_i = C_f \omega_i^2
$$

$$
\tau_i = S_i C_\tau \omega_i^2
$$

(1-1)

其中 $C_f$ 和 $C_\tau$ 是与空气动力学参数相关的系数。$S_i$ 表示螺旋桨的旋向，当螺旋桨逆时针(CCW)旋转时，$S_i = -1$; 当螺旋桨顺时针(CW)旋转时，$S_i = 1$。因此可以将 $\tau_i$ 记作：

$$
\tau_i = k S_i F_i \quad (1-2)
$$

其中 $k = C_\tau/C_f$。考虑到利用公式就可由升力求得对应的螺旋桨转速，为了简便书写，后续的推导将以螺旋桨的升力作为控制输入。

第 $i$ 个螺旋桨在作用点处的力和力矩在机体坐标系下的表示为：

$$
f_i = R_i [0, 0, F_i]^T
$$

$$
\tau_i = R_i [0, 0, S_i \tau_i]^T \quad (1-3)
$$

将所有力和力矩向质心简化，$n$ 个螺旋桨提供的合力在机体坐标系下的表示为：

$$
F = \sum_{i=0}^{n-1} f_i
$$

$$
\tau = \sum_{i=0}^{n-1} (p_i \times f_i + \tau_i) \quad (1-4)
$$

其中 $p_i$ 为机体质心到螺旋桨受力点的位置矢量。解上述方程，就可以由控制输入 $F$ 和 $\tau$ 计算每个螺旋桨的升力和倾转电机的角度。

## 1.2 四棱锥模型

### 1.2.1 动力分配矩阵

控制模型可以简化为底面为长方形的四棱锥构型。每个螺旋桨产生的力/力矩的作用点位于长方形的四个顶点，转子坐标系的 $z$ 轴和四棱锥的棱共线。机体坐标系原点位于长方形几何中心，xoy 平面和长方形共面。

转轴单位向量公式（右手系，XY 平面内）：

$$
v_0 = [\frac{a}{\sqrt{a^2+b^2}}, \frac{b}{\sqrt{a^2+b^2}}, 0]^T
$$
$$
v_1 = [-\frac{a}{\sqrt{a^2+b^2}}, \frac{b}{\sqrt{a^2+b^2}}, 0]^T
$$
$$
v_2 = [-\frac{a}{\sqrt{a^2+b^2}}, -\frac{b}{\sqrt{a^2+b^2}}, 0]^T
$$
$$
v_3 = [\frac{a}{\sqrt{a^2+b^2}}, -\frac{b}{\sqrt{a^2+b^2}}, 0]^T
$$

(1-5)

各转子坐标系为标准坐标系绕各转轴旋转 $\theta$ 后的结果，转轴转角的 Rodrigues 公式为：

$$
R(n, \theta) = I + \sin\theta [n]_\times + (1-\cos\theta)[n]_\times^2
$$

(1-6)

其中，$n = [n_x, n_y, n_z]^T$，是单位向量。$\theta$ 为转角。

首先，利用第一章中的公式来推导混控矩阵，可以列出以下关系：

$$
\begin{aligned}
p_0 &= [ \frac{a}{2}, -\frac{b}{2}, 0 ]^T \\
p_1 &= [ \frac{a}{2}, \frac{b}{2}, 0 ]^T \\
p_2 &= [ -\frac{a}{2}, \frac{b}{2}, 0 ]^T \\
p_3 &= [ -\frac{a}{2}, -\frac{b}{2}, 0 ]^T
\end{aligned} \quad (1-7)
$$

(注：原文公式可能略有不同，此处根据常见的四旋翼布局修正)

带入（1-4）可得：

$$
F = \sum_{i=0}^{n-1} R_i [0, 0, 1]^T F_i
$$

$$
\tau = \sum_{i=0}^{n-1} (p_i \times R_i [0, 0, 1]^T + R_i [0, 0, 1]^T k S_i) F_i \quad (1-8)
$$

写成矩阵形式：

$$
\begin{bmatrix}
F \\
\tau
\end{bmatrix} = M \begin{bmatrix} f_0 \\ f_1 \\ f_2 \\ f_3 \end{bmatrix}
$$

$$
M = \begin{bmatrix}
\frac{a}{\sqrt{a^2+b^2}}s\theta & -\frac{b}{\sqrt{a^2+b^2}}s\theta & -\frac{a}{\sqrt{a^2+b^2}}s\theta & \frac{b}{\sqrt{a^2+b^2}}s\theta \\
-\frac{b}{\sqrt{a^2+b^2}}s\theta & \frac{a}{\sqrt{a^2+b^2}}s\theta & \frac{b}{\sqrt{a^2+b^2}}s\theta & -\frac{a}{\sqrt{a^2+b^2}}s\theta \\
c\theta & c\theta & c\theta & c\theta \\
-\frac{b}{2}c\theta + S_0 k \frac{a}{\sqrt{a^2+b^2}}s\theta & \frac{b}{2}c\theta + S_1 k \frac{a}{\sqrt{a^2+b^2}}s\theta & \frac{b}{2}c\theta - S_2 k \frac{a}{\sqrt{a^2+b^2}}s\theta & -\frac{b}{2}c\theta - S_3 k \frac{a}{\sqrt{a^2+b^2}}s\theta \\
-\frac{a}{2}c\theta - S_0 k \frac{b}{\sqrt{a^2+b^2}}s\theta & -\frac{a}{2}c\theta + S_1 k \frac{b}{\sqrt{a^2+b^2}}s\theta & \frac{a}{2}c\theta + S_2 k \frac{b}{\sqrt{a^2+b^2}}s\theta & \frac{a}{2}c\theta - S_3 k \frac{b}{\sqrt{a^2+b^2}}s\theta \\
S_0 k c\theta & S_1 k c\theta & S_2 k c\theta & S_3 k c\theta
\end{bmatrix}
$$

(1-13)

为了简化，假设螺旋桨旋转方向顺序为 $[+1, -1, +1, -1]$（即 $S_0=1, S_1=-1, S_2=1, S_3=-1$）。

$$
\begin{bmatrix}
f_x \\ f_y \\ f_z \\ \tau_x \\ \tau_y \\ \tau_z
\end{bmatrix} = 
\begin{bmatrix}
A s\theta & -B s\theta & -A s\theta & B s\theta \\
-B s\theta & -A s\theta & B s\theta & A s\theta \\
c\theta & c\theta & c\theta & c\theta \\
-\frac{b}{2} c\theta + k A s\theta & \frac{b}{2} c\theta - k A s\theta & \frac{b}{2} c\theta + k A s\theta & -\frac{b}{2} c\theta - k A s\theta \\
-\frac{a}{2} c\theta - k B s\theta & -\frac{a}{2} c\theta - k B s\theta & \frac{a}{2} c\theta + k B s\theta & \frac{a}{2} c\theta + k B s\theta \\
k c\theta & -k c\theta & k c\theta & -k c\theta
\end{bmatrix}
\begin{bmatrix}
f_0 \\ f_1 \\ f_2 \\ f_3
\end{bmatrix}
$$

(1-14)

其中 $A = \frac{a}{\sqrt{a^2+b^2}}$, $B = \frac{b}{\sqrt{a^2+b^2}}$, $s\theta = \sin\theta$, $c\theta = \cos\theta$。

### 1.2.2 耦合证明

基于公式 (1-15) 推导（此处略去详细推导过程）。

定义 4 个与力和力矩有关的组合量：

$$
\begin{aligned}
\Gamma &= f_0 + f_1 + f_2 + f_3 \\
\Gamma_1 &= f_0 + f_1 - f_2 - f_3 \\
\Gamma_2 &= -f_0 + f_1 + f_2 - f_3 \\
\Gamma_3 &= f_0 - f_1 + f_2 - f_3
\end{aligned} \quad (1-16)
$$

对于 $\tau_x$ 和 $\tau_y$：

$$
\tau_x = (\frac{b}{2} \cos\theta - k \frac{a}{\sqrt{a^2+b^2}} \sin\theta) \Gamma_2
$$

$$
\tau_y = (-\frac{a}{2} \cos\theta - k \frac{b}{\sqrt{a^2+b^2}} \sin\theta) \Gamma_1
$$

(1-18)

## 1.3 长方形模型

### 1.3.1 动力分配矩阵

令 $\theta = 0$：

$$
\begin{bmatrix}
f_x \\ f_y \\ f_z \\ \tau_x \\ \tau_y \\ \tau_z
\end{bmatrix} = 
\begin{bmatrix}
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 1 & 1 & 1 \\
-\frac{b}{2} & \frac{b}{2} & \frac{b}{2} & -\frac{b}{2} \\
-\frac{a}{2} & -\frac{a}{2} & \frac{a}{2} & \frac{a}{2} \\
k & -k & k & -k
\end{bmatrix}
\begin{bmatrix}
f_0 \\ f_1 \\ f_2 \\ f_3
\end{bmatrix}
\quad (1-20)
$$

## 1.4 加 2 垂直推进器 4, 5 模型

### 1.4.1 动力分配矩阵

位于 $4-[l, m, n], 5-[l, -m, n]$。

$$
F = \sum_{i=0}^{n-1} f_i
$$

$$
p_{0-3} = \dots, \quad p_{4-5} = Rot_y(90) \dots
$$

（注：$Rot_y(90)$ 表示绕 Y 轴旋转 90 度）

增加垂直推进器后的混合矩阵 $M$：

$$
M = \begin{bmatrix}
0 & 0 & 0 & 0 & 1 & 1 \\
0 & 0 & 0 & 0 & 0 & 0 \\
1 & 1 & 1 & 1 & 0 & 0 \\
-\frac{b}{2} & \frac{b}{2} & \frac{b}{2} & -\frac{b}{2} & S_4 k & S_5 k \\
-\frac{a}{2} & -\frac{a}{2} & \frac{a}{2} & \frac{a}{2} & n & n \\
S_0 k & S_1 k & S_2 k & S_3 k & -m & m
\end{bmatrix}
\quad (1-27)
$$

## 1.5 SO3 控制器

对于机器人位置：

$$
F_T - F_{floating} + G = F_d \quad (1-29)
$$

其中，$F_T$ 为世界系下作用到 base_link 的力，$F_{floating}$ 为浮力，$G$ 为重力，$F_d$ 为世界系下推进器期望的合力。

设计 PD + 前馈控制律为：

$$
e_p = x - x_{ref}
$$
$$
e_v = v - v_{ref}
$$
$$
F_d = -k_p e_p - k_d e_v + m a_{ref} - F_{floating} + m g e_z
\quad (1-30)
$$

对于机器人姿态动力学：

$$
\dot{R} = R [\omega]_\times
$$
$$
J \dot{\omega} + \omega \times J \omega = \tau
\quad (1-31)
$$

姿态误差:

$$
e_R = \frac{1}{2} (R_d^T R - R^T R_d)^\vee \quad (1-32)
$$

角速度误差:

$$
e_\omega = \omega - R^T R_d \omega_d \quad (1-33)
$$

控制律:

$$
\tau = -k_R e_R - k_\omega e_\omega + \omega \times J \omega - J ([\omega]_\times R^T R_d \omega_d - R^T R_d \dot{\omega}_d) \quad (1-34)
$$

所有物理量均在机体坐标系下表示。
