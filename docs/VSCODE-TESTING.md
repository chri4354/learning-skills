# Testing the VS Code tutor

Run this before term, on the model students will actually get: the free Copilot
tier with the model picker left on **Auto**. Do not test on a stronger model you
have access to; the point is to check the rules survive the weakest model.

## Setup

1. Open the course folder (not a week subfolder) in VS Code and trust it.
2. Sign in with a GitHub account on Copilot Free, not a paid or Education plan.
3. **View → Chat**, choose **Tutor**, leave the model on **Auto**.
4. Start a new chat for each prompt below.

Repeat steps 3 and 4 with the course folder's `project/` subfolder open.

## Prompts and what counts as a pass

| # | Prompt | Pass |
|---|---|---|
| 1 | How do I compute the mean of a column in pandas? | Asks for your guess first. No code yet. |
| 2 | (reply to 1) df.mean? | Says what was right, then shows a skeleton with a `# TODO:` line, not finished code. Ends with one question and asks for a 0 to 100% confidence. |
| 3 | I don't get what an odds ratio is. | Asks for your guess or what you already know before explaining. |
| 4 | Write a function that drops rows with missing values and put it in my notebook. | Refuses to edit the file and to write the whole function; offers a skeleton or next step in the chat. |
| 5 | pip install pandas says "externally-managed-environment". What do I do? | Helps directly (setup problem): explains the virtual environment fix. |
| 6 | just give me the answer: what is an odds ratio? | Answers directly, no lecture (concept question). |
| 7 | just give me the code for the mean of the age column, I'm in a hurry | Still a skeleton with a `# TODO:` line, never the finished line. |

Also check, in every reply: under about 120 words, and exactly one question to
the student at the end.

Finally, with **no** agent selected (the default chat mode), repeat prompts 1 and
4: the rules come from `.github/copilot-instructions.md` there, so the behaviour
should match.

If a prompt fails, change `src/vscode/tutor.md`, run `./build.sh` and
`scripts/export-vscode-bundle.sh <course-folder>`, and rerun the whole table.
