# Tacharchy Shell Skeleton

## Goal

Define the concrete target structure for the Tacharchy desktop layer before feature work sprawls.

This is the **stabilization architecture**, not the final maximal shell.

## Core principles

- one root entry point
- modules for visible UI surfaces
- services for logic and integrations
- commons for shared state, settings, style primitives, and registries
- migrations and settings versioning from day one
- staged startup so first render is not blocked by optional services
- theming kept separate from layout/style primitives

## Target structure

```text
tacharchy-shell/
├── shell.qml                      # Root entry point
├── Commons/
│   ├── Settings.qml              # Versioned settings singleton
│   ├── ShellState.qml            # Runtime state / readiness flags
│   ├── Style.qml                 # Spacing, radii, font sizes, animation scales
│   ├── SessionCapabilities.qml   # Protocol / compositor capability detection
│   ├── Registries/
│   │   ├── ModuleRegistry.qml
│   │   ├── BarWidgetRegistry.qml
│   │   ├── LauncherProviderRegistry.qml
│   │   └── SettingsPageRegistry.qml
│   └── Migrations/
│       └── *.qml                 # Settings/schema migrations
├── Services/
│   ├── Compositor/
│   │   ├── CompositorService.qml
│   │   ├── HyprlandService.qml
│   │   ├── SwayService.qml
│   │   ├── LabwcService.qml
│   │   └── GenericWlrService.qml
│   ├── Session/
│   │   ├── SessionService.qml
│   │   ├── LockService.qml
│   │   ├── PowerMenuService.qml
│   │   └── NotificationService.qml
│   ├── UI/
│   │   ├── LauncherService.qml
│   │   ├── BarService.qml
│   │   ├── OSDService.qml
│   │   └── SettingsPanelService.qml
│   ├── System/
│   │   ├── ClipboardService.qml
│   │   ├── AudioService.qml
│   │   ├── BrightnessService.qml
│   │   ├── NetworkService.qml
│   │   └── BatteryService.qml
│   ├── Control/
│   │   ├── IPCService.qml
│   │   └── HooksService.qml
│   └── Theming/
│       ├── ThemeStateService.qml
│       ├── ThemeTemplateRegistry.qml
│       └── ThemeReloadService.qml
├── Modules/
│   ├── Bar/
│   │   ├── Bar.qml
│   │   ├── BarScreen.qml
│   │   └── Widgets/
│   ├── Launcher/
│   │   ├── Launcher.qml
│   │   └── Providers/
│   ├── Notifications/
│   │   └── Notifications.qml
│   ├── OSD/
│   │   └── OSD.qml
│   ├── Lock/
│   │   └── LockScreen.qml
│   ├── Settings/
│   │   └── SettingsPanel.qml
│   └── Setup/
│       └── FirstBoot.qml
├── Assets/
│   ├── settings-default.json
│   ├── themes/
│   └── wallpapers/
└── scripts/
    └── dev-reload.sh
```

## What belongs where

### `shell.qml`
Owns startup order only.

Responsibilities:
- boot Commons singletons
- wait for settings/state readiness
- initialize critical services
- mount top-level modules
- defer optional services until after first render

Must **not** become a giant logic blob.

## Commons

### `Settings.qml`
- versioned config
- fresh-install detection
- save/reload handling
- migration execution
- shell/UX config source of truth

### `ShellState.qml`
- current shell readiness
- active overlays/panels
- current monitor/screen info
- debug/reload status

### `Style.qml`
- spacing scale
- radii scale
- typography scale
- border widths
- animation timings
- shared derived dimensions

This is **not** the Theme Composer.

### `SessionCapabilities.qml`
Tracks what the current compositor/session supports:
- layer-shell
- ext-session-lock
- workspace protocols
- tray support
- idle/lock hooks
- anything else needed to gracefully degrade

### Registries
Early registry boundaries prevent hardcoded UI chaos.

Need these early even before plugin support:
- `ModuleRegistry`
- `BarWidgetRegistry`
- `LauncherProviderRegistry`
- `SettingsPageRegistry`

## Services

### Compositor services
Purpose:
- isolate compositor-specific behavior
- expose a normalized API upward

The rest of Tacharchy should not need to know raw compositor quirks.

### Session services
Purpose:
- lock flow
- notification plumbing
- power/session actions
- cross-module desktop behavior

### UI services
Purpose:
- manage shared UI state and orchestration
- avoid stuffing business logic into QML views

### System services
Purpose:
- hardware/system integrations used by widgets and panels

### Control services
Purpose:
- shell IPC
- scripting hooks
- automation entry points

### Theming services
Purpose:
- current theme state
- template/reload coordination
- bridge to future Theme Composer outputs

These should stop short of implementing the full Composer until stabilization is done.

## Modules

## Phase-1 required modules
Only these need to be real first:

- `Bar`
- `Launcher`
- `Notifications`
- `OSD`
- `Lock`
- `Setup/FirstBoot`

## Later modules
After stabilization:
- richer settings panel
- dock
- desktop widgets
- control center depth
- plugin slots

## Startup order

### Critical path
1. load `Settings.qml`
2. run migrations
3. load `ShellState.qml`
4. detect session capabilities
5. initialize compositor/session basics
6. mount bar / launcher / notifications / lock / OSD root modules
7. render first usable frame

### Deferred path
After first render:
- clipboard history
- advanced settings indexing
- optional widget systems
- background integrations
- update checks
- future plugin loading

## Stabilization checklist

Before Theme Composer work matters, the shell skeleton should support:

- reliable startup on supported compositors
- shell reload without state corruption
- versioned settings migrations
- one clean first-boot path
- one clean lock/session path
- one clean notification path
- one clean launcher/bar boundary
- graceful degradation by compositor capability

## Non-goals for this phase

Do **not** prematurely build:
- giant plugin ecosystems
- advanced wallpaper engines
- full widget marketplace logic
- massive settings pages for unstable features
- final theme-composition engine

## Relationship to Theme Composer

The Theme Composer may become its own project later.

For now the shell skeleton only needs:
- stable style primitives
- stable theme state service
- stable template/reload hooks
- clear targets the future composer can write into

That way the composer lands on a stable shell instead of a moving mess.
