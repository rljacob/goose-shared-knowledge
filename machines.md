# HPC Machine Information (Shared)

Machine-specific configurations, paths, toolchains, and preferences — shared knowledge used by both the `scientific-assistant` (E3SM/climate) and `swe-hpc-assistant` (software engineering/HPC) recipes.

Each machine entry has a common section (hostname, batch system, general notes) plus two domain-specific subsections so both assistants can find what's relevant to them without duplicating shared facts like scheduler type or node layout.

## Format

Document machine-specific details once here. Both assistants read this file and may update it — keep entries dated so it's clear which assistant/session added what.

---

## Machines

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
