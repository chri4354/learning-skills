# Setup — students

Five minutes, once. Pick the section for the tool you use. If you use both, do both.

---

## If you use Cursor

Two one-time steps. After these, it works in every folder you open — no per-project
setup, ever.

### Step 1 — install the skill globally

```bash
git clone https://github.com/chri4354/learning-skills.git ~/tools/learning-skills
```

```bash
~/tools/learning-skills/install.sh cursor --global
```

That puts the teaching skill in `~/.cursor/skills/study-companion/`, which Cursor
loads in every workspace. It never touches `~/.cursor/skills-cursor/` — that folder
is Cursor's own, leave it alone.

### Step 2 — turn on the always-on posture

The skill above carries the full teaching loop, but Cursor only reaches for a skill
when your request matches it. The short default posture — try first, no pasteable
answers, always end with a question — lives in *rules*, and Cursor rules are
per-project. The one global home for it is the User Rules box:

1. Open Cursor Settings and find **Rules** (search settings for "rules"; some
   versions call it *Rules & Memories*, older ones *Rules for AI*).
2. Open `~/tools/learning-skills/dist/cursor/user-rules.txt`.
3. Copy all of it, paste into User Rules, save.

Skip Step 2 and it still works — you'll just have to ask for help more explicitly
instead of getting the teaching posture by default.

### Optional — per coursework folder

If you'd rather keep it project-scoped, or your tutor gives you a starter repo with
it built in, run this inside the folder instead of Step 1:

```bash
~/tools/learning-skills/install.sh cursor
```

That writes `.cursor/skills/` and `.cursor/rules/` into that folder only.

## If you use Claude Code

One command, covers everything, everywhere:

```bash
git clone https://github.com/chri4354/learning-skills.git ~/tools/learning-skills
```

```bash
~/tools/learning-skills/install.sh claude --global
```

Claude Code does support global install properly, so there is no Step 2.

## If you switch between the two

Run `install.sh all --global` once — that covers the Cursor skill, Claude Code and
Codex in one go — then do the Cursor User Rules paste from Step 2. The two tools
don't share configuration, so both halves are needed.

---

## What changes

Ask it to explain something and it will work out what you already know, ask you to
try first, explain at the level you're actually at, make you explain it back, and
test you. It tells you what to understand first and what to study next.

It will not hand you a finished answer by default. It will hand you one the moment
you ask:

> **just give me the answer**

No lecture, no argument. There's also **deadline mode** — say that and it stops
teaching entirely, gives you what you need, and saves a couple of review questions
for after you've submitted.

## The `.learning/` folder

It keeps notes on what you've worked on and where you got stuck, in
`.learning/profile.md` and `.learning/ledger.md`. Plain markdown. Open them, edit
them, delete them — they're yours.

Two things worth knowing:

- **Nothing leaves your machine.** No account, no telemetry, no uploads. If your
  coursework folder is a git repo, the installer adds `.learning/` to `.gitignore`
  so it can't be committed by accident.
- **It's useful to you.** If your course asks you to declare how you used AI,
  `.learning/ledger.md` is a far better answer than "I used ChatGPT" — it shows
  what you actually did.

## Turning it off

Delete the files the installer wrote, or clear the User Rules box in Cursor
settings. It's markdown, not a program. Read it before you trust it:
[`src/always-on.md`](../src/always-on.md).

## A note on Cursor's free plan

Rules work identically on the free plan. The always-on posture adds a small amount
of text to each request; it doesn't change how many requests you get.
