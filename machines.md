# HPC Machine Information (Shared)

Machine-specific configurations, paths, toolchains, and preferences — shared knowledge used by both the `scientific-assistant` (E3SM/climate) and `swe-hpc-assistant` (software engineering/HPC) recipes.

Each machine entry has a common section (hostname, batch system, general notes) plus two domain-specific subsections so both assistants can find what's relevant to them without duplicating shared facts like scheduler type or node layout.

## Format

Document machine-specific details once here. Both assistants read this file and may update it — keep entries dated so it's clear which assistant/session added what.

---

## Machines

### compute-386-05 (ANL GCE Compute Node)

**Hostname:** `compute-386-05`

**Purpose:**
- Development, builds, and local small-scale MPI testing
- Code editing, analysis, and planning
- Profiling analysis (post-processing)

**Hardware (shared):**
- CPU: 2× Intel Xeon Gold 6130 @ 2.10GHz (Skylake-SP, stepping 4)
- Cores: 32 physical cores (16 per socket), 64 logical (HT enabled)
- NUMA: 2 nodes — node0: cores 0–15, 32–47; node1: cores 16–31, 48–63
- RAM: ~187 GiB
- L3 cache: 44 MiB (2× 22 MiB)
- AVX-512 support: yes (avx512f, avx512dq, avx512bw, avx512vl, avx512cd)
- Swap: ~2 GiB

**OS (shared):**
- Ubuntu 22.04.5 LTS (Jammy Jellyfish), kernel 5.15.0-187-generic

**File Locations (shared):**
- Home: `/home/jacob` (NFS via netapp-386-02a-user.cels.anl.gov, 75 TiB shared pool, 64 TiB avail)
- Scratch: `/scratch/jacob` (local HDD, 847 GiB total, **only ~25 GiB free — nearly full**)
- Project storage: `/nfs/gce/projects/` (NFS, various project allocations)
- Global scratch: `/nfs/gce/globalscratch` (10 TiB, 4.9 TiB avail)
- Climate project data: `/nfs/gce/projects/climate` (5 TiB, 1.9 TiB avail)
- Software stack: `/nfs/gce/software` (2 TiB)

**Batch System (shared):**
- No batch scheduler apparent (interactive compute node, not a login node for a cluster)
- Node appears to be a shared compute server within ANL GCE environment

**Quirks/Notes (shared):**
- Scratch (`/scratch`) is 97% full — avoid large temp files there
- InfiniBand not detected via `lsmod` — standard Ethernet networking likely
- Multiple users share this node (see `/home/` users: aavarca, cblakely, emconsta, jacob, mcashdollar, rjackson)

#### E3SM / Climate Science Details (scientific-assistant)
- Cannot run full E3SM cases (not a supported CIME machine, no batch scheduler)
- Climate project data accessible at `/nfs/gce/projects/climate`

#### Software Engineering / HPC Details (swe-hpc-assistant)
- Compilers: GCC 11.4.0 (`gcc`, `g++`, `gfortran`) — system default
- MPI: Open MPI 4.1.2 (`mpirun`, `mpicc`, `mpicxx`, `mpif90`)
- Key CPU flags: AVX-512 (avx512f/dq/bw/vl/cd), AVX2, FMA — use `-march=skylake-avx512` or `-march=native` to exploit
- Debuggers: `gdb` (system), `valgrind` (system)
- Profilers: `perf` (system)
- No Intel compilers, VTune, or TAU detected at time of recording
- Recommended compile flags for perf: `-O3 -march=native -funroll-loops`
- MPI launch: `mpirun` (Open MPI style); for NUMA-aware binding: `mpirun --bind-to core --map-by socket`

---

### Local Development Machine

**Hostname:** (to be recorded on first use)

**Purpose:**
- Code development
- Documentation / analysis / planning
- Local builds and small-scale tests
- Profiling analysis (post-processing)

**General Notes:**
- Use for code editing, planning, and static analysis
- Transfer to HPC for actual experiment runs or large-scale performance work

#### E3SM / Climate Science Details (scientific-assistant)
- E3SM path: /Users/jacob/E3SM
- Cannot run cases (not a supported machine)

#### Software Engineering / HPC Details (swe-hpc-assistant)
- Compilers available: (to be recorded)
- Debuggers/profilers available locally: (to be recorded)

---

### HPC Machines

#### [Machine Name - To Be Added]

**Hostname:**

**Account/Project:**

**Batch System (shared):**
- Type: (SLURM, PBS, etc.)
- Typical wait times:
- Node/core layout (cores per node, NUMA domains, GPUs per node):
- Typical node allocation:

**File Locations (shared):**
- Scratch space:
- Archive/persistent storage:

**Quirks/Notes (shared):**
- Special module requirements:
- Known issues:

#### E3SM / Climate Science Details (scientific-assistant)
- Machine name in CIME:
- Compiler preferences:
- Queue/partition preferences:
- E3SM checkout:
- Case directory:
- Archive location:
- Default compsets:
- Default resolutions:
- Typical run lengths:
- Performance tips (E3SM-specific):

#### Software Engineering / HPC Details (swe-hpc-assistant)
- Compilers available (e.g., Intel, GNU, Cray, NVHPC):
- Default/recommended compiler + version:
- Key optimization flags used:
- MPI implementation (e.g., Cray MPICH, OpenMPI, MVAPICH) + version:
- Launch command (e.g., srun, aprun, mpirun):
- Profilers available (e.g., perf, VTune, TAU, HPCToolkit, nsight):
- Debuggers available (e.g., DDT, TotalView, gdb, cuda-gdb):
- Known compiler bugs or workarounds:
- Performance tips (general/engineering):

---

## Sync Strategy

**Current Approach:** GitHub-based sync, shared across both assistants' sessions.

**Setup:**
- Git repository: (to be added - your GitHub URL for shared-knowledge)
- Sync script: `~/.config/goose/shared-knowledge/sync-knowledge.sh`
- Goose installed: Local ✓, HPC (to be installed)

**Sync Commands:**
```bash
# Before work - get latest
cd ~/.config/goose/shared-knowledge
./sync-knowledge.sh

# After work - push updates
./sync-knowledge.sh
```

**Workflow:**
1. Local: Plan work with either assistant → sync
2. HPC: Pull sync → run experiments/code/profiling → use Goose to document → sync
3. Local: Pull sync → both assistants now know about HPC results
4. Both assistants can read and update this shared file
5. Git keeps everything synchronized

**Automation:**
- Manual sync: Run `./sync-knowledge.sh` before/after work
- Optional cron: Can set up hourly sync on HPC
- Git hooks: Can auto-push on commit

---

## Cross-Machine Workflows

### Code Development → Testing → Production

**Development (Local):**
1. Edit code
2. Commit changes
3. Plan experiment or optimization with the relevant assistant

**Testing (HPC):**
1. Sync code and shared knowledge
2. Create test case / small-scale run or profiling job
3. Run and verify
4. Update shared knowledge with results

**Production (HPC):**
1. Create production case / full-scale run
2. Submit long run
3. Monitor progress
4. Document outcomes

---

## Machine-Specific Learning

### [Machine Name] Performance Notes
- To be populated

### [Machine Name] Common Issues
- To be populated

---

## Update History

### [2026-08-19] Recorded compute-386-05 (ANL GCE)
Recorded hostname, hardware (2× Xeon Gold 6130, 32 cores, 64 logical, 187 GiB RAM, AVX-512), OS (Ubuntu 22.04.5), compilers (GCC 11.4.0, Open MPI 4.1.2), storage layout, and notable quirks (scratch 97% full, no batch scheduler, no IB).

### [2026-08-19] Consolidated from per-recipe machines.md files
Merged `scientific-assistant/knowledge/machines.md` and `swe-hpc-assistant/knowledge/machines.md` into this shared file. Both recipes now reference this file instead of maintaining separate copies.

### [2026-07-26] Original scientific-assistant Machine Knowledge File
Created to handle multi-machine workflows (climate/E3SM focus).

### [2026-08-19] Original swe-hpc-assistant Machine Knowledge File
Created as part of swe-hpc-assistant scaffolding (SWE/HPC engineering focus).

**Next Steps:**
- Add specific HPC machine details on first use
- Document sync strategy
- Record machine-specific preferences for both domains
