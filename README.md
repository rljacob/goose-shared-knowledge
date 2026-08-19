# Shared Knowledge

Knowledge that is shared across multiple goose recipes/assistants, rather than owned by a single one.

## Why This Exists

Both the `scientific-assistant` (E3SM/climate science) and `swe-hpc-assistant` (software engineering/HPC) recipes need to know facts about HPC machines: hostnames, batch systems, compilers, schedulers, module systems. Rather than duplicating this in each recipe's own knowledge base, it lives here once and both recipes reference it.

## Contents

- **machines.md** - HPC machine information (hostnames, batch systems, compilers, toolchains, E3SM-specific and SWE/HPC-specific details per machine)

## Location

```
~/.config/goose/shared-knowledge/
├── machines.md
├── README.md
└── sync-knowledge.sh
```

## Usage

Recipes that use this shared knowledge (currently `scientific-assistant` and `swe-hpc-assistant`) reference `~/.config/goose/shared-knowledge/machines.md` directly in their instructions, and are expected to read it at session start and update it when machine-specific facts are learned, in addition to their own recipe-specific knowledge files.

## Cross-Machine Sync

This directory is a git repository, synced independently of the two recipe repos:

- **Repository:** https://github.com/rljacob/goose-shared-knowledge (public)

```bash
cd ~/.config/goose/shared-knowledge
./sync-knowledge.sh
```

See `sync-knowledge.sh` for details.

### First-time setup on a new machine

```bash
mkdir -p ~/.config/goose
cd ~/.config/goose
git clone https://github.com/rljacob/goose-shared-knowledge.git shared-knowledge
cd shared-knowledge
chmod +x sync-knowledge.sh
```

Do this in addition to cloning `scientific-assistant` and/or `swe-hpc-assistant` - the recipes reference this directory by absolute path (`~/.config/goose/shared-knowledge/machines.md`) and expect it to exist alongside them.

## Adding More Shared Knowledge

If other cross-cutting knowledge emerges (not specific to one recipe's domain), it can be added here as an additional file, with recipes updated to reference it.
