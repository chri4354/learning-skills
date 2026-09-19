# Evidence base

Every design decision in this repo traces to something below. Where the evidence
is thin or preliminary, it says so.

---

## The headline finding

**Guardrails prevent harm. They do not, by themselves, produce learning.**

Three studies converge on this, and it is the single most important thing to
understand before deploying an AI tutor:

- **Bastani et al. (2025, PNAS)** gave ~1,000 Turkish high-school maths students
  access to GPT-4 during practice. Unrestricted access improved practice
  performance by 48% — and then *reduced* unaided exam scores by 17% relative to
  students who never had access. A guarded "GPT Tutor" version improved practice
  performance by 127% and produced exam scores **statistically indistinguishable
  from the control group**. The guardrails removed the damage; they did not create
  a benefit.

- **Bassner et al. (2026)** ran a three-arm RCT (n = 275) in an introductory
  programming course at TUM, holding the model constant (GPT-4) and varying only
  the scaffolding: a guarded tutor (Iris), unrestricted ChatGPT, and no AI. Both
  AI arms scored substantially higher on the exercise. **Neither produced greater
  pre/post knowledge gains or better code comprehension.** Both reduced frustration
  and extraneous cognitive load; only the guarded tutor raised intrinsic motivation.

- **"Beyond Access" (2026, preprint)** found the same pattern in undergraduate
  statistics: guided LLM use improved assisted performance without transferring to
  independent assessment.

The one study showing large learning gains — **Kestin et al. (2025, Scientific
Reports)**, n = 194 in Harvard's introductory physics course — used a tutor built
around active pedagogy, not just restrictions: one step at a time, never the full
solution in a single message, students asked to attempt first, short replies,
explicit growth-mindset framing. Students learned roughly twice as much as a
comparison group in an in-person active-learning classroom, in less time.

**What this repo takes from it:** restriction is the floor, not the design.
The parts of the loop with reliable positive effect sizes — retrieval practice,
self-explanation, productive failure, spacing — are the parts that do the work.
A "Socratic tutor" that never tests the student is aiming at the neutral outcome.

---

## Design decisions and their sources

| Decision in this skill | Why | Source |
|---|---|---|
| Test at the end of every substantive explanation, with mixed formats | Retrieval practice beats restudying (g ≈ 0.51) and all other comparison activities (g ≈ 0.61); mixtures of MCQ + short answer produce the strongest effect | Adesope, Trevisan & Sundararajan (2017) |
| Ask "why does that work?" before testing | Prompted self-explanation, g ≈ 0.55 across 64 studies, for both conceptual and procedural knowledge | Bisra et al. (2018) |
| Student attempts before the explanation arrives — but the explanation *does* arrive | Problem-solving before instruction beats instruction-first for conceptual understanding and transfer (d ≈ 0.36; up to ≈ 0.58 at high design fidelity), without harming procedural knowledge | Sinha & Kapur (2021) |
| The fading ladder: worked example → completion → faded → hint → independent, keyed to estimated expertise | The assistance dilemma: withholding too much wastes time and frustrates; giving too much produces shallow learning. The optimum moves as expertise grows (expertise reversal) | Koedinger & Aleven (2007); Salden et al. (2010) |
| Never open with Socratic questioning for a true novice | Same as above — the expertise reversal effect predicts worked examples are *better* than problem-solving early on | Kalyuga et al.; Salden et al. (2010) |
| One step per message; feedback per step, not per final answer or per sub-step | Step-based tutoring d ≈ 0.76 (≈ human tutoring at d ≈ 0.79); answer-only ≈ 0.3; sub-step d ≈ 0.40 | VanLehn (2011) |
| Confidence rating requested *before* the answer is revealed | Struggling students finish AI-assisted tasks with an "illusion of competence" and systematically overestimate their ability; calibration feedback is the direct countermeasure | Prather et al. (2024); calibration literature |
| Force the student to do the monitoring, not the AI | Learners who offload to ChatGPT improved essay scores but showed no knowledge gain or transfer, and shifted their self-regulated learning processes — "metacognitive laziness" | Fan et al. (2025, BJET) |
| Prerequisites behind, 2–3 concepts ahead | Knowledge is structured by surmise relations: mastery of some items presupposes others. This is the basis of knowledge space theory and of adaptive systems such as ALEKS | Doignon & Falmagne (1985); Falmagne et al. |
| Spaced return check at the start of a session | Distributed practice produces durable retention across ages and settings; interleaving related concepts adds a further benefit (g ≈ 0.42) | Cepeda et al. (2006); Brunmair & Richter (2019) |
| A frictionless escape hatch for concepts and setup (never for code), and an "in a hurry" mode | ~70% of students ignore or resist pedagogical scaffolding; usage concentrates around deadlines (59% of interactions in a single exam week in one deployment) and exploratory dialogue collapses under time pressure. Scaffolding that cannot be escaped gets bypassed entirely | "Your Students Don't Use LLMs Like You Wish They Did" (2026, preprint) |
| Do not optimise for student satisfaction | Satisfaction ratings showed no correlation with pedagogically aligned behaviour; unrestricted tools scored better on engagement while producing worse learning | Same (2026, preprint) |
| Short answers; skeletons rather than finished code | Long, complete outputs are treated as artefacts to copy. Novices given LLM output struggle to understand code they did not write | Prather et al. (2024); "I Would Have Written My Code Differently" (2025) |
| No solution-hiding without a way out; no claims about detection | Guardrail tools that refuse outright get abandoned for the unrestricted chat window in the next tab | CodeHelp deployment experience; Liffiton et al. (2023) |
| An open, student-editable learner profile | Open learner models make the system's inference visible and are themselves a metacognitive prompt | Bull & Kay, open learner model literature |
| Socratic scaffolding as habit formation, not just session control | Students previously exposed to Socratic guidance later showed more understanding-oriented engagement when using LLMs *independently* | "Reflective Dialogue or Prompt Refinement?" (2026, preprint) |

---

## Bibliography

### Peer-reviewed

Adesope, O. O., Trevisan, D. A., & Sundararajan, N. (2017). Rethinking the use of
tests: A meta-analysis of practice testing. *Review of Educational Research*,
87(3), 659–701. https://journals.sagepub.com/doi/abs/10.3102/0034654316689306

Bassner, P., Lenk-Ostendorf, B., Beinstingel, R., Wasner, T., & Krusche, S. (2026).
Less stress, better scores, same learning: The dissociation of performance and
learning in AI-supported programming education. *Computers and Education:
Artificial Intelligence*, 10.
https://www.sciencedirect.com/science/article/pii/S2666920X25001778

Bastani, H., Bastani, O., Sungu, A., Ge, H., Kabakcı, Ö., & Mariman, R. (2025).
Generative AI without guardrails can harm learning: Evidence from high school
mathematics. *PNAS*, 122(26). https://www.pnas.org/doi/10.1073/pnas.2422633122

Bisra, K., Liu, Q., Nesbit, J. C., Salimi, F., & Winne, P. H. (2018). Inducing
self-explanation: A meta-analysis. *Educational Psychology Review*, 30, 703–725.
https://link.springer.com/article/10.1007/s10648-018-9434-x

Brunmair, M., & Richter, T. (2019). Similarity matters: A meta-analysis of
interleaved learning and its moderators. *Psychological Bulletin*, 145(11),
1029–1052.

Cepeda, N. J., Pashler, H., Vul, E., Wixted, J. T., & Rohrer, D. (2006).
Distributed practice in verbal recall tasks: A review and quantitative synthesis.
*Psychological Bulletin*, 132(3), 354–380.

Doignon, J.-P., & Falmagne, J.-C. (1985). Spaces for the assessment of knowledge.
*International Journal of Man-Machine Studies*, 23(2), 175–196.
See also https://www.aleks.com/about_aleks/knowledge_space_theory

Fan, Y., et al. (2025). Beware of metacognitive laziness: Effects of generative
artificial intelligence on learning motivation, processes, and performance.
*British Journal of Educational Technology*, 56(2).
https://bera-journals.onlinelibrary.wiley.com/doi/10.1111/bjet.13544

Kazemitabaar, M., et al. (2024). CodeAid: Evaluating a classroom deployment of an
LLM-based programming assistant that balances student and educator needs.
*CHI '24*. https://dl.acm.org/doi/10.1145/3613904.3642773

Kestin, G., Miller, K., Klales, A., Milbourne, T., & Ponti, G. (2025). AI tutoring
outperforms in-class active learning: An RCT introducing a novel research-based
design in an authentic educational setting. *Scientific Reports*, 15.
https://www.nature.com/articles/s41598-025-97652-6

Koedinger, K. R., & Aleven, V. (2007). Exploring the assistance dilemma in
experiments with cognitive tutors. *Educational Psychology Review*, 19, 239–264.

Liffiton, M., Sheese, B., Savelka, J., & Denny, P. (2023). CodeHelp: Using large
language models with guardrails for scalable support in programming classes.
*Koli Calling '23*. https://dl.acm.org/doi/10.1145/3631802.3631830

Prather, J., et al. (2024). The widening gap: The benefits and harms of generative
AI for novice programmers. *ICER '24*.
https://dl.acm.org/doi/10.1145/3632620.3671116

Salden, R. J. C. M., Aleven, V., Schwonke, R., & Renkl, A. (2010). The expertise
reversal effect and worked examples in tutored problem solving. *Instructional
Science*, 38, 289–307. https://link.springer.com/article/10.1007/s11251-009-9107-8

Sinha, T., & Kapur, M. (2021). When problem solving followed by instruction works:
Evidence for productive failure. *Review of Educational Research*, 91(5), 761–798.
https://journals.sagepub.com/doi/10.3102/00346543211019105

VanLehn, K. (2011). The relative effectiveness of human tutoring, intelligent
tutoring systems, and other tutoring systems. *Educational Psychologist*, 46(4),
197–221. https://www.tandfonline.com/doi/abs/10.1080/00461520.2011.611369

### Preprints — not peer reviewed, treat as indicative

Your students don't use LLMs like you wish they did (2026). arXiv:2604.23486.
https://arxiv.org/abs/2604.23486 — 12,650 messages across 500 student–AI
conversations in four courses. Source of the scaffolding-resistance and
crisis-mode figures.

Beyond access: Guided LLM scaffolding for independent learning in undergraduate
statistics (2026). arXiv:2606.01375. https://arxiv.org/abs/2606.01375

Reflective dialogue or prompt refinement? Effects of tutor scaffolding on students'
independent LLM use for programming (2026). arXiv:2607.03303.
https://arxiv.org/abs/2607.03303

### Retracted — do not cite

Wang, J., & Fan, W. (2025). The effect of ChatGPT on students' learning
performance, learning perception, and higher-order thinking. *Humanities and
Social Sciences Communications*, 12, 621. **Retracted April 2026.**
https://www.nature.com/articles/s41599-025-04787-y

This meta-analysis is widely cited for a large positive effect of ChatGPT on
learning performance (g ≈ 0.867). It has been retracted. Anyone building a case
for AI tutoring should be aware, because it appears in a great many slide decks.

---

## What we do not know

Be honest about this when presenting the skill.

1. **No study has yet shown that a prompt-level guardrail produces learning gains
   over a no-AI control.** The two RCTs that tested real guardrails found
   neutralised harm, not gains. This repo's bet is that adding the active
   ingredients (retrieval, self-explanation, spacing) closes that gap — but that
   bet is untested in this exact form.

2. **Long-run effects are unmeasured.** Every study here measures over days or
   weeks. Nobody knows what a semester of study-companion use does.

3. **Effects may be unevenly distributed.** Prather et al.'s "widening gap"
   suggests AI help accrues to students who already have the skills to use it,
   which is the opposite of what most educators want. The fading ladder is a
   deliberate attempt to counteract this, but whether it does is an open question.

4. **Compliance is not guaranteed.** Model adherence to a long instruction file
   degrades over a session, and students can trivially disable the file. This is a
   default, not a control.
