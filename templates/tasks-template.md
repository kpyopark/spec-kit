# Tasks: [FEATURE NAME]

**Input**: Design documents from `/specs/[###-feature-name]/` and MIL-STD-498 structure (if available)
**Prerequisites**: plan.md (required), MIL-STD-498 documents (optional), research.md, data-model.md, contracts/

## Execution Flow (main)
```
1. Check for MIL-STD-498 structure:
   → If docs/mil-std-498/ exists: Use enhanced CSCI-based workflow
   → If not: Use standard workflow
2. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tech stack, libraries, structure
3. For MIL-STD-498 workflow:
   → Load constitution.md: Extract defined CSCIs
   → Load MIL-STD-498 documents: Extract CSCI-specific requirements
   → Identify target CSCIs for this feature
   → Generate CSCI-based tasks with Frontend/Backend separation
4. For standard workflow:
   → Load optional design documents (data-model.md, contracts/, research.md)
   → Generate traditional task categories
5. Generate tasks by category:
   → Setup: project init, dependencies, linting
   → Tests: contract tests, integration tests (CSCI-aware if applicable)
   → Core: models, services, CLI commands (CSCI-separated)
   → Integration: DB, middleware, logging
   → Polish: unit tests, performance, docs
6. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → CSCI separation = mark [P] for parallel
   → Tests before implementation (TDD)
7. Number tasks sequentially (T001, T002...)
8. Generate dependency graph with CSCI dependencies
9. Create parallel execution examples with CSCI coordination
10. Validate task completeness:
    → All CSCIs have Frontend/Backend tasks?
    → All contracts have tests?
    → All entities have models?
    → All endpoints implemented?
11. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths in descriptions

## Path Conventions
- **Single project**: `src/`, `tests/` at repository root
- **Web app**: `backend/src/`, `frontend/src/`
- **Mobile**: `api/src/`, `ios/src/` or `android/src/`
- Paths shown below assume single project - adjust based on plan.md structure

## Phase 3.1: Setup
- [ ] T001 Create project structure per implementation plan
- [ ] T002 Initialize [language] project with [framework] dependencies
- [ ] T003 [P] Configure linting and formatting tools
- [ ] T004 [P] Setup CSCI directory structure (if MIL-STD-498 enabled)

## Phase 3.2: Tests First (TDD) ⚠️ MUST COMPLETE BEFORE 3.3
**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**

### CSCI-Based Tests (if MIL-STD-498 enabled)
- [ ] T005 [P] Contract test [CSCI_NAME] Frontend API in tests/csci/[CSCI_NAME]/test_frontend_api.py
- [ ] T006 [P] Contract test [CSCI_NAME] Backend API in tests/csci/[CSCI_NAME]/test_backend_api.py
- [ ] T007 [P] Interface test [CSCI_NAME] IDD endpoints in tests/csci/[CSCI_NAME]/test_idd_interfaces.py
- [ ] T008 [P] Integration test [CSCI_NAME] end-to-end flow in tests/integration/test_[CSCI_NAME]_e2e.py

### Standard Tests (if MIL-STD-498 disabled)
- [ ] T005 [P] Contract test POST /api/users in tests/contract/test_users_post.py
- [ ] T006 [P] Contract test GET /api/users/{id} in tests/contract/test_users_get.py
- [ ] T007 [P] Integration test user registration in tests/integration/test_registration.py
- [ ] T008 [P] Integration test auth flow in tests/integration/test_auth.py

## Phase 3.3: Core Implementation (ONLY after tests are failing)

### CSCI-Based Implementation (if MIL-STD-498 enabled)
#### [CSCI_NAME] Frontend Tasks
- [ ] T009 [P] [CSCI_NAME] Frontend components per SRS-Frontend requirements in frontend/src/components/[CSCI_NAME]/
- [ ] T010 [P] [CSCI_NAME] Frontend state management in frontend/src/store/[CSCI_NAME]/
- [ ] T011 [P] [CSCI_NAME] Frontend API client in frontend/src/api/[CSCI_NAME]/

#### [CSCI_NAME] Backend Tasks
- [ ] T012 [P] [CSCI_NAME] models per SRS-Backend requirements in backend/src/models/[CSCI_NAME]/
- [ ] T013 [P] [CSCI_NAME] services per SRS-Backend requirements in backend/src/services/[CSCI_NAME]/
- [ ] T014 [P] [CSCI_NAME] controllers per IDD-Shared spec in backend/src/controllers/[CSCI_NAME]/

#### Interface Implementation
- [ ] T015 [CSCI_NAME] API endpoints per IDD-Shared specification
- [ ] T016 [CSCI_NAME] data validation per IDD-Shared contracts
- [ ] T017 [CSCI_NAME] error handling per IDD-Shared error responses

### Standard Implementation (if MIL-STD-498 disabled)
- [ ] T009 [P] User model in src/models/user.py
- [ ] T010 [P] UserService CRUD in src/services/user_service.py
- [ ] T011 [P] CLI --create-user in src/cli/user_commands.py
- [ ] T012 POST /api/users endpoint
- [ ] T013 GET /api/users/{id} endpoint
- [ ] T014 Input validation
- [ ] T015 Error handling and logging

## Phase 3.4: CSCI Integration
### Cross-CSCI Integration (if multiple CSCIs involved)
- [ ] T018 [P] Inter-CSCI communication interfaces
- [ ] T019 [P] Shared data models and DTOs
- [ ] T020 CSCI orchestration and coordination

### Standard Integration
- [ ] T021 Connect services to database
- [ ] T022 Auth middleware integration
- [ ] T023 Request/response logging
- [ ] T024 CORS and security headers

## Phase 3.5: Polish
### CSCI-Based Polish (if MIL-STD-498 enabled)
- [ ] T025 [P] Unit tests for [CSCI_NAME] Frontend components in tests/unit/frontend/[CSCI_NAME]/
- [ ] T026 [P] Unit tests for [CSCI_NAME] Backend services in tests/unit/backend/[CSCI_NAME]/
- [ ] T027 [P] Update [CSCI_NAME] documentation per constitution requirements
- [ ] T028 [P] [CSCI_NAME] performance optimization (<200ms API responses)

### Standard Polish
- [ ] T025 [P] Unit tests for validation in tests/unit/test_validation.py
- [ ] T026 Performance tests (<200ms)
- [ ] T027 [P] Update docs/api.md
- [ ] T028 Remove duplication
- [ ] T029 Run manual-testing.md

## Dependencies

### CSCI-Based Dependencies (if MIL-STD-498 enabled)
- Tests (T005-T008) before any implementation
- Frontend tasks (T009-T011) can run parallel with Backend tasks (T012-T014)
- Interface implementation (T015-T017) requires both Frontend and Backend completion
- CSCI integration (T018-T020) requires all CSCI implementations
- Polish (T025-T028) requires all implementation completion

### Standard Dependencies (if MIL-STD-498 disabled)
- Tests (T005-T008) before implementation (T009-T015)
- Models (T009) before services (T010)
- Services before endpoints (T012-T013)
- Implementation before polish (T025-T029)

## Parallel Examples

### CSCI-Based Parallel Execution
```
# Phase 1: CSCI Tests (all parallel)
Task: "Contract test [CSCI_NAME] Frontend API in tests/csci/[CSCI_NAME]/test_frontend_api.py"
Task: "Contract test [CSCI_NAME] Backend API in tests/csci/[CSCI_NAME]/test_backend_api.py"
Task: "Interface test [CSCI_NAME] IDD endpoints in tests/csci/[CSCI_NAME]/test_idd_interfaces.py"

# Phase 2: CSCI Implementation (Frontend/Backend parallel)
Task: "[CSCI_NAME] Frontend components per SRS-Frontend in frontend/src/components/[CSCI_NAME]/"
Task: "[CSCI_NAME] Backend models per SRS-Backend in backend/src/models/[CSCI_NAME]/"
Task: "[CSCI_NAME] Backend services per SRS-Backend in backend/src/services/[CSCI_NAME]/"

# Phase 3: Multi-CSCI coordination (if multiple CSCIs)
Task: "Inter-CSCI communication interfaces"
Task: "Shared data models and DTOs"
```

### Standard Parallel Execution
```
# Launch T005-T008 together:
Task: "Contract test POST /api/users in tests/contract/test_users_post.py"
Task: "Contract test GET /api/users/{id} in tests/contract/test_users_get.py"
Task: "Integration test registration in tests/integration/test_registration.py"
Task: "Integration test auth in tests/integration/test_auth.py"
```

## Notes
- [P] tasks = different files, no dependencies
- Verify tests fail before implementing
- Commit after each task
- Avoid: vague tasks, same file conflicts

## Task Generation Rules
*Applied during main() execution*

### CSCI-Based Rules (if MIL-STD-498 enabled)
1. **From Constitution & MIL-STD-498 Documents**:
   - Each CSCI → separate Frontend/Backend task groups [P]
   - SRS-Frontend requirements → Frontend component tasks [P]
   - SRS-Backend requirements → Backend service tasks [P]
   - IDD-Shared specifications → Interface implementation tasks

2. **From CSCI Requirements**:
   - Each SRS requirement → specific implementation task
   - Each IDD interface → contract test + implementation task
   - Cross-CSCI dependencies → integration tasks

3. **CSCI Task Categorization**:
   - **Authentication CSCI**: Login, logout, token management, user verification
   - **User Management CSCI**: Profile, preferences, user CRUD operations
   - **Finance CSCI**: Payments, billing, transaction processing
   - **HR CSCI**: Employee management, payroll, time tracking
   - **Custom CSCI**: Domain-specific functional areas

4. **CSCI Ordering**:
   - Setup → CSCI Tests → CSCI Implementation → CSCI Integration → Polish
   - Frontend/Backend within same CSCI can be parallel
   - Different CSCIs can be parallel

### Standard Rules (if MIL-STD-498 disabled)
1. **From Contracts**:
   - Each contract file → contract test task [P]
   - Each endpoint → implementation task

2. **From Data Model**:
   - Each entity → model creation task [P]
   - Relationships → service layer tasks

3. **From User Stories**:
   - Each story → integration test [P]
   - Quickstart scenarios → validation tasks

4. **Ordering**:
   - Setup → Tests → Models → Services → Endpoints → Polish
   - Dependencies block parallel execution

## Validation Checklist
*GATE: Checked by main() before returning*

### CSCI-Based Validation (if MIL-STD-498 enabled)
- [ ] All CSCIs have Frontend and Backend tasks
- [ ] All SRS-Frontend requirements covered by Frontend tasks
- [ ] All SRS-Backend requirements covered by Backend tasks
- [ ] All IDD-Shared interfaces have corresponding tests and implementations
- [ ] CSCI separation enables parallel execution
- [ ] Cross-CSCI dependencies properly identified
- [ ] Each task references specific MIL-STD-498 requirement source

### Standard Validation (if MIL-STD-498 disabled)
- [ ] All contracts have corresponding tests
- [ ] All entities have model tasks
- [ ] All tests come before implementation
- [ ] Parallel tasks truly independent
- [ ] Each task specifies exact file path
- [ ] No task modifies same file as another [P] task

### Universal Validation
- [ ] Task IDs sequential and unique
- [ ] Dependencies clearly defined
- [ ] Parallel execution examples provided
- [ ] File paths absolute and specific
- [ ] TDD workflow enforced (tests before implementation)