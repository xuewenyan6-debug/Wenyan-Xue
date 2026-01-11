# DDG-Trajectory-Planning for Offshore Wind Farm Inspection

![UAV Inspection](https://img.shields.io/badge/Application-Offshore_Inspection-blue) 
![Multi-Agent](https://img.shields.io/badge/Architecture-Multi_Agent_System-green) 
![Confidential](https://img.shields.io/badge/Status-Confidential-red)

## 📖 Introduction
The project implements a Distributed Differential Game (DDG) framework for optimal, collision-free, and energy-aware trajectory planning of multiple UAVs inspecting offshore wind turbines under constraints of limited communication, sensing, and round-trip energy requirements. It integrates:

- Multi-agent coordination
- Remote sensing data processing
- Advanced path planning techniques


## 🌐 Data Description
| Data Type | Source | Access Date |
|-----------|--------|-------------|
| Guangdong Province Administrative Division | [Open Source Toolkit](https://gitcode.com/open-source-toolkit/a39c7) | April 20, 2025 |
| Yangjiang City Remote Sensing | [Geospatial Cloud](http://www.gscloud.cn/#/) | April 13, 2025 |
| DJI Matrice 350 RTK UAV Specifications | [DJI Enterprise](https://enterprise.dji.com/cn/matrice-350-rtk) | March 30, 2025 |

## 💻 Code Description
This project’s foundational architecture is partially based on implementations from the open-source community. To protect the core intellectual property of our commercial partners, the code snippets shown here are selected from publicly available GitHub repositories (used with proper authorization) and are intended solely for demonstrating the technical approach.

.
├── /DDG_Algorithm/               # Core DDG Algorithm Implementation
│   ├── DDG_Solver.m              # Main DDG solver (implements the proposed framework)
│   ├── UAV_Dynamics.m            # Quadrotor dynamic model (Equations 1-5)
│   ├── Cost_Function.m           # Individual UAV cost function (Equation 9)
│   ├── Pontryagin_Solver.m       # Solver using Pontryagin's Minimum Principle (Eq. 20-21)
│   └── Gradient_Optimization.m   # Distributed gradient optimization (Algorithm 1)
│
├── /Benchmark_Methods/           # Baseline Methods for Comparison
│   ├── GA_DZ/                    # Genetic Algorithm with Dynamic Zoning [6]
│   │   ├── GA_Main.m
│   │   └── fitness_function.m
│   └── NN_DRL/                   # Neural Network Deep Reinforcement Learning [9]
│       ├── train_DQN.py
│       ├── evaluate_policy.py
│       └── model_weights.h5
│
├── /Simulation_Data/             # Minimal Dataset for Reproducibility
│   ├── Scenario_1_3UAV_28Turbines/   # Scenario 1: 3 UAVs, 28 Turbines
│   │   ├── turbine_locations.csv     # Wind turbine coordinates (X, Y)
│   │   ├── initial_conditions.mat    # UAV initial states (position, velocity)
│   │   ├── assigned_tasks.json       # Pre-assigned inspection tasks per UAV
│   │   └── DDG_Results.mat           # Full DDG output (trajectories, errors, etc.)
│   │
│   ├── Scenario_2_6UAV_40Turbines/   # Scenario 2: 6 UAVs, 40 Turbines
│   │   ├── ... (similar structure)
│   │
│   └── Benchmark_Results/        # Pre-computed results from baseline methods
│       ├── GA_DZ_Results_Scenario1.mat
│       └── NN_DRL_Results_Scenario1.mat
│
├── /Scripts_Generate_Figures/    # Scripts to Reproduce All Paper Figures
│   ├── Figure_3_Trajectories.m               # Trajectory comparison (Figs. 3 & 6)
│   ├── Figure_4_Minimum_Distance.m           # Minimum safety distance (Figs. 4 & 7)
│   ├── Figure_5_State_Error.m                # State error convergence (Figs. 5 & 8)
│   ├── Figure_9_Computation_Time.m           # Computation time comparison (Fig. 9)
│   ├── Figure_10_Statistical_Analysis.m      # Statistical box plots (Fig. 10)
│   ├── Figure_11_Scalability_Centralized.m   # Scalability vs. centralized solver (Fig. 11)
│   └── Figure_12_DMPC_Comparison.m           # Comparison with DMPC [15] (Fig. 12)
│
├── /Results_and_Tables/          # Numerical Results Corresponding to Paper Tables
│   ├── Table_4_Inspection_Sequences.csv      # Inspection sequences & path lengths (Table 4)
│   ├── Table_5_Inspection_Sequences_6UAV.csv # Sequences for 6-UAV scenario (Table 5)
│   ├── Table_6_Statistical_Results.csv       # 30 random scenario statistics (Table 6)
│   └── convergence_data.mat                  # Algorithm convergence history
│
├── /Parameters/                  # All Simulation Parameters
│   ├── UAV_Parameters.mat                    # UAV physical parameters (Table 3 in paper)
│   ├── DDG_Weights.m                         # Weight matrices Q_i, R_i, R_ij, F_i
│   └── Simulation_Settings.m                 # Time horizon, step size, stopping criteria
│
├── README.md                     # This file
└── LICENSE                       # MIT License















### 📚 Open-Source Components
We gratefully acknowledge these open-source contributions:

#### 1. A* Algorithm Implementation
<p align="left">
  <img src="https://img.shields.io/badge/License-BSD--3--Clause-blue" alt="BSD-3-Clause">
</p>

- **Source**: [python-astar](https://github.com/jrialland/python-astar)
- **Copyright**: © 2012-2021 Julien Rialland

#### 2. DQN Implementation (PyTorch)
<p align="left">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT">
</p>

- **Source**: [Deep-RL-PyTorch](https://github.com/sweetice/Deep-reinforcement-learning-with-pytorch)
- **Copyright**: © 2018 Johnny He

#### 3. Dijkstra Path Planning
<p align="left">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT">
</p>

- **Source**: [Path-Planning-Simulator](https://github.com/sahibdhanjal/Path-Planning-Simulator)
- **Copyright**: © 2017 Sahib Singh Dhanjal

#### 4. Simulated Annealing Algorithm
<p align="left">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT">
</p>

- **Source**: [scikit-opt](https://github.com/guofei9987/scikit-opt)
- **Copyright**: © 2019 Fei Guo

#### 5. K-Means
<p align="left">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT">
</p>

- **Source**: [fast-pytorch-kmeans](https://github.com/DeMoriarty/fast_pytorch_kmeans)
- **Copyright**: © 2018 Sehban Omer
