# 0001: Rust core with Tauri and Svelte desktop interface

- Status: Proposed
- Date: 2026-08-02

## Context

gradar needs safe process control, concurrent filesystem/Git observation, a
responsive modern desktop interface, a companion CLI and practical Linux
packaging. It should remain approachable to contributors and efficient on a
workstation with many repositories.

## Decision

Use a Rust workspace for the domain and operating-system-facing core, Tauri 2
for the desktop shell, and Svelte with TypeScript for the interface. The CLI
uses the same Rust application and domain crates.

The phase-zero spike must prove Tauri operation on CachyOS/KDE/Wayland and test
that host processes can be launched reliably before this ADR is accepted.

## Consequences

- Core behaviour is shared between desktop and CLI.
- Rust provides explicit process, path and concurrency handling.
- The UI can be developed with common accessible web tooling.
- WebKitGTK/Tauri packaging becomes a Linux dependency and must be documented.
- Contributors cross a Rust/TypeScript boundary; contracts must remain small.

## Alternatives considered

- Qt/QML: strongest native KDE fit, but adds a more specialised contribution
  surface and Rust/Qt integration cost.
- Electron: mature and portable, but heavier than justified for this utility.
- Native GTK: capable on Linux but less aligned with portability and the desired
  frontend contribution model.
- Gleam/BEAM: preferred elsewhere in the portfolio, but not the best fit for a
  small desktop utility dominated by filesystem, process and packaging work.
