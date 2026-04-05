# Phase <N>: <Phase Title>

**The Validation Task**:
> <The user will supply this. Paste it verbatim if it fits within 2 paragraphs. If it's longer, write a concise summary that preserves all technologies, protocols, constraints, and observable outcomes. This section must NEVER exceed 2 paragraphs. The summary should read as a single deliverable spec that someone could hand to an engineer.>

<Brief 1-2 sentence description of what this phase simulates or proves.>
**Goal**: State the core competency or mastery being demonstrated.

---

## Day 0: <Day Title>
**Focus**: <Comma-separated list of 3-5 technical topics>
**Load**: Level <1-5>

- **Tasks**:
    - [ ] Task description — specific, actionable, one deliverable per line.
    - [ ] Task description.
    - [ ] Task description.

---

## Day <N>: <Day Title>
**Focus**: <Comma-separated list of 3-5 technical topics>
**Load**: Level <1-5>

- **Objectives**:
    1. <High-level outcome 1 — what is true at the end that wasn't true at the start.>
    2. <High-level outcome 2.>
    3. <High-level outcome 3.>

- **Tasks**:

    **<Subsection Name> (e.g., "Server", "Config", "Infrastructure")**
    - [ ] Task description — specific, actionable, one deliverable per line.
        - Note: <Clarifying detail, gotcha, or rationale for a non-obvious choice.>
    - [ ] Task description.
    - [ ] Task description.

    **<Subsection Name>**
    - [ ] Task description.
    - [ ] Task description.

- **Acceptance Criteria**:
    - <Observable, testable outcome 1 — written so someone else can verify pass/fail.>
    - <Observable, testable outcome 2.>
    - <Observable, testable outcome 3.>

- **Resources**:
    - [<Resource Title>](<URL>) — <1-line description of what it covers.> Read the **<Section Name>** section for <what they'll learn>; skip <Section Name> unless <condition>.
    - [<Resource Title>](<URL>) — <1-line description.> Focus on **<Section Name>** — it covers <specific takeaway relevant to this day's tasks>.

---

<!--
Repeat the "Day <N>" block for each day in the phase.

==========================================================================
DAY ORDERING
==========================================================================
Days MUST follow this dependency order. Each layer builds on the one above.
Skip a layer only if the project genuinely doesn't need it.

1. Tooling & Environment
   - Package manager, linters, formatters, pre-commit hooks, project skeleton.
   - Everything depends on this. Always Day 0.

2. Config & Utilities
   - Settings (env loading), logging, shared helpers, error types.
   - Used by all subsequent code. Can be part of Day 0 if lightweight.

3. Contracts & Interfaces
   - Protobuf schemas, API specs, DB schemas, type definitions.
   - Define the shape of data BEFORE building around it.
   - No implementation code — just the agreements between components.

4. Core Implementation
   - Servers, clients, business logic, handlers.
   - The actual code that does the work. Split by subsystem if large
     (e.g., separate days for server vs client).

5. Integration & Infrastructure
   - Wiring components together, Dockerfiles, Compose, networking, volumes.
   - End-to-end flows, startup ordering, retry logic, graceful shutdown.

6. Performance & Validation
   - Rate control, benchmarks, soak tests, profiling, optimization.
   - Only optimize after the baseline works end-to-end.

7. DevOps & Delivery
   - CI/CD pipelines, container registries, deployment scripts, Makefiles.
   - Automate what you've already proven works manually.

8. Documentation & Polish (optional)
   - README, architecture diagrams, API docs, cleanup.
   - Only as a dedicated day if the project warrants it; otherwise
     weave into each day's tasks.

Testing: For smaller projects, acceptance criteria per day serve as the
test suite — no dedicated testing phase needed. For larger projects,
add a dedicated testing day between layers 5 and 6.

Parallelism: If two days have no dependency between them, note it
explicitly (e.g., "Can be done in parallel with Day N").

==========================================================================
GUIDELINES
==========================================================================

TASKS:
- One task = one deliverable. If a task has "and" in it, split it.
- Group tasks under subsystem headers (Server, Client, Infra, CI, etc.).
- Add "Note:" sub-bullets for non-obvious decisions, gotchas, or rationale.
- Order tasks by dependency — a task should never reference something
  defined below it.

OBJECTIVES:
- Objectives describe END STATE, not activity.
  Good: "Server binds to UDS and accepts connections."
  Bad:  "Work on server."
- Limit to 2-4 per day. If you have more, the day is too large — split it.

ACCEPTANCE CRITERIA:
- Must be verifiable by someone who didn't write the code.
- Prefer concrete commands or log output patterns over vague "works correctly".
- Example: "Running `docker compose up` shows 'Received Frame #1' in
  server logs within 5s."

LOAD LEVELS:
- Level 1: Config, tooling, boilerplate. < 2 hours.
- Level 2: Foundational setup with some decisions. 2-4 hours.
- Level 3: Implementation requiring domain knowledge. 4-6 hours.
- Level 4: Multi-component integration or non-trivial debugging. 6-8 hours.
- Level 5: Performance-critical, cross-cutting, or architecturally
  complex. 8+ hours.

DAY 0:
- Day 0 is always Tooling & Environment + Config/Utilities.
- Day 0 has ONLY Focus, Load, and Tasks — no Objectives, Acceptance
  Criteria, or Resources. It's pure setup.

RESOURCES:
- Lead with official docs, then follow with relevant blogs/tutorials.
- Don't just drop a URL — for each link, tell the reader which specific
  sections to read and what they'll learn from those sections. Guide them
  through the resource so they know exactly where to focus.
-->
