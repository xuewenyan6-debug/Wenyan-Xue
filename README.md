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

- DDG_Algorithm（threeUAVs:results_3UAV-28Turbine_20251214_105152.m）
   ── UAV_Dynamics.m            # Quadrotor dynamic model (Equations 1-5)
   ── Cost_Function.m           # Individual UAV cost function (Equation 9)
   ── Pontryagin_Solver.m       # Solver using Pontryagin's Minimum Principle (Eq. 20-21)
   ── Gradient_Optimization.m   # Distributed gradient optimization (Algorithm 1)

- GA_DZ （threeUAVs:results_3UAV-28Turbine_20251214_105152.m）                  # Genetic Algorithm with Dynamic Zoning [6]
- NN_DRL（threeUAVs:results_3UAV-28Turbine_20251214_105152.m）                 # Neural Network Deep Reinforcement Learning [9]
- Simulation_Data             # Minimal Dataset for Reproducibility
   ── Scenario_1_3UAV_28Turbines(results_3UAV-28Turbine_20251214_105152.mat)   # Scenario 1: 3 UAVs, 28 Turbines
   ── turbine_locations.csv     # Wind turbine coordinates (X, Y)
   ── initial_conditions.mat    # UAV initial states (position, velocity)
   ── assigned_tasks.json       # Pre-assigned inspection tasks per UAV
   ── DDG_Results.mat           # Full DDG output (trajectories, errors, etc.)
   ── GA_DZ_Results_Scenario1.mat
   ── NN_DRL_Results_Scenario1.mat
  

-Scenario_2_6UAV_40Turbines(results_6UAV-40Turbine_20251214_105204.mat)   # Scenario 2: 6 UAVs, 40 Turbines
   ── turbine_locations.csv     # Wind turbine coordinates (X, Y)
   ── initial_conditions.mat    # UAV initial states (position, velocity)
   ── assigned_tasks.json       # Pre-assigned inspection tasks per UAV
   ── DDG_Results.mat           # Full DDG output (trajectories, errors, etc.)
   ── GA_DZ_Results_Scenario1.mat
   ── NN_DRL_Results_Scenario1.mat

  ── /Scripts_Generate_Figures/    # Scripts to Reproduce All Paper Figures
  ── threeUAVs:results_3UAV-28Turbine_20251214_105152.m               # Trajectory comparison (Fig. 3)
  ── threeUAVs:results_3UAV-28Turbine_20251214_105152.m          # Minimum safety distance (Fig. 4)
  ── threeUAVs:results_3UAV-28Turbine_20251214_105152.m                # State error convergence (Fig. 5)
  ── sixUAVstradis.m           # Trajectory comparison (Fig. 6)
  ── sixUAVstradis.m        # Minimum safety distance (Fig. 7)
     ── sixUAVstradis.m        # State error convergence (Fig. 8)
    ── computationtimetwoscle.m        # Computation time comparison (Fig. 9)
    ── random.m        # 30 random scenarios with the three methods (Fig. 10)
    ── discen.m          # The comparison of computation time (Fig. 11)
   ──DDGDMPCtime.m          # DDGDMPC (Fig. 12)
-DDG Parameters                  # All Simulation Parameters
   ── final_parameters.mat                    # UAV physical parameters Weight matrices Q_i, R_i, R_ij, F_i Time horizon, step size, stopping criteria

### Quick Start (Reproducing Main Results)
We gratefully acknowledge these open-source contributions:

#### 1.Prerequisites
MATLAB (R2021a or later, primary environment)
Required Toolboxes: Control System Toolbox, Optimization Toolbox

#### 2. Data Content:

Input Data: Wind turbine coordinates (simulated and anonymized), UAV initial states, and task allocations that serve as the starting point for all simulations.

Generated Results: Optimal trajectories (position, velocity), control inputs (u_i), state errors (z_tilde), safety metrics (min_distance), and all calculated performance indicators (completion time, path length, computation time).

Benchmark Results: Output data from the GA-DZ and NN-DRL methods for direct comparison.
