# Yazi Configuration Directory

This directory serves as the configuration hub for the [Yazi terminal file manager](https://yazi-rs.github.io/). It allows users to deeply customize Yazi's behavior, appearance (themes), keybindings, and extend its functionality through plugins.

## Project Overview

Yazi is a modern, high-performance terminal file manager. This directory houses all the user-specific configurations that tailor Yazi to individual preferences. The configurations are primarily managed through TOML files for settings and keybindings, and Lua scripts for custom logic and plugin integration.

## Key Files and Directories:

*   **`yazi.toml`**: The central configuration file for Yazi. It controls core manager settings, file preview behavior, external program integration for file opening, task management, and overall plugin configuration.
*   **`init.lua`**: A Lua script executed during Yazi's initialization. It's commonly used to customize UI elements like the status bar and header, and to programmatically activate or configure Yazi plugins.
*   **`keymap.toml`**: Defines all keyboard shortcuts and key sequences for various modes within Yazi, allowing for extensive customization of the interactive experience of the file manager.
*   **`opener.toml`**: Specifies custom rules for how Yazi handles opening different file types, allowing integration with preferred external applications (e.g., text editors, image viewers, web browsers).
*   **`package.toml`**: Manages external Yazi plugins, listing their sources, revisions, and hashes, similar to a dependency management file.
*   **`theme.toml`**: (Inferred) This file is typically used to define the color scheme, fonts, and other visual styling aspects of the Yazi interface, allowing for personalized aesthetics.
*   **`plugins.md`**: (Inferred) This Markdown file likely contains documentation, usage instructions, or a list of available plugins, providing guidance on extending Yazi's capabilities.
*   **`flavors/`**: This directory is designed to store different "flavors" or themes for Yazi. Each subdirectory within `flavors/` typically contains a complete set of configuration files to apply a specific visual theme to Yazi.
*   **`plugins/`**: This directory contains the Lua scripts and associated files for various Yazi plugins, which extend its functionality.

## Usage:

To customize your Yazi experience, you would typically modify the `.toml` and `.lua` files within this directory.

*   **Configuration:** Edit `yazi.toml` to adjust global settings, preview parameters, or define how external applications are invoked.
*   **Keybindings:** Modify `keymap.toml` to remap existing shortcuts or add new ones to suit your workflow.
*   **Theming:** Explore or create subdirectories within `flavors/` and update `theme.toml` (or reference a flavor in `yazi.toml`) to change Yazi's visual appearance.
*   **Extending Functionality:** Place new Lua-based plugins in the `plugins/` directory and configure their activation and behavior in `init.lua` or `yazi.toml`. `package.toml` is used to manage external plugin dependencies.

To keep your plugins up to date, you can use the Yazi package manager command:
`ya pkg upgrade`

**Note on Plugin Updates:**
During attempts to update plugins, the `ya pkg install` and `ya pkg upgrade` commands encountered persistent "No such file or directory" errors when attempting to copy plugin files, even after manual intervention (like creating missing directories and correcting `package.toml` syntax). This suggests a potential issue with the `ya pkg` commands in this specific environment, preventing reliable plugin installation and updates. Users may need to manually install or update plugins if these commands fail.