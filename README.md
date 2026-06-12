# Automorphism Tower Problem

This repository contains the code and documentation related to the experimental research project on the Automorphism Tower Problem, developed for the Algebraic Computation Laboratory (Academic Year 2024-2025) under the supervision of Prof. Michele D'Adderio.

The project focuses on the iterative study of the chain of groups obtained by successively computing the automorphism groups starting from an initial group G, which is defined as:
G -> Aut(G) -> Aut(Aut(G)) -> ...
until a fixed point is reached (a group isomorphic to its own automorphism group) or the computation terminates due to complexity limits.

## 📁 Repository Structure

The repository is organized as follows:

automorphisms-tower-problem/
├── docs/
│   └── relazioneLABCOMP.pdf   # Scientific report and project documentation
├── src/
│   └── torre.g               # Main source code in the GAP environment
└── gap-packages/
    └── [pacchetti per gap]    # Required GAP packages and dependencies

---

## 🛠️ Requirements and Dependencies

The code is written for the GAP (Groups, Algorithms, and Programming) algebraic computation environment. To run properly, it requires loading the following packages (either pre-installed or placed inside the gap-packages/ directory):

* SONATA (System of Near-Rings and their Applications)
* Polycyclic (Computation with polycyclic groups)
* HAP (Homological Algebra Programming)
* SmallGrp tap (The GAP Small Groups Library)

---

## 🚀 Basic Commands for Usage

Below are the essential commands to launch GAP, load the script, and execute the algorithm from your terminal.

### 1. Launch GAP in the correct directory
Open your system terminal, navigate to the project directory, and launch GAP:
$ cd automorphisms-tower-problem/src
$ gap

### 2. Load the source file (torre.g)
Inside the interactive GAP environment, load the main function by typing:
gap> Read("torre.g");

Note: If you are in a different folder, you can pass the absolute path instead, for example: 
gap> Read("C:/Users/your_user/Desktop/automorphisms-tower-problem/src/torre.g");

### 3. Invoke the function on an input Group
The main function TorreAutomorfismi can be called by passing any valid GAP group as an argument.

#### Example 1: Cyclic Group C_59049
gap> g1 := CyclicGroup(59049);
<pc group of size 59049 with 10 generators>
gap> TorreAutomorfismi(g1);

#### Example 2: Symmetric Group S_3
gap> g2 := SymmetricGroup(3);
Sym( [ 1 .. 3 ] )
gap> TorreAutomorfismi(g2);

#### Example 3: Dihedral Group D_8
gap> g3 := DihedralGroup(8);
<pc group of size 8 with 3 generators>
gap> TorreAutomorfismi(g3);

---

## 📊 Algorithm Output

Upon execution, the function will print to the screen:
1. The structural description of the group at each individual step (via StructureDescription).
2. The total number of steps required to converge to the fixed point of the tower where G is isomorphic to Aut(G).
3. The total computational elapsed time, formatted in milliseconds, seconds, or minutes depending on the complexity of the calculation.

At the end of the execution, the function returns the final stable group object, allowing you to save it into a variable for further algebraic analysis:
gap> gruppo_stabile := TorreAutomorfismi(CyclicGroup(27));