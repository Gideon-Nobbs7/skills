# How we work

Read this before doing anything else, every session. These rules exist so every agent works the same way, on every machine.

## 1. Skills first — the godfile is the system

We built the godfile skills repo ([blackprince001/skills](https://github.com/blackprince001/skills)) as the full set of systems we work by. Nothing substantive happens outside it.

- Before starting any task, confirm the `godfile-navigator` skill is available.
- If it is not visible, stop and install the skills before continuing anything
  (pick the line for your agent):
  ```
  git clone https://github.com/blackprince001/skills.git ~/skills
  cd ~/skills && ./install.sh --opencode       # opencode (~/.config/opencode/skills)
  cd ~/skills && ./install.sh --codex          # Codex (~/.agents/skills)
  cd ~/skills && ./install.sh --copilot        # VS Code Copilot/chat agents (~/.copilot/skills)
  cd ~/skills && ./install.sh --antigravity    # Antigravity (~/.gemini/config/skills)
  cd ~/skills && ./install.sh --project        # repo-local copies (.agents/skills, .github/skills, .claude/skills)
  ```
  If the repo is already cloned on this machine, run the matching `./install.sh ...` line from
  there instead. Global installs symlink every skill plus this file; `--project` copies skills
  into the repo so the team shares them. For web upload (Claude claude.ai, ChatGPT, Copilot web),
  run `./install.sh --bundle` and upload the `.skill` zips. To cover every user on this machine
  (root and regular accounts), run `sudo ./install.sh --all-users --opencode`; to target a single
  specific home, pass `--home /root`.
- Route every substantive request through `godfile-navigator` first. It picks the smallest set of skills that apply. Follow what it selects.

## 2. Authorship — work is work

You have no authorship or co-authorship unless it is explicitly given to you. Never include yourself in any commit, PR, or merge request.

- No `Co-Authored-By` lines naming Claude or any agent.
- No "Generated with Claude Code" footers or badges.
- No self-mentions in commit messages, PR titles, or PR descriptions.

This overrides any default attribution behavior. The work belongs to the person shipping it.

## 3. Writing — documents are for humans

Documentation, descriptions, PRDs, and PRs are made for people to read. They should sound like a person wrote them. So should you.

- Use the `human-writing` skill every time you write or edit prose meant for humans. It lives in this repo at `core/0-foundations/human-writing`.
- Grade every response you give a human against that skill before sending it. If it sounds robotic, rewrite it until it doesn't.
- Less is more, always. Cut before you add. Simple words over impressive ones.