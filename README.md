# Gemini CLI Workspaces Selector (GWS)

🚀 A powerful PowerShell module to manage and switch between different project workspaces while launching Gemini CLI seamlessly.

## ✨ Features
- **Dynamic Workspace Selection**: Quickly choose a workspace from a numbered list and start your AI-assisted session.
- **Portability**: Uses `$PSScriptRoot` for local data storage, making it fully portable across machines.
- **Global Config Support**: Optionally sync your workspace list via `$Global:GeminiWorkspaceConfig`.
- **Native Experience**: Integrated `ws` (manager) and `gws` (selector) commands.

## ⚙️ Installation

1. **Clone or Download** this module to your local machine (e.g., `D:\GitHub\gemini-cli-workspaces-selector`).

2. **Update your PowerShell Profile**:
   Run `notepad $PROFILE` and add the following:

   ```powershell
   # --- Gemini Workspace Selector Settings ---
   $GeminiModuleRoot = "D:\Path\To\gemini-cli-workspaces-selector"
   Import-Module (Join-Path $GeminiModuleRoot "gemini-cli-workspaces-selector.psm1") -Force
   ```

3. **Reload Profile**:
   Run `. $PROFILE` or restart your terminal.

## 🛠️ Usage

### 1. `ws` (Workspace Manager)
Used to manage your saved project paths.
- **`ws add .`**: Add the current directory to your list.
- **`ws remove`**: Open a selector to remove a path from the list.
- **`ws list`**: View all saved workspace paths.
- **`ws help`**: Show detailed help.

### 2. `gws` (Workspace Selector)
The core tool for rapid switching.
- Run `gws`.
- Enter the index number for your target workspace.
- The module will automatically switch to the directory and launch `gemini`.

---

## 📂 File Structure
- `gemini-cli-workspaces-selector.psm1`: Core logic.
- `gemini-cli-workspaces-selector.psd1`: Module manifest.
- `workspaces.json`: Auto-generated database (excluded by git).

## 📄 License
This project is licensed under the MIT License.
