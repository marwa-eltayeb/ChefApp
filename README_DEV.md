# Project Structure Guidelines

This project follows a **feature-first architecture**.  
Please follow these conventions when adding new code.

---

## 📂 Folder Structure

- `lib/app/`  
  Application-level configuration (routing, themes, dependency injection, etc.).

- `lib/core/`  
  Shared utils, constants, services, and widgets used across multiple features.

- `lib/features/`  
  Each feature has its own folder:
  ```
  lib/features/<feature_name>/
    ├── data/          # Data sources, models, repositories implementations
    ├── domain/        # Entities, use cases, repository interfaces
    ├── presentation/  # UI, widgets, screens, cubits/blocs
  ```

---

## 📝 Rules

1. **Do not place code directly in `lib/`.**
2. **Each feature must live under `lib/features/<feature_name>/`.**
3. **Shared code only goes into `lib/core/`.**
4. **Use `snake_case` for file and folder names.**
5. **Follow the linter rules defined in `analysis_options.yaml`.**
6. **Keep layers separated** (no direct imports from `presentation` → `data`, always go through `domain`).

---

## 🌐 Dependencies

- If you need a new dependency, **discuss it with the team** and open a Pull Request.  
- Do not add random packages directly to `develop` or `master`.  
- Always commit `pubspec.yaml` and `pubspec.lock` when changing dependencies.

---

## 🔄 Git Flow

- **master** → Production-ready code only.  
- **develop** → Main branch for integration.  
- **feature/<name>** → Work on new features here, then create a Pull Request into `develop`.  
