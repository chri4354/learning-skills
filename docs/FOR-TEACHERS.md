# For teachers

## What this is, in one paragraph

A set of instruction files that change the *default behaviour* of the AI coding
assistants your students already use. Instead of producing a finished answer, the
assistant diagnoses what the student knows, has them attempt it, explains at the
right level of support, makes them explain it back, tests them, and points at what
to study next. Students can override it in one sentence. That is deliberate.

## What it is not

It is not an integrity control. It cannot detect, prevent, or report anything, and
it should never be presented to students as though it could. A student who wants a
copy-pasteable answer can delete one file, or open a browser tab. The claim is
narrower and, we think, more useful: **the path of least resistance becomes the one
that involves thinking.** Most students, most of the time, take the default.

Presenting it as surveillance destroys the only thing that makes it work — that
students install it voluntarily and leave it on.

## Adopting it in a course

**Minimum version.** Add `.claude/`, `.cursor/`, and `AGENTS.md` to the course
template repository that students clone. It works from the first commit, and most
students will never think about it again.

**Recommended version.** Do the above, plus:

1. **Add your course's concept map.** Edit `src/teaching-loop.md` to name the
   actual concepts and their prerequisite order in your syllabus, then run
   `./build.sh`. Generic prerequisite reasoning is the weakest part of the skill;
   twenty lines of your own curriculum makes it dramatically better.
2. **Tell students what the ledger is for.** If your integrity policy requires
   declaring AI use, say explicitly that `.learning/ledger.md` is an acceptable
   way to do it. This is what turns the skill from a restriction into something a
   student has a reason to keep switched on.
3. **Say out loud what the research says.** The 17% exam penalty from Bastani et
   al. is more persuasive to a 19-year-old than any amount of exhortation. See
   [EVIDENCE.md](EVIDENCE.md).

## A VS Code course folder

For a class on VS Code with GitHub Copilot (Copilot Free is enough),
`./build.sh` also produces `dist/vscode/`: a bundle that goes into the course
folder you hand out.

```bash
./build.sh
scripts/export-vscode-bundle.sh ~/path/to/course-folder
```

The bundle lands in the root of the course folder. Students always open that
folder in VS Code, and it is also their one git repository (the project sits in a
`project/` subfolder), so the tutor setup lives at the root only. Keep it out of
students' repositories with `.github/`, `.vscode/` and `AGENTS.md` in the course
folder's `.gitignore`. It contains:

- `.github/copilot-instructions.md` — the tutor rules for Copilot chat
- `.github/agents/tutor.agent.md` — a **Tutor** agent with the same rules, whose
  tools are limited to reading and searching, so it cannot edit files
- `.vscode/settings.json` — Copilot autocomplete off for Python and notebooks,
  and Copilot told not to load `AGENTS.md` as well
- `AGENTS.md` — the same rules for other assistants

There is no Gemini fallback: Gemini Code Assist no longer supports individual
accounts in the VS Code extension, so the bundle relies on Copilot Free.

### Why the VS Code bundle is short

Students run this on the free Copilot model. Small models cannot follow
the full teaching loop: given `src/teaching-loop.md` they keep the easy rules (a
closing confidence question) and drop the ones that teach (attempt first, no
finished code). So every VS Code file carries only `src/vscode/tutor.md`: eight
unconditional rules and one worked example, about 35 lines. No learner profile,
no fading ladder, no concept maps.

The escape hatch works the same way as in the full loop, to match course AI
policies that forbid AI writing submitted code: "just give me the answer" gets a
direct answer for a concept or a setup problem, but code is always a skeleton,
however the student asks. The full loop still ships to Claude Code,
Cursor and Codex. The export script also removes the `study-companion` skill that
earlier bundles put in `.github/skills/`.

Before term, run [VSCODE-TESTING.md](VSCODE-TESTING.md). CI
(`.github/workflows/check-generated.yml`) fails whenever `dist/` doesn't match a
fresh build, so the files for different tools can't drift apart.

## Customising

Everything canonical lives in `src/`. Edit there and run `./build.sh` to
regenerate all six adapter files; never edit `dist/` directly.

- `src/always-on.md` — the default posture, loaded into every context window.
  **Keep it short.** Every line here costs tokens on every single turn, and long
  instruction files get followed less reliably.
- `src/teaching-loop.md` — the full pedagogy. This can be long; it is loaded only
  when relevant.
- `src/skill-frontmatter.yaml` — the description that decides *when* Claude Code
  loads the skill. If the skill fires too rarely, this is the file to edit.

Useful course-specific edits:

- **A no-code rule** for an assessed assignment: add a line naming the file paths
  the assistant should never write for the student.
- **Assessment-aware framing:** if your exam is unaided and on paper, say so in
  `always-on.md`. It changes what the model emphasises.
- **Language and level:** the default is pitched at undergraduate. For younger
  students, lower the reading level in `always-on.md` explicitly.

## Evaluating it

If you want to know whether it works in your course, the one methodological point
that matters:

> **Measure learning unaided. Never measure assisted performance.**

Every study that measured assisted performance found large gains, including the
studies where students ended up learning *less*. Assisted performance is the
metric that tells you nothing. Useful designs:

- Pre/post concept inventory, both administered without AI access.
- A proportion of assessment done in conditions where the tool is unavailable,
  compared across cohorts before and after adoption.
- Ledger data as a process measure (voluntarily shared, aggregated) — override
  rate, questions attempted, calibration gap over time.

Expect small effects and high variance. Be suspicious of large ones.

## Known limitations

- **Instruction adherence drifts.** In long sessions models increasingly revert to
  answering directly. The skill is most reliable in the first part of a session.
- **The prerequisite map is generic** unless you supply your own.
- **The learner profile is per-machine and per-repo.** A student working across
  three devices has three profiles.
- **No effect on students who don't install it.** Voluntary adoption is the whole
  distribution model, so the students who most need it are the least likely to
  have it. Putting it in the course template repo is the answer.

## Contributing

If you adapt this for a course and it works — or doesn't — a PR adding your
concept map under `courses/` or a note in the evidence file is welcome. Negative
results particularly.
