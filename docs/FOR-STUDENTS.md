# Setup — students

Five minutes, once. Pick the section for the tool you use. If you use both, do both.

---

## If you use Cursor

Cursor has two places rules can live, and you want both for different reasons.

### Step 1 — make it work everywhere (2 minutes, do this one)

Cursor's **User Rules** are global: they apply in every project you ever open, with
no per-folder setup.

1. Open Cursor Settings and find **Rules** (search the settings for "rules" — some
   versions label it *Rules & Memories*, older ones *Rules for AI*).
2. Open [`dist/cursor/user-rules.txt`](../dist/cursor/user-rules.txt) from this repo.
3. Copy the whole thing, paste it into User Rules, save.

That's it. Every folder you open in Cursor from now on gets the study-companion
posture. Nothing else to install, nothing to remember.

### Step 2 — the full version, in your coursework folder (optional, recommended)

User Rules only carry the short version. The full teaching loop — the fading
worked examples, the spaced review, the ledger — is too long for a settings box and
lives in project files instead.

Clone this repo somewhere that is **not** your coursework folder:

```bash
git clone https://github.com/chri4354/learning-skills.git ~/tools/learning-skills
```

Then, from inside your coursework folder:

```bash
~/tools/learning-skills/install.sh cursor
```

Repeat that one command for each coursework folder. Cursor project rules are
per-project — there is no way around that, which is exactly why Step 1 exists.

---

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

Do the Cursor Step 1 paste **and** the Claude `--global` install. Then optionally
run `install.sh all` inside each coursework folder. The two tools don't share
anything, so you need both.

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
