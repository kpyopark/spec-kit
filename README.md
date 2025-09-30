<div align="center">
    <img src="./media/logo_small.webp"/>
    <h1>🌱 Spec Kit</h1>
    <h3><em>Build high-quality software faster.</em></h3>
</div>

<p align="center">
    <strong>An effort to allow organizations to focus on product scenarios rather than writing undifferentiated code with the help of Spec-Driven Development.</strong>
</p>

[![Release](https://github.com/github/spec-kit/actions/workflows/release.yml/badge.svg)](https://github.com/github/spec-kit/actions/workflows/release.yml)

---

## Table of Contents

- [🤔 What is Spec-Driven Development?](#-what-is-spec-driven-development)
- [⚡ Get started](#-get-started)
- [📽️ Video Overview](#️-video-overview)
- [🔧 Specify CLI Reference](#-specify-cli-reference)
- [📚 Core philosophy](#-core-philosophy)
- [🌟 Development phases](#-development-phases)
- [🎯 Experimental goals](#-experimental-goals)
- [🔧 Prerequisites](#-prerequisites)
- [📖 Learn more](#-learn-more)
- [📋 Detailed process](#-detailed-process)
- [🔍 Troubleshooting](#-troubleshooting)
- [👥 Maintainers](#-maintainers)
- [💬 Support](#-support)
- [🙏 Acknowledgements](#-acknowledgements)
- [📄 License](#-license)

## 🤔 What is Spec-Driven Development?

Spec-Driven Development **flips the script** on traditional software development. For decades, code has been king — specifications were just scaffolding we built and discarded once the "real work" of coding began. Spec-Driven Development changes this: **specifications become executable**, directly generating working implementations rather than just guiding them.

## ⚡ Get started

### 1. Install Specify

Initialize your project depending on the coding agent you're using:

```bash
uvx --from git+https://github.com/kpyopark/spec-kit.git specify init <PROJECT_NAME>
```

Or, Install once, use everywhere.
```bash
uv tool install specify-cli --from git+https://github.com/kpyopark/spec-kit.git

specify init <PROJECT_NAME> --ai <claude, gemini...>

# if you want to use it on the target project folder, use --here option.

specify init --here --ai claude
```

### 2. Establish project principles

Use the **`/constitution`** command to create your project's governing principles and development guidelines that will guide all subsequent development.

```bash
/constitution Create principles focused on code quality, testing standards, user experience consistency, and performance requirements
```

### 3. Create the spec

Use the **`/specify`** command to describe what you want to build. Focus on the **what** and **why**, not the tech stack.

```bash
/specify Build an application that can help me organize my photos in separate photo albums. Albums are grouped by date and can be re-organized by dragging and dropping on the main page. Albums are never in other nested albums. Within each album, photos are previewed in a tile-like interface.
```

### 4. Create a technical implementation plan

Use the **`/plan`** command to provide your tech stack and architecture choices.

```bash
/plan The application uses Vite with minimal number of libraries. Use vanilla HTML, CSS, and JavaScript as much as possible. Images are not uploaded anywhere and metadata is stored in a local SQLite database.
```

### 5. Break down into tasks

Use **`/tasks`** to create an actionable task list from your implementation plan.

```bash
/tasks
```

### 6. Execute implementation

Use **`/implement`** to execute all tasks and build your feature according to the plan.

```bash
/implement
```

For detailed step-by-step instructions, see our [comprehensive guide](./spec-driven.md).

## 📽️ Video Overview

Want to see Spec Kit in action? Watch our [video overview](https://www.youtube.com/watch?v=a9eR1xsfvHg&pp=0gcJCckJAYcqIYzv)!

[![Spec Kit video header](/media/spec-kit-video-header.jpg)](https://www.youtube.com/watch?v=a9eR1xsfvHg&pp=0gcJCckJAYcqIYzv)

## 🔧 Specify CLI Reference

The `specify` command supports the following options:

### Commands

| Command     | Description                                                    |
|-------------|----------------------------------------------------------------|
| `init`      | Initialize a new Specify project from the latest template      |
| `check`     | Check for installed tools (`git`, `claude`, `gemini`, `code`/`code-insiders`, `opencode`, `cursor-agent`) |

### `specify init` Arguments & Options

| Argument/Option        | Type     | Description                                                                  |
|------------------------|----------|------------------------------------------------------------------------------|
| `<project-name>`       | Argument | Name for your new project directory (optional if using `--here`)            |
| `--ai`                 | Option   | AI assistant to use: `claude`, `gemini`, `copilot`, `opencode`, or `cursor`             |
| `--script`             | Option   | Script variant to use: `sh` (bash/zsh) or `ps` (PowerShell)                 |
| `--ignore-agent-tools` | Flag     | Skip checks for AI agent tools like Claude Code                             |
| `--no-git`             | Flag     | Skip git repository initialization                                          |
| `--here`               | Flag     | Initialize project in the current directory instead of creating a new one   |
| `--skip-tls`           | Flag     | Skip SSL/TLS verification (not recommended)                                 |
| `--debug`              | Flag     | Enable detailed debug output for troubleshooting                            |

### Examples

```bash
# Basic project initialization
specify init my-project

# Initialize with specific AI assistant
specify init my-project --ai claude

# Initialize with Cursor support
specify init my-project --ai cursor

# Initialize with PowerShell scripts (Windows/cross-platform)
specify init my-project --ai copilot --script ps

# Initialize in current directory
specify init --here --ai copilot

# Skip git initialization
specify init my-project --ai gemini --no-git

# Enable debug output for troubleshooting
specify init my-project --ai claude --debug

# Check system requirements
specify check
```

### Available Slash Commands

After running `specify init`, your AI coding agent will have access to these slash commands for structured development:

| Command         | Description                                                           | Enhanced Features |
|-----------------|-----------------------------------------------------------------------|-------------------|
| `/constitution` | Create or update project governing principles and development guidelines | **MIL-STD-498 Detection**: Automatically creates enterprise document structure when keywords detected |
| `/specify`      | Define what you want to build (requirements and user stories)        | **CSCI Integration**: Updates MIL-STD-498 documents if structure exists, with automatic functional area mapping |
| `/plan`         | Create technical implementation plans with your chosen tech stack     | **Adaptive Structure**: Detects web/mobile/CLI projects and creates appropriate directory layouts |
| `/tasks`        | Generate actionable task lists for implementation                     | **CSCI-Based Tasks**: Generates Frontend/Backend tasks per functional area with parallel execution markers |
| `/implement`    | Execute all tasks to build the feature according to the plan         | **Parallel Execution**: Handles CSCI-based parallel development and dependency management |

## 📚 Core philosophy

Spec-Driven Development is a structured process that emphasizes:

- **Intent-driven development** where specifications define the "_what_" before the "_how_"
- **Rich specification creation** using guardrails and organizational principles
- **Multi-step refinement** rather than one-shot code generation from prompts
- **Heavy reliance** on advanced AI model capabilities for specification interpretation

## 🏗️ Enhanced Architecture Features

### MIL-STD-498 Integration

Spec Kit now supports the **MIL-STD-498 software development standard** for enterprise-grade documentation and CSCI (Computer Software Configuration Item) based development:

**Key Benefits:**
- **Functional Separation**: Organize features by business function (authentication, hr, finance) rather than technical layers
- **Parallel Development**: Frontend and Backend teams can work simultaneously within each functional area
- **Document Standardization**: 6-document framework ensures comprehensive coverage
- **Enterprise Compliance**: Follows military-grade software development standards

**Document Framework:**
1. **OCD (Operational Concept Document)** - Business context and user scenarios
2. **SSDD (System/Subsystem Design Document)** - Architecture and technology decisions
3. **SRS-Frontend** - Frontend requirements per functional area
4. **SRS-Backend** - Backend requirements per functional area
5. **IDD-Shared** - Interface specifications between Frontend/Backend

**When to Use:**
- Enterprise projects requiring formal documentation
- Large teams needing clear separation of concerns
- Projects with compliance or audit requirements
- Complex systems with multiple functional domains

### Cross-Platform Script System

Spec Kit provides **dual script support** for maximum compatibility:

**Bash Scripts** (`scripts/bash/`):
- Linux, macOS, WSL2 environments
- Superior performance and native Unix integration
- Advanced shell features and error handling

**PowerShell Scripts** (`scripts/powershell/`):
- Windows native support
- Cross-platform PowerShell 7+ compatibility
- Enterprise Windows environment integration

**Automatic Detection**: Commands automatically select the appropriate script based on your environment

### Template-Driven Development

**Comprehensive Template System:**
- **Feature Templates**: Structured specification creation with built-in validation
- **Plan Templates**: Self-executing implementation planning with phase gates
- **Task Templates**: Dependency-aware task generation with parallel execution support
- **Constitution Templates**: Organizational governance and principle establishment

**Template Features:**
- **Placeholder System**: Automatic token replacement (`[PROJECT_NAME]`, `[FEATURE]`)
- **Validation Gates**: Built-in checks and balancing for quality assurance
- **Progress Tracking**: Real-time status updates throughout execution
- **Error Handling**: Comprehensive error detection and recovery mechanisms

### Advanced Workflow Features

**Intelligent Branch Management:**
- **Auto-numbering**: Feature branches follow `001-feature-name` pattern
- **Context Preservation**: Automatic branch-specific documentation organization
- **Git Integration**: Seamless version control with PR creation support

**Parallel Development Support:**
- **Task Markers**: `[P]` annotations for parallelizable tasks
- **Dependency Management**: Automatic sequential/parallel task identification
- **CSCI Coordination**: Cross-functional team synchronization
- **File Conflict Prevention**: Smart task scheduling to avoid conflicts

**Test-Driven Development Integration:**
- **TDD Enforcement**: Tests must be written and failing before implementation
- **Contract Testing**: API specification validation before development
- **Integration Testing**: End-to-end scenario validation
- **Quality Gates**: Automated quality checks at each phase

## 🎯 Workflow Optimization Guide

### Choosing Your Development Approach

**Standard Workflow** (Recommended for most projects):
```bash
/constitution → /specify → /plan → /tasks → /implement
```
- **Best for**: Small to medium projects, single team, rapid prototyping
- **Structure**: Traditional file organization with clear separation
- **Parallel**: Basic parallel task execution for independent components

**MIL-STD-498 Workflow** (Enterprise/Complex projects):
```bash
/constitution "Include MIL-STD-498 structure with CSCIs: authentication, hr, finance"
→ /specify "User management system"
→ /plan → /tasks → /implement
```
- **Best for**: Enterprise projects, large teams, compliance requirements
- **Structure**: CSCI-based functional organization
- **Parallel**: Advanced parallel development across functional areas

### Maximizing Development Efficiency

**1. Constitution Optimization:**
```bash
# Basic principles
/constitution Create principles focused on code quality and testing standards

# Enhanced enterprise setup
/constitution Create principles with MIL-STD-498 structure for authentication, hr, and finance CSCIs
```

**2. Feature Specification Best Practices:**
```bash
# Focus on WHAT and WHY, not HOW
/specify Build a user authentication system that supports SSO, 2FA, and role-based permissions.
Users should be able to login via email/password or OAuth providers. The system needs to handle
10,000+ concurrent users with sub-200ms response times.

# Avoid: Technical implementation details at this stage
```

**3. Plan Optimization:**
```bash
# Specify your exact tech stack and constraints
/plan Use Node.js with Express, PostgreSQL database, Redis for sessions.
Deploy to AWS with Docker containers. Support OAuth 2.0 with Google and Microsoft providers.
Target 99.9% uptime with automatic failover.
```

**4. Task Generation Strategy:**
```bash
# Let the system generate optimized task breakdown
/tasks

# Result: Automatically creates CSCI-based tasks with parallel execution markers
```

**5. Implementation Execution:**
```bash
# Full automated implementation
/implement

# Parallel execution will automatically coordinate:
# - Frontend authentication components [P]
# - Backend authentication services [P]
# - Database migrations and setup [P]
# - Integration tests [P]
```

## 🌟 Development phases

| Phase | Focus | Key Activities |
|-------|-------|----------------|
| **0-to-1 Development** ("Greenfield") | Generate from scratch | <ul><li>Start with high-level requirements</li><li>Generate specifications</li><li>Plan implementation steps</li><li>Build production-ready applications</li></ul> |
| **Creative Exploration** | Parallel implementations | <ul><li>Explore diverse solutions</li><li>Support multiple technology stacks & architectures</li><li>Experiment with UX patterns</li></ul> |
| **Iterative Enhancement** ("Brownfield") | Brownfield modernization | <ul><li>Add features iteratively</li><li>Modernize legacy systems</li><li>Adapt processes</li></ul> |

## 💡 Advanced Use Cases & Examples

### Enterprise CSCI Development

**Scenario**: Building a complete HR management system with multiple functional areas

```bash
# 1. Setup enterprise structure
/constitution Create enterprise-grade constitution with MIL-STD-498 structure.
Define CSCIs for: employee-management, payroll, benefits, performance-tracking

# 2. Specify core functionality
/specify Build an HR management system that handles employee onboarding, payroll processing,
benefits administration, and performance reviews. System needs to integrate with existing
LDAP directory and support 5,000+ employees across multiple departments.

# 3. Generate implementation plan
/plan Use .NET 8 with Blazor frontend, SQL Server database, Redis caching.
Integrate with Azure AD for authentication. Support real-time notifications
and document management with SharePoint integration.

# 4. Generate CSCI-based tasks
/tasks
# Result: Creates parallel task groups:
# - Employee Management Frontend/Backend tasks [P]
# - Payroll Frontend/Backend tasks [P]
# - Benefits Frontend/Backend tasks [P]
# - Performance Tracking Frontend/Backend tasks [P]
# - Cross-CSCI integration tasks (sequential)

# 5. Execute with parallel development
/implement
# Teams can work simultaneously on different CSCIs
```

### Rapid Prototyping Workflow

**Scenario**: Quick validation of a startup idea

```bash
# 1. Minimal constitution for speed
/constitution Focus on rapid iteration, minimal viable features, and user feedback integration

# 2. MVP specification
/specify Create a social media scheduler that allows users to plan posts across
Twitter, LinkedIn, and Instagram. Include basic analytics and team collaboration.

# 3. Simple tech stack
/plan Use React with Vite, Node.js/Express backend, SQLite database.
Deploy to Vercel with simple authentication.

# 4. Generate MVP tasks
/tasks
# Result: Creates minimal viable task set with parallel execution

# 5. Rapid implementation
/implement
# Focuses on core features only, optimized for speed
```

### Legacy System Modernization

**Scenario**: Modernizing an existing monolithic application

```bash
# 1. Modernization constitution
/constitution Establish principles for incremental modernization, backward compatibility,
and gradual migration strategies

# 2. Modernization specification
/specify Modernize legacy Java EE customer management system to microservices architecture.
Maintain existing API compatibility while adding modern UI and cloud deployment.

# 3. Migration-focused planning
/plan Use Spring Boot microservices, React frontend, PostgreSQL database.
Implement strangler fig pattern for gradual migration. Deploy to Kubernetes.

# 4. Migration task breakdown
/tasks
# Result: Creates phased migration tasks with risk management

# 5. Incremental implementation
/implement
# Executes migration in safe, incremental steps
```

## 🔧 Internal Architecture Deep Dive

### Script System Architecture

**Directory Structure:**
```
scripts/
├── bash/                    # Unix/Linux optimized scripts
│   ├── common.sh           # Shared functions and variables
│   ├── create-new-feature.sh    # Feature branch creation
│   ├── check-task-prerequisites.sh    # Task validation
│   ├── setup-plan.sh       # Plan execution environment
│   └── get-feature-paths.sh    # Path resolution utilities
└── powershell/             # Windows/Cross-platform scripts
    ├── common.ps1          # Shared PowerShell functions
    ├── create-new-feature.ps1    # Feature branch creation
    ├── check-task-prerequisites.ps1    # Task validation
    ├── setup-plan.ps1      # Plan execution environment
    └── get-feature-paths.ps1    # Path resolution utilities
```

**Key Script Functions:**

1. **Feature Path Resolution**: Automatic detection of current feature context
2. **MIL-STD-498 Detection**: Identifies enterprise document structure availability
3. **Prerequisite Validation**: Ensures required documents exist before proceeding
4. **Cross-Platform Compatibility**: Unified API across Bash and PowerShell
5. **JSON Output**: Structured data exchange between scripts and AI agents

### Template Engine Features

**Smart Placeholder System:**
```
[PROJECT_NAME]           → Replaced with actual project name
[FEATURE]               → Current feature being developed
[CSCI_NAME]             → Functional area identifier
[DATE]                  → Current date in ISO format
[PRINCIPLE_1_NAME]      → Dynamic principle enumeration
```

**Validation System:**
- **Constitution Checks**: Automatic governance compliance validation
- **Dependency Gates**: Ensures proper execution order
- **Error Recovery**: Built-in rollback and retry mechanisms
- **Progress Tracking**: Real-time status updates

**Template Inheritance:**
- **Base Templates**: Core structure and common elements
- **Specialized Templates**: MIL-STD-498 vs standard workflows
- **Custom Extensions**: Project-specific customization points

### CSCI Management System

**Functional Area Organization:**
```
docs/mil-std-498/csci/
├── authentication/
│   ├── srs-frontend.md     # UI/UX requirements
│   ├── srs-backend.md      # API/business logic requirements
│   └── idd-shared.md       # Interface specifications
├── hr/
│   ├── srs-frontend.md
│   ├── srs-backend.md
│   └── idd-shared.md
└── finance/
    ├── srs-frontend.md
    ├── srs-backend.md
    └── idd-shared.md
```

**CSCI Coordination Features:**
- **Parallel Development**: Independent frontend/backend work within CSCIs
- **Cross-CSCI Integration**: Managed dependencies between functional areas
- **Interface Standardization**: Consistent API contracts across CSCIs
- **Team Isolation**: Clear boundaries for team responsibilities

## 🎯 Experimental goals

Our research and experimentation focus on:

### Technology independence

- Create applications using diverse technology stacks
- Validate the hypothesis that Spec-Driven Development is a process not tied to specific technologies, programming languages, or frameworks

### Enterprise constraints

- Demonstrate mission-critical application development
- Incorporate organizational constraints (cloud providers, tech stacks, engineering practices)
- Support enterprise design systems and compliance requirements

### User-centric development

- Build applications for different user cohorts and preferences
- Support various development approaches (from vibe-coding to AI-native development)

### Creative & iterative processes

- Validate the concept of parallel implementation exploration
- Provide robust iterative feature development workflows
- Extend processes to handle upgrades and modernization tasks

## 🔧 Prerequisites

- **Linux/macOS** (or WSL2 on Windows)
- AI coding agent: [Claude Code](https://www.anthropic.com/claude-code), [GitHub Copilot](https://code.visualstudio.com/), [Gemini CLI](https://github.com/google-gemini/gemini-cli), [Cursor](https://cursor.sh/), [Qwen CLI](https://github.com/QwenLM/qwen-code) or [opencode](https://opencode.ai/)
- [uv](https://docs.astral.sh/uv/) for package management
- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

## 📖 Learn more

- **[Complete Spec-Driven Development Methodology](./spec-driven.md)** - Deep dive into the full process
- **[Detailed Walkthrough](#-detailed-process)** - Step-by-step implementation guide

---

## 📋 Detailed process

<details>
<summary>Click to expand the detailed step-by-step walkthrough</summary>

You can use the Specify CLI to bootstrap your project, which will bring in the required artifacts in your environment. Run:

```bash
specify init <project_name>
```

Or initialize in the current directory:

```bash
specify init --here
```

![Specify CLI bootstrapping a new project in the terminal](./media/specify_cli.gif)

You will be prompted to select the AI agent you are using. You can also proactively specify it directly in the terminal:

```bash
specify init <project_name> --ai claude
specify init <project_name> --ai gemini
specify init <project_name> --ai copilot
specify init <project_name> --ai qwen
specify init <project_name> --ai opencode
# Or in current directory:
specify init --here --ai claude
```

The CLI will check if you have Claude Code, Gemini CLI, Qwen CLI or opencode installed. If you do not, or you prefer to get the templates without checking for the right tools, use `--ignore-agent-tools` with your command:

```bash
specify init <project_name> --ai claude --ignore-agent-tools
```

### **STEP 1:** Establish project principles

Go to the project folder and run your AI agent. In our example, we're using `claude`.

![Bootstrapping Claude Code environment](./media/bootstrap-claude-code.gif)

You will know that things are configured correctly if you see the `/constitution`, `/specify`, `/plan`, `/tasks`, and `/implement` commands available.

The first step should be establishing your project's governing principles using the `/constitution` command. This helps ensure consistent decision-making throughout all subsequent development phases:

```text
/constitution Create principles focused on code quality, testing standards, user experience consistency, and performance requirements. Include governance for how these principles should guide technical decisions and implementation choices.
```

This step creates or updates the `/memory/constitution.md` file with your project's foundational guidelines that the AI agent will reference during specification, planning, and implementation phases.

### **STEP 2:** Create project specifications

With your project principles established, you can now create the functional specifications. Use the `/specify` command and then provide the concrete requirements for the project you want to develop.

>[!IMPORTANT]
>Be as explicit as possible about _what_ you are trying to build and _why_. **Do not focus on the tech stack at this point**.

An example prompt:

```text
Develop Taskify, a team productivity platform. It should allow users to create projects, add team members,
assign tasks, comment and move tasks between boards in Kanban style. In this initial phase for this feature,
let's call it "Create Taskify," let's have multiple users but the users will be declared ahead of time, predefined.
I want five users in two different categories, one product manager and four engineers. Let's create three
different sample projects. Let's have the standard Kanban columns for the status of each task, such as "To Do,"
"In Progress," "In Review," and "Done." There will be no login for this application as this is just the very
first testing thing to ensure that our basic features are set up. For each task in the UI for a task card,
you should be able to change the current status of the task between the different columns in the Kanban work board.
You should be able to leave an unlimited number of comments for a particular card. You should be able to, from that task
card, assign one of the valid users. When you first launch Taskify, it's going to give you a list of the five users to pick
from. There will be no password required. When you click on a user, you go into the main view, which displays the list of
projects. When you click on a project, you open the Kanban board for that project. You're going to see the columns.
You'll be able to drag and drop cards back and forth between different columns. You will see any cards that are
assigned to you, the currently logged in user, in a different color from all the other ones, so you can quickly
see yours. You can edit any comments that you make, but you can't edit comments that other people made. You can
delete any comments that you made, but you can't delete comments anybody else made.
```

After this prompt is entered, you should see Claude Code kick off the planning and spec drafting process. Claude Code will also trigger some of the built-in scripts to set up the repository.

Once this step is completed, you should have a new branch created (e.g., `001-create-taskify`), as well as a new specification in the `specs/001-create-taskify` directory.

The produced specification should contain a set of user stories and functional requirements, as defined in the template.

At this stage, your project folder contents should resemble the following:

```text
├── memory
│	 ├── constitution.md
│	 └── constitution_update_checklist.md
├── scripts
│	 ├── check-task-prerequisites.sh
│	 ├── common.sh
│	 ├── create-new-feature.sh
│	 ├── get-feature-paths.sh
│	 ├── setup-plan.sh
│	 └── update-claude-md.sh
├── specs
│	 └── 001-create-taskify
│	     └── spec.md
└── templates
    ├── plan-template.md
    ├── spec-template.md
    └── tasks-template.md
```

### **STEP 3:** Functional specification clarification

With the baseline specification created, you can go ahead and clarify any of the requirements that were not captured properly within the first shot attempt. For example, you could use a prompt like this within the same Claude Code session:

```text
For each sample project or project that you create there should be a variable number of tasks between 5 and 15
tasks for each one randomly distributed into different states of completion. Make sure that there's at least
one task in each stage of completion.
```

You should also ask Claude Code to validate the **Review & Acceptance Checklist**, checking off the things that are validated/pass the requirements, and leave the ones that are not unchecked. The following prompt can be used:

```text
Read the review and acceptance checklist, and check off each item in the checklist if the feature spec meets the criteria. Leave it empty if it does not.
```

It's important to use the interaction with Claude Code as an opportunity to clarify and ask questions around the specification - **do not treat its first attempt as final**.

### **STEP 4:** Generate a plan

You can now be specific about the tech stack and other technical requirements. You can use the `/plan` command that is built into the project template with a prompt like this:

```text
We are going to generate this using .NET Aspire, using Postgres as the database. The frontend should use
Blazor server with drag-and-drop task boards, real-time updates. There should be a REST API created with a projects API,
tasks API, and a notifications API.
```

The output of this step will include a number of implementation detail documents, with your directory tree resembling this:

```text
.
├── CLAUDE.md
├── memory
│	 ├── constitution.md
│	 └── constitution_update_checklist.md
├── scripts
│	 ├── check-task-prerequisites.sh
│	 ├── common.sh
│	 ├── create-new-feature.sh
│	 ├── get-feature-paths.sh
│	 ├── setup-plan.sh
│	 └── update-claude-md.sh
├── specs
│	 └── 001-create-taskify
│	     ├── contracts
│	     │	 ├── api-spec.json
│	     │	 └── signalr-spec.md
│	     ├── data-model.md
│	     ├── plan.md
│	     ├── quickstart.md
│	     ├── research.md
│	     └── spec.md
└── templates
    ├── CLAUDE-template.md
    ├── plan-template.md
    ├── spec-template.md
    └── tasks-template.md
```

Check the `research.md` document to ensure that the right tech stack is used, based on your instructions. You can ask Claude Code to refine it if any of the components stand out, or even have it check the locally-installed version of the platform/framework you want to use (e.g., .NET).

Additionally, you might want to ask Claude Code to research details about the chosen tech stack if it's something that is rapidly changing (e.g., .NET Aspire, JS frameworks), with a prompt like this:

```text
I want you to go through the implementation plan and implementation details, looking for areas that could
benefit from additional research as .NET Aspire is a rapidly changing library. For those areas that you identify that
require further research, I want you to update the research document with additional details about the specific
versions that we are going to be using in this Taskify application and spawn parallel research tasks to clarify
any details using research from the web.
```

During this process, you might find that Claude Code gets stuck researching the wrong thing - you can help nudge it in the right direction with a prompt like this:

```text
I think we need to break this down into a series of steps. First, identify a list of tasks
that you would need to do during implementation that you're not sure of or would benefit
from further research. Write down a list of those tasks. And then for each one of these tasks,
I want you to spin up a separate research task so that the net results is we are researching
all of those very specific tasks in parallel. What I saw you doing was it looks like you were
researching .NET Aspire in general and I don't think that's gonna do much for us in this case.
That's way too untargeted research. The research needs to help you solve a specific targeted question.
```

>[!NOTE]
>Claude Code might be over-eager and add components that you did not ask for. Ask it to clarify the rationale and the source of the change.

### **STEP 5:** Have Claude Code validate the plan

With the plan in place, you should have Claude Code run through it to make sure that there are no missing pieces. You can use a prompt like this:

```text
Now I want you to go and audit the implementation plan and the implementation detail files.
Read through it with an eye on determining whether or not there is a sequence of tasks that you need
to be doing that are obvious from reading this. Because I don't know if there's enough here. For example,
when I look at the core implementation, it would be useful to reference the appropriate places in the implementation
details where it can find the information as it walks through each step in the core implementation or in the refinement.
```

This helps refine the implementation plan and helps you avoid potential blind spots that Claude Code missed in its planning cycle. Once the initial refinement pass is complete, ask Claude Code to go through the checklist once more before you can get to the implementation.

You can also ask Claude Code (if you have the [GitHub CLI](https://docs.github.com/en/github-cli/github-cli) installed) to go ahead and create a pull request from your current branch to `main` with a detailed description, to make sure that the effort is properly tracked.

>[!NOTE]
>Before you have the agent implement it, it's also worth prompting Claude Code to cross-check the details to see if there are any over-engineered pieces (remember - it can be over-eager). If over-engineered components or decisions exist, you can ask Claude Code to resolve them. Ensure that Claude Code follows the [constitution](base/memory/constitution.md) as the foundational piece that it must adhere to when establishing the plan.

### STEP 6: Implementation

Once ready, use the `/implement` command to execute your implementation plan:

```text
/implement
```

The `/implement` command will:
- Validate that all prerequisites are in place (constitution, spec, plan, and tasks)
- Parse the task breakdown from `tasks.md`
- Execute tasks in the correct order, respecting dependencies and parallel execution markers
- Follow the TDD approach defined in your task plan
- Provide progress updates and handle errors appropriately

>[!IMPORTANT]
>The AI agent will execute local CLI commands (such as `dotnet`, `npm`, etc.) - make sure you have the required tools installed on your machine.

Once the implementation is complete, test the application and resolve any runtime errors that may not be visible in CLI logs (e.g., browser console errors). You can copy and paste such errors back to your AI agent for resolution.

</details>

---

## 🔍 Troubleshooting

### Git Credential Manager on Linux

If you're having issues with Git authentication on Linux, you can install Git Credential Manager:

```bash
#!/usr/bin/env bash
set -e
echo "Downloading Git Credential Manager v2.6.1..."
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
echo "Installing Git Credential Manager..."
sudo dpkg -i gcm-linux_amd64.2.6.1.deb
echo "Configuring Git to use GCM..."
git config --global credential.helper manager
echo "Cleaning up..."
rm gcm-linux_amd64.2.6.1.deb
```

## 👥 Maintainers

- Den Delimarsky ([@localden](https://github.com/localden))
- John Lam ([@jflam](https://github.com/jflam))

## 💬 Support

For support, please open a [GitHub issue](https://github.com/github/spec-kit/issues/new). We welcome bug reports, feature requests, and questions about using Spec-Driven Development.

## 🙏 Acknowledgements

This project is heavily influenced by and based on the work and research of [John Lam](https://github.com/jflam).

## 📄 License

This project is licensed under the terms of the MIT open source license. Please refer to the [LICENSE](./LICENSE) file for the full terms.
