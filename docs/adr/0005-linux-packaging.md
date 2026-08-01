# 0005: Source-first Arch packaging for V1; portable bundles are post-V1

- Status: Proposed
- Date: 2026-08-02

## Context

The V1 delivery plan originally gated release on an AppImage in addition to
AUR-friendly source packaging.

A Tauri application on Linux links WebKitGTK, which is the hardest possible
dependency to bundle portably: it pulls in a large GTK stack, requires matching
runtime data files and sandbox helpers, and is the standard cause of AppImages
that run on the build machine and fail elsewhere. Producing a trustworthy
AppImage is a packaging project in its own right, and it cannot be validated by
CI or by a coding agent — only on clean machines.

The V1 reference user runs CachyOS, an Arch derivative, where a source build and
a PKGBUILD are the native and expected installation path. For that user, an
AppImage adds no reach.

Flatpak is a further step away: filesystem traversal across arbitrary developer
roots and launching host tools such as a terminal or editor both require a
deliberate portal and helper design.

## Decision

V1 ships one supported installation path: a documented, reproducible source
build with AUR-friendly packaging instructions for Arch-family distributions.

AppImage and Flatpak are removed from the V1 release gate and tracked as
post-V1 work. Neither may be reintroduced as a gate without evidence from a
clean-machine spike.

The packaging choice must not influence domain or adapter design. If it ever
does, that constraint is a bug to be fixed in the adapter layer.

## Consequences

- The V1 release gate becomes something the project can actually demonstrate.
- The reference user is fully served on day one.
- Non-Arch Linux users build from source with documented dependencies until a
  portable bundle exists.
- Packaging risk is deferred rather than eliminated, and will need its own
  spike with clean-machine evidence.
- The release checklist shrinks to items that are verifiable.

## Alternatives considered

- Keep AppImage as a V1 gate: highest risk item in the plan, unverifiable in CI,
  and of no benefit to the reference user.
- Flatpak for V1: adds a portal and helper design problem to a release.
- Static binary via a non-WebKit toolkit: would remove the problem entirely, but
  reverses ADR 0001 for packaging reasons alone. Reconsider only if the desktop
  shell proves problematic for other reasons.
- Ship only `cargo install`: acceptable for the CLI, insufficient for a desktop
  application that needs a desktop entry and icon.
