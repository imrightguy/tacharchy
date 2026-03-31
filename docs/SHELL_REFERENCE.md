# Shell Reference Notes

## Why this exists

Tacharchy needs a stable desktop layer before it needs a perfect shell. This note captures reusable patterns from external shell projects — especially Noctalia — without making Tacharchy dependent on them.

## Noctalia patterns worth copying

### 1. Single shell root, modular feature loading
Noctalia uses one `shell.qml` entry point and composes the shell from modules:

- background
- bar / screen windows
- dock
- launcher
- settings panel
- notifications
- OSD
- lock screen
- desktop widgets

**Tacharchy takeaway:** keep a single root entry point and load desktop features as modules, not as one giant UI blob.

---

### 2. Services separated from modules
Noctalia splits visible UI from services:

- `Modules/*` = windows, panels, widgets, overlays
- `Services/*` = compositor bindings, theming, hardware, power, networking, IPC, clipboard, media, settings support
- `Commons/*` = shared state, settings, style primitives

**Tacharchy takeaway:**
- keep UI and service logic separate
- compositor adapters belong in services
- theming logic belongs in services/tooling, not inside every widget

---

### 3. Staged initialization
Noctalia initializes only critical services first, then defers the rest to unblock first render.

**Tacharchy takeaway:**
- initialize only what is needed for first frame
- defer optional/slow integrations
- treat startup performance as a product feature

---

### 4. Versioned settings + migrations
Noctalia has a large `Settings.qml` singleton, versioned settings, migration hooks, and first-install detection.

**Tacharchy takeaway:**
- version settings from day one
- use migrations for schema evolution
- distinguish fresh install from upgrade
- keep setup-wizard triggers tied to actual state, not guesses

---

### 5. Style primitives before theme details
Noctalia has a central `Style.qml` with:

- radii
- font sizes
- spacing scale
- borders
- opacity levels
- animation speeds
- derived component sizing

**Tacharchy takeaway:**
- define style primitives before implementing fancy themes
- build spacing/radius/animation scales early
- keep the future Theme Composer separate from layout/style primitives

---

### 6. Explicit scope boundaries
Noctalia is clear that it is a shell, not a full DE, and that some things belong to plugins or external apps.

**Tacharchy takeaway:**
- define what the desktop layer owns
- define what remains compositor territory
- define what stays external app/system territory
- prevent scope creep before it turns into product sludge

---

### 7. Registries for extensibility
Noctalia uses registries for:

- bar widgets
- launcher providers
- control center widgets
- desktop widgets
- plugins
- theme templates

**Tacharchy takeaway:**
- prefer registries over hardcoded giant switch statements
- make shell surfaces extensible by category
- plugin support can come later, but registry boundaries should exist early

## Noctalia patterns to avoid copying blindly

### 1. Huge feature surface too early
Noctalia is broad and polished, but Tacharchy is not there yet.

**Avoid:** trying to ship widgets, plugins, wallpaper ecosystems, dock logic, and advanced panel editing before the base shell/session is stable.

### 2. Custom fork debt
Noctalia depends on a custom Quickshell fork.

**Avoid:** inheriting upstream fork debt unless Tacharchy is ready to maintain it for real.

### 3. Complex settings surface before stability
Noctalia's settings model is powerful, but large.

**Avoid:** building an enormous settings schema before the core desktop layer is stable enough to justify it.

## Tacharchy implementation order

### Phase A — stabilize the base
- clean install flow
- compositor/session startup
- desktop layer root
- bar / launcher / notifications / lock flow basics
- settings storage + migrations
- basic style primitives

### Phase B — stabilize shell boundaries
- compositor adapters
- service boundaries
- core module registry model
- installer ↔ desktop-layer handoff
- shell reload / diagnostics story

### Phase C — unify theming
- semantic token model
- Theme Composer design
- GTK / Qt / TUI outputs
- app-specific renderers

### Phase D — expand surface area
- richer widgets
- control center depth
- plugin system
- advanced customization

## Current recommendation

Tacharchy should borrow **architecture patterns**, not codebase identity:

- modular shell root
- services vs modules split
- staged init
- versioned settings + migrations
- registry-based extensibility
- explicit scope boundaries

But implementation priority stays:

1. stabilize core features
2. stabilize desktop/session architecture
3. then build the Theme Composer
4. then widen the shell surface
