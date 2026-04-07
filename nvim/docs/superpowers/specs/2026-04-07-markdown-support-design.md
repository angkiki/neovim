# Markdown Support Design

**Date:** 2026-04-07
**Status:** Approved

## Goal

Add inline markdown rendering to Neovim so that `.md` files are displayed with rendered headings, bullets, code blocks, checkboxes, and tables directly in the buffer — without opening a browser or separate window.

## Approach

Use `render-markdown.nvim` (MeanderingProgrammer/render-markdown.nvim), the de-facto standard plugin for inline buffer rendering. It uses Neovim's virtual text and concealment API on top of treesitter (already installed with `markdown` and `markdown_inline` parsers).

## Changes

### 1. New plugin file: `lua/plugins/render-markdown.lua`

- Registers `MeanderingProgrammer/render-markdown.nvim` via lazy.nvim
- `ft = { "markdown" }` — only loads for `.md` files
- Depends on `nvim-treesitter/nvim-treesitter` (already present) and `nvim-tree/nvim-web-devicons` (already present via nvim-tree)
- Default config: renders headings, bullets, code blocks, checkboxes, and tables inline
- Rendering is active in normal/command mode; raw markdown syntax is visible in insert mode (plugin default)

### 2. Update `lua/plugins/conform.lua`

- Add `markdown = { "prettierd", "prettier", stop_after_first = true }` to `formatters_by_ft`
- Consistent with existing JS/TS/JSON formatter pattern
- Auto-formats `.md` files on save

## Out of Scope

- Browser-based preview
- Markdown LSP / linting
- Custom rendering themes or overrides (can be added later)
