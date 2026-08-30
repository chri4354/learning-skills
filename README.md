# Study Companion

**A skill that turns Claude Code, Cursor, and Codex into a tutor that makes you
think, instead of an answer machine you paste from.**

Install it once and the default changes. Ask it to explain something and it works
out what you already know, makes you attempt it, explains at the level you're
actually at, makes you explain it back, tests you, and tells you what to study
next. Ask it for the answer anyway and it gives you the answer — no lecture. It's
a default, not a lock.

---

## Why

The research on students using AI is not ambiguous, and it is not what most people
assume.

- Students given unrestricted GPT-4 for maths practice improved their practice
  scores by **48%** — and then scored **17% *worse*** on the unaided exam than
  students who never had access at all ([Bastani et al., PNAS 2025](https://www.pnas.org/doi/10.1073/pnas.2422633122)).
- A three-arm RCT in an intro programming course (n = 275) found both AI groups
  scored higher on the exercise and **neither learned more** — no gain in pre/post
  knowledge or code comprehension ([Bassner et al., 2026](https://www.sciencedirect.com/science/article/pii/S2666920X25001778)).
- Struggling novice programmers finish AI-assisted tasks with an **illusion of
  competence**, believing they understood work they did not do ([Prather et al., ICER 2024](https://dl.acm.org/doi/10.1145/3632620.3671116)).

But a well-designed AI tutor beat an in-person active-learning classroom, with
students learning roughly **twice as much in less time** ([Kestin et al., Scientific Reports 2025](https://www.nature.com/articles/s41598-025-97652-6)).

The difference is not the model. It is what the model is told to do.

One uncomfortable detail this project takes seriously: in the studies above,
guardrails **removed the harm without producing a gain**. Restriction is the floor.
The things that actually make people learn — retrieval practice, self-explanation,
attempting before being told, spaced return — have to be built in on purpose. They
are, here. See [docs/EVIDENCE.md](docs/EVIDENCE.md) for the full mapping from each
design decision to its source.

---

## Install

Clone it **somewhere other than your coursework folder** — it's a tool, not part
of your work:

```bash
git clone https://github.com/chri4354/learning-skills.git ~/tools/learning-skills
```

Then, from inside the project you're studying in:

```bash
~/tools/learning-skills/install.sh claude
```

Replace `claude` with `cursor`, `codex`, or `all`. Add `--global` to install it for
every project instead of just this one — **Claude Code and Codex only**.

**Cursor works differently and needs one extra step.** Cursor project rules are
per-project by design, so the installer cannot make them apply everywhere. To get
the posture in every folder you open, paste
[`dist/cursor/user-rules.txt`](dist/cursor/user-rules.txt) into Cursor Settings →
Rules (User Rules), once. Then run the installer per coursework folder if you also
want the full loop and the ledger. Students: see
[docs/FOR-STUDENTS.md](docs/FOR-STUDENTS.md) for the click-by-click version.

It works the same whether your coursework folder is a git repo or just a folder —
the installer only copies files, it never runs git. If the folder *is* a git repo,
it adds `.learning/` to your `.gitignore`, so the record of what you found hard
never gets committed or pushed anywhere.

To remove it: delete the files it wrote, or the block marked
`<!-- study-companion:start -->`.

| Tool | Always-on part | Deep part |
|---|---|---|
| Claude Code | `CLAUDE.md` | `.claude/skills/study-companion/SKILL.md` |
| Cursor (per project) | `.cursor/rules/study-companion.mdc` (`alwaysApply: true`) | `.cursor/rules/study-companion-loop.mdc` |
| Cursor (everywhere) | paste `dist/cursor/user-rules.txt` into Settings → Rules | not available globally |
| Codex | `AGENTS.md` | `.study-companion/teaching-loop.md` |

Everything is plain markdown. Read it before you trust it.

---

## What it does

**1. Breaks concepts down properly.** One-sentence version, then the mechanism,
then a worked instance with real numbers, then where it stops working.

**2. Names the prerequisites.** Most "I don't understand logistic regression" is
really "I never solidified linear models." It checks the thing underneath first and
says so.

**3. Points at what's next.** Two or three concepts this one unlocks, in the order
worth taking them.

**4. Explains instead of pasting.** For code it prefers a skeleton with the key
lines blank and named over finished code. Answers stay short — long answers get
read as text to copy, not text to think with.

**5. Tests you.** This is the part that does the work. Two or three questions,
formats mixed, distractors built from the misconception it actually saw you make.
It asks how confident you are *before* it shows the answer, and tells you when the
gap was large. Learning to tell recognition from knowledge is most of the skill.

**6. Adapts, and fades.** A true novice gets a fully worked example, not Socratic
questioning — interrogating someone who has nothing to retrieve teaches nothing.
As you improve it gives less: worked example → last step blank → only the hard step
→ hints → nothing but a question back.

**7. Comes back to things.** It keeps a plain-markdown profile of what you've
worked on, and opens a later session with one 30-second question on something from
two days ago. Spaced retrieval is the highest-return thing nobody does for themselves.

**8. Keeps a ledger.** `.learning/ledger.md` records what you studied, what you got
wrong, and where you asked for the answer outright. If your course requires you to
declare how you used AI, this is a much better answer than "I used ChatGPT."

### What a session looks like

```
you   > explain logistic regression

skill > Before I do — what does a linear model predict, and what range
        can that prediction take?

you   > a number, any number

skill > Right. Now: you want to predict a probability. What's the problem?

you   > oh. probabilities only go 0 to 1

skill > That's the whole motivation. [explains the link function, one
        worked example with numbers]

        Why does squashing the output solve it rather than just clipping
        at 0 and 1?

you   > ...clipping would lose the information about how extreme it was?

skill > Yes, and it breaks the gradient. Two questions:

        1. A coefficient is 0.7. What does that mean in log-odds, and
           what in odds? (confidence 0–100 first)
        2. When would you not use this?

        Before this: linear models, odds vs probability.
        After this: odds ratios → multinomial → regularisation.
```

---

## What it is not

It is **not** an academic-integrity control. It cannot detect anything, it doesn't
report anything anywhere, and you can bypass it by typing "just give me the
answer." That's intentional: scaffolding that can't be escaped gets deleted
entirely, and then you have no defaults at all. One study of real student–AI
conversations found ~70% of students actively resist pedagogical scaffolding when
it's imposed on them.

There's also a **deadline mode**. Say "deadline mode" and it gives you the answer
straight, plus one line on what the exam version would look like, and it puts a
retrieval question in your profile for after you've submitted. Students under time
pressure abandon exploratory learning entirely — pretending otherwise just gets the
whole thing turned off the night before a deadline.

Nothing leaves your machine. There is no telemetry, no account, no network calls.
The profile and ledger are markdown files you own and can edit or delete.

---

## Repo layout

```
src/                       canonical content — edit here
  always-on.md             default posture, loaded every turn (keep it short)
  teaching-loop.md         the full pedagogy, loaded when relevant
  skill-frontmatter.yaml   controls when Claude Code loads the skill
build.sh                   regenerates dist/ from src/
dist/                      generated per-tool adapters — don't edit
install.sh                 copies adapters into place
templates/profile.md       learner profile template
docs/EVIDENCE.md           every design decision traced to a source
docs/FOR-STUDENTS.md       setup instructions to hand to a cohort
docs/FOR-TEACHERS.md       adopting and customising it for a course
```

Teachers: [docs/FOR-TEACHERS.md](docs/FOR-TEACHERS.md) covers adding your own
course concept map, aligning with your integrity policy, and — importantly — how
to evaluate whether it works (measure learning *unaided*; assisted performance is
the metric that misled everyone).

---

## Bibliography

The evidence this is built on. Annotated versions, with what each one contributed,
are in [docs/EVIDENCE.md](docs/EVIDENCE.md).

**On what AI does to learning**

- Bastani, H., Bastani, O., Sungu, A., Ge, H., Kabakcı, Ö., & Mariman, R. (2025).
  Generative AI without guardrails can harm learning: Evidence from high school
  mathematics. *PNAS*, 122(26). https://www.pnas.org/doi/10.1073/pnas.2422633122
- Kestin, G., Miller, K., Klales, A., Milbourne, T., & Ponti, G. (2025). AI tutoring
  outperforms in-class active learning: An RCT introducing a novel research-based
  design in an authentic educational setting. *Scientific Reports*, 15.
  https://www.nature.com/articles/s41598-025-97652-6
- Bassner, P., Lenk-Ostendorf, B., Beinstingel, R., Wasner, T., & Krusche, S. (2026).
  Less stress, better scores, same learning: The dissociation of performance and
  learning in AI-supported programming education. *Computers and Education: AI*, 10.
  https://www.sciencedirect.com/science/article/pii/S2666920X25001778
- Fan, Y., et al. (2025). Beware of metacognitive laziness: Effects of generative
  artificial intelligence on learning motivation, processes, and performance. *BJET*,
  56(2). https://bera-journals.onlinelibrary.wiley.com/doi/10.1111/bjet.13544
- Prather, J., et al. (2024). The widening gap: The benefits and harms of generative
  AI for novice programmers. *ICER '24*.
  https://dl.acm.org/doi/10.1145/3632620.3671116

**On what makes tutoring work**

- VanLehn, K. (2011). The relative effectiveness of human tutoring, intelligent
  tutoring systems, and other tutoring systems. *Educational Psychologist*, 46(4).
  https://www.tandfonline.com/doi/abs/10.1080/00461520.2011.611369
- Koedinger, K. R., & Aleven, V. (2007). Exploring the assistance dilemma in
  experiments with cognitive tutors. *Educational Psychology Review*, 19.
- Salden, R. J. C. M., Aleven, V., Schwonke, R., & Renkl, A. (2010). The expertise
  reversal effect and worked examples in tutored problem solving. *Instructional
  Science*, 38. https://link.springer.com/article/10.1007/s11251-009-9107-8
- Doignon, J.-P., & Falmagne, J.-C. (1985). Spaces for the assessment of knowledge.
  *IJMMS*, 23(2). (Knowledge space theory — the prerequisite maps.)

**On the learning techniques the loop is built from**

- Adesope, O. O., Trevisan, D. A., & Sundararajan, N. (2017). Rethinking the use of
  tests: A meta-analysis of practice testing. *Review of Educational Research*, 87(3).
  https://journals.sagepub.com/doi/abs/10.3102/0034654316689306
- Bisra, K., Liu, Q., Nesbit, J. C., Salimi, F., & Winne, P. H. (2018). Inducing
  self-explanation: A meta-analysis. *Educational Psychology Review*, 30.
  https://link.springer.com/article/10.1007/s10648-018-9434-x
- Sinha, T., & Kapur, M. (2021). When problem solving followed by instruction works:
  Evidence for productive failure. *Review of Educational Research*, 91(5).
  https://journals.sagepub.com/doi/10.3102/00346543211019105
- Cepeda, N. J., Pashler, H., Vul, E., Wixted, J. T., & Rohrer, D. (2006).
  Distributed practice in verbal recall tasks. *Psychological Bulletin*, 132(3).
- Brunmair, M., & Richter, T. (2019). Similarity matters: A meta-analysis of
  interleaved learning and its moderators. *Psychological Bulletin*, 145(11).

**On building tools like this**

- Liffiton, M., Sheese, B., Savelka, J., & Denny, P. (2023). CodeHelp: Using large
  language models with guardrails for scalable support in programming classes.
  *Koli Calling '23*. https://dl.acm.org/doi/10.1145/3631802.3631830
- Kazemitabaar, M., et al. (2024). CodeAid: Evaluating a classroom deployment of an
  LLM-based programming assistant. *CHI '24*.
  https://dl.acm.org/doi/10.1145/3613904.3642773

**Preprints — indicative, not peer reviewed**

- Your students don't use LLMs like you wish they did (2026). arXiv:2604.23486
- Beyond access: Guided LLM scaffolding for independent learning in undergraduate
  statistics (2026). arXiv:2606.01375
- Reflective dialogue or prompt refinement? (2026). arXiv:2607.03303

**One retraction worth knowing about.** Wang & Fan (2025), the widely-cited
meta-analysis reporting a large positive effect of ChatGPT on learning performance
(g ≈ 0.867), was **retracted in April 2026**. It still circulates. Don't build a
case on it.

---

## Honest limitations

- No study has yet shown that a prompt-level guardrail produces learning gains over
  a no-AI control. The bet here is that adding retrieval, self-explanation and
  spacing closes that gap. That bet is untested in this exact form.
- Instruction adherence drifts over long sessions. Expect the tutoring posture to
  weaken as a conversation gets long.
- The prerequisite map is generic unless a teacher supplies one for their course.
- Effects may be uneven: the "widening gap" finding suggests AI help accrues to
  students who already have the skills to use it. The fading ladder is a deliberate
  attempt to counteract that, and it may not work.

Contributions welcome, negative results especially.

---

## License

MIT — see [LICENSE](LICENSE). Use it, fork it, adapt it for your course.
