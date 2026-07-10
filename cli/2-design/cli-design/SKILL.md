---
name: cli-design-cli-design
description: Use when designing or changing a command-line interface, including commands, arguments, output, prompts, errors, exit status, help, and automation behavior; extends core UX and contract rules for terminal interfaces.
status: draft
---

# CLI Design

Apply `core-design-ux-and-flows`, `core-build-apis-and-contracts`, and the accessibility baseline.
The command line is both a human interface and a programmable contract; preserve both.

## Design the command grammar

- Use a verb or verb-noun subcommand for actions; use positional arguments only for required,
  obvious operands and named flags for optional or ambiguous input.
- Keep names predictable across commands. Reserve short flags for frequent, unambiguous options;
  every short flag has a long form.
- Make repeated execution safe where practical. Require explicit confirmation or a force flag for
  destructive actions and show the exact scope before execution.
- Read precedence as command flag, environment/config value, then documented default. Expose a way
  to identify the resolved configuration without printing secrets.

## Separate human and machine output

Write primary results to stdout and diagnostics/progress to stderr. Provide a documented stable
machine format such as `--json` when automation is a supported consumer; never mix decoration into
it. Treat field names and exit statuses as public contracts under core compatibility rules.

Use color only when supported and never as the sole carrier of meaning. Respect `NO_COLOR` and TTY
detection. Avoid animated progress in non-interactive output; provide quiet and verbose modes when
the task warrants them.

## Make automation first-class

- Never prompt when stdin is not interactive. Accept all required values through flags, stdin,
  environment, or config, and fail with an actionable message when one is absent.
- Make cancellation respond promptly, clean up partial work, and return a failure status.
- Use `0` for success and stable non-zero statuses for meaningful caller decisions. Document any
  statuses beyond a general failure.
- Keep stdout deterministic enough to pipe. Add `--` support when operands may begin with a dash.

## Write help and errors

The root help states the purpose and available commands. Command help includes usage, arguments,
defaults, side effects, examples, environment/config inputs, and exit behavior. Errors state what
failed, why when safe, and the next corrective action; redact tokens, credentials, and sensitive
paths. Suggest likely corrections for unknown commands or flags.

## Completion gate

Exercise help, success, invalid input, missing configuration, destructive confirmation,
non-interactive execution, piped output, JSON output, cancellation, no-color mode, and each stable
exit status. The observed behavior must match the documented contract.
