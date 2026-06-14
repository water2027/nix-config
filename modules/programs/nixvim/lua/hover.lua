local semantic_groups = {
  ["@lsp.type.class"] = "@type",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.interface"] = "@type",
  ["@lsp.type.struct"] = "@type",
  ["@lsp.type.type"] = "@type",
  ["@lsp.type.namespace"] = "@module",
  ["@lsp.type.function"] = "@function",
  ["@lsp.type.method"] = "@function.method",
  ["@lsp.type.parameter"] = "@variable.parameter",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.variable"] = "@variable",
  ["@lsp.mod.readonly"] = "@constant",
}

for group, link in pairs(semantic_groups) do
  vim.api.nvim_set_hl(0, group, { link = link, default = true })
end

package.preload["water.hover.combined"] = function()
  local api = vim.api
  local diagnostic = vim.diagnostic
  local lsp = vim.lsp

  local severity_names = {
    [diagnostic.severity.ERROR] = "Error",
    [diagnostic.severity.WARN] = "Warn",
    [diagnostic.severity.INFO] = "Info",
    [diagnostic.severity.HINT] = "Hint",
  }

  local function diagnostic_lines(bufnr, pos)
    local diagnostics = diagnostic.get(bufnr, { lnum = pos[1] - 1 })
    if vim.tbl_isempty(diagnostics) then
      return {}
    end

    table.sort(diagnostics, function(a, b)
      return (a.severity or 99) < (b.severity or 99)
    end)

    local lines = { "## Diagnostics", "" }
    for _, item in ipairs(diagnostics) do
      local severity = severity_names[item.severity] or "Diagnostic"
      local source = item.source and (" (" .. item.source .. ")") or ""
      local code = item.code and (" `" .. tostring(item.code) .. "`") or ""
      local message_lines = vim.split(item.message or "", "\n", {
        plain = true,
        trimempty = true,
      })

      if #message_lines == 0 then
        message_lines = { "" }
      end

      lines[#lines + 1] = string.format(
        "- **%s**%s%s: %s",
        severity,
        source,
        code,
        message_lines[1]
      )

      for i = 2, #message_lines do
        lines[#lines + 1] = "  " .. message_lines[i]
      end
    end

    return lines
  end

  local function lsp_params(client, bufnr, pos)
    local row = pos[1] - 1
    local col = pos[2]
    local line = api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1] or ""

    col = math.min(col, #line)

    return {
      textDocument = { uri = vim.uri_from_bufnr(bufnr) },
      position = {
        line = row,
        character = vim.str_utfindex(line, client.offset_encoding or "utf-16", col),
      },
    }
  end

  local function finish(done, diagnostics, clients, hovers)
    local lines = {}

    vim.list_extend(lines, diagnostics)

    local hover_count = 0
    for _, client in ipairs(clients) do
      if hovers[client.id] then
        hover_count = hover_count + 1
      end
    end

    if hover_count > 0 then
      if #lines > 0 then
        lines[#lines + 1] = ""
        lines[#lines + 1] = "---"
        lines[#lines + 1] = ""
      end

      lines[#lines + 1] = "## LSP Hover"
      lines[#lines + 1] = ""

      for _, client in ipairs(clients) do
        local hover = hovers[client.id]
        if hover then
          if hover_count > 1 then
            lines[#lines + 1] = "### " .. client.name
            lines[#lines + 1] = ""
          end

          vim.list_extend(lines, hover)
          lines[#lines + 1] = ""
        end
      end

      while lines[#lines] == "" do
        lines[#lines] = nil
      end
    end

    if #lines == 0 then
      done(false)
      return
    end

    done({
      lines = lines,
      filetype = "markdown",
    })
  end

  return {
    name = "Diagnostics + LSP",
    priority = 2000,
    enabled = function(bufnr, opts)
      local pos = opts and opts.pos or api.nvim_win_get_cursor(0)
      local diagnostics = diagnostic.get(bufnr, { lnum = pos[1] - 1 })
      local clients = lsp.get_clients({
        bufnr = bufnr,
        method = "textDocument/hover",
      })

      return not vim.tbl_isempty(diagnostics) or #clients > 0
    end,
    execute = function(params, done)
      local diagnostics = diagnostic_lines(params.bufnr, params.pos)
      local clients = lsp.get_clients({
        bufnr = params.bufnr,
        method = "textDocument/hover",
      })

      if #clients == 0 then
        finish(done, diagnostics, clients, {})
        return
      end

      local remaining = #clients
      local hovers = {}

      for _, client in ipairs(clients) do
        client:request("textDocument/hover", lsp_params(client, params.bufnr, params.pos), function(err, result)
          if api.nvim_buf_is_valid(params.bufnr) and not err and result and result.contents then
            local lines = lsp.util.convert_input_to_markdown_lines(result.contents)
            if not vim.tbl_isempty(lines) then
              hovers[client.id] = lines
            end
          end

          remaining = remaining - 1
          if remaining == 0 then
            finish(done, diagnostics, clients, hovers)
          end
        end, params.bufnr)
      end
    end,
  }
end

require("hover").config({
  providers = {
    "water.hover.combined",
  },
  preview_opts = {
    border = "rounded",
    focus = false,
    max_height = 30,
    max_width = 100,
  },
  preview_window = false,
  title = true,
})
