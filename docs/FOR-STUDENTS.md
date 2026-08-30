# Setup — students

Five minutes, once. Pick the section for the tool you use. If you use both, do both.

---

## If you use Cursor — the one-file way (recommended)

No terminal, no clone, works on Mac and Windows.

1. Download **[`SKILL.md`](../dist/cursor/skills/study-companion/SKILL.md)** (on
   GitHub: click the file, then the download button).
2. Open Cursor, open the Agent chat, and paste this:

   > Put the attached SKILL.md at `~/.cursor/skills/study-companion/SKILL.md`
   > (on Windows: `%USERPROFILE%\.cursor\skills\study-companion\SKILL.md`),
   > creating the folders if they don't exist. Don't put it in `skills-cursor`.

   Attach the file, send. Cursor will create the folder and move it.
3. Restart Cursor.

Check it worked: type `/` in the Agent chat — `study-companion` should be in the
list. Now every project you open has it.

That single file contains everything: the teaching loop, the default posture, and
the format for the notes it keeps. Nothing else to install.

## If you use Cursor — the installer way

Only worth it if you're comfortable with a terminal, and note **the installer is a
shell script, so it does not run on Windows** unless you have WSL or Git Bash.

```bash
git clone https://github.com/chri4354/learning-skills.git ~/tools/learning-skills
```

```bash
~/tools/learning-skills/install.sh cursor --global
```

Same result as the one-file way, plus it sets up a starter profile for you.

### Optional extra — the always-on posture

Cursor only reaches for a skill when your request matches it. To make the default
posture apply to *everything* — try first, no pasteable answers, always end with a
question — paste
[`dist/cursor/user-rules.txt`](../dist/cursor/user-rules.txt) into Cursor Settings
→ **Rules** (search settings for "rules"), once.

Skip this and it still works; you'll just need to ask for help a bit more
explicitly.

### Optional extra — per coursework folder

If you'd rather keep it scoped to one folder, run the installer inside that folder
without `--global`. It writes `.cursor/skills/` and `.cursor/rules/` there only.

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
  coursework folder is a git repo, `.learning/` gets added to `.gitignore` so it
  can't be committed by accident.
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
