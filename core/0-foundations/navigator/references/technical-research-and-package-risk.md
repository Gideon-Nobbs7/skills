# Technical Research and Package Risk

Use this workflow for current tool/framework selection, ecosystem research, dependency adoption,
upgrade planning, and vulnerability monitoring. Research is a dated evidence artifact, not a claim
that one technology is universally best.

## 1. Frame the decision

Write the job to be done, users, current stack and exact versions, target platforms, scale, data and
trust boundaries, latency/availability needs, accessibility/localization, team skills, budget,
timeline, compliance, deployment, and exit constraints. Separate hard gates from preferences and
weight the remaining criteria before searching.

Define the baseline: current solution, platform primitive, standard library, or no new dependency.
A candidate must beat that baseline enough to pay for adoption and maintenance.

## 2. Build a current evidence set

Use sources in this order:

1. Official documentation, support/version policy, security page, release notes, changelog, roadmap,
   RFCs, and migration guides.
2. Package registry metadata and signed/provenance data; source repository releases, tags, commits,
   issues, maintainers, CI, and security policy.
3. Standards bodies, browser/platform compatibility data, vendor architecture references, and
   primary benchmarks with reproducible methodology.
4. Independent engineering reports, ecosystem surveys, and real production case studies.
5. Community discussion only to discover failure modes, then verify them against primary evidence.

Record source URL, publication/update date, version covered, and access date. Prefer evidence from
the last stable release cycle while retaining older sources that define unchanged architecture.
Distinguish stable, beta/preview, deprecated, EOL, experimental, and announced-but-unreleased.

## 3. Compare candidates

Use the predeclared gates and weighted criteria. Include only material dimensions:

- Required capabilities and platform/version compatibility.
- Correctness, performance, scalability, reliability, accessibility, and security evidence.
- API stability, semantic-versioning behavior, release cadence, LTS/EOL policy, migration quality.
- Maintainer diversity, responsiveness, contributor activity, issue/PR health, CI, tests, security
  policy, signed releases/provenance, and funding/governance.
- Dependency size and depth, native/transitive surface, bundle/runtime cost, operational burden.
- Documentation, debugging/observability, ecosystem integrations, hiring/learning cost.
- License, data/privacy terms, vendor lock-in, portability, total cost, and credible exit path.

Stars, download counts, social attention, and “used by” lists are weak adoption signals—not quality
proof. A quiet mature project can be healthier than a fast-moving one. Interpret activity against
the project's maturity and support promises.

For benchmarks, reproduce the relevant workload when the decision is consequential. Reject vendor
benchmarks that omit versions, data, hardware, configuration, warmup, variance, or source code.

## 4. Assess package stability before adoption

Inspect the exact package and version, not only the project brand:

- Registry owner/publisher, repository link, license, release date, dist integrity/signature or
  provenance, install scripts, binaries, typosquatting risk, and ownership changes.
- Stable-major history, release notes, breaking changes, yanked/deprecated versions, support matrix,
  EOL, open regressions, and time-to-fix for prior security releases.
- Direct and transitive dependency graph, duplicate versions, unmaintained leaves, native/build
  hooks, peer constraints, and compatibility with the current lockfile/runtime.
- Repository security policy, disclosure path, branch protection/review signals, CI/tests, release
  automation, maintainer concentration, and recent unexplained transfer or rewrite.

Prefer a smaller, boring, maintained dependency with a clear contract over a broad framework when
both solve the requirement. Vendor or copy a tiny stable implementation only when license,
security-update ownership, and maintenance are explicitly accepted.

## 5. Investigate vulnerabilities and exploitation

Start package-aware, then corroborate:

- Ecosystem/lockfile audit and repository alerts for the resolved dependency graph.
- [OSV](https://osv.dev/) for package-version or commit-aware open-source advisories.
- [GitHub Advisory Database](https://github.com/advisories) for GHSA/CVE, affected ranges, patched
  versions, CVSS, EPSS, and reviewed advisories.
- Vendor security advisories and release notes for authoritative mitigation and compatibility.
- [NVD](https://nvd.nist.gov/developers/vulnerabilities) for CVE enrichment and cross-reference.
- [CISA KEV](https://www.cisa.gov/known-exploited-vulnerabilities-catalog) for evidence of active
  exploitation; prioritize KEV exposure urgently.
- [OpenSSF Scorecard](https://securityscorecards.dev/) as one supply-chain signal, never a verdict.

For each finding verify: identifier, source confidence, affected package/product, installed and
vulnerable ranges, fixed version, dependency path, runtime/dev scope, whether vulnerable code or
configuration is reachable, privileges and data exposed, network/user interaction, known exploit or
KEV status, EPSS where available, mitigation, regression risk, and owner.

Prioritize by actual exposure and impact: actively exploited/reachable critical paths first, then
high-likelihood or high-impact reachable issues. CVSS is severity context, not project risk by
itself. Never dismiss solely because the dependency is transitive or the scanner says “dev”; verify
whether build, CI, generated artifacts, or developer credentials are exposed.

Do not run a forceful automatic fix blindly. Inspect the proposed lockfile and major-version changes,
review release notes, run the full affected test/security suite, and preserve rollback. If no fix
exists, remove/replace, disable the feature, isolate, patch/vendor with ownership, apply vendor
mitigation, or formally accept a time-bounded residual risk.

## 6. Follow trends without chasing hype

For a technology watch, compare two horizons:

- Recent: releases, advisories, maintainer changes, EOL/deprecations, compatibility breaks, major
  incidents, standards/RFC movement, and production reports since the last review.
- Structural: multi-year governance, adoption, migration paths, ecosystem depth, security response,
  and whether the project repeatedly keeps compatibility promises.

State what changed, why it matters to this project, confidence, and the next review trigger. A trend
becomes a recommendation only when it improves the weighted project criteria and passes a spike,
benchmark, or migration proof.

## 7. Produce a decision-ready report

Return:

1. Decision and constraints.
2. Current stack/version facts.
3. Shortlist comparison with evidence dates.
4. Package health and supply-chain findings.
5. Vulnerability/exploitation findings and remediation priority.
6. Recommendation and rejected alternatives.
7. Validation plan, migration/rollback, evidence gaps, and reassessment triggers.

Use `core-setup-stack-and-architecture-selection` for the final decision record,
`core-verify-testing-strategy` for proof, `core-setup-ci-skeleton` for continuous checks,
`core-operate-maintenance` for cadence, and `core-operate-incident-response` when active exposure or
compromise is suspected.
