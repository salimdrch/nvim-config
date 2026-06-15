return {
  -- Désactiver friendly-snippets
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },

  -- LuaSnip
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Charge les snippets JSON custom (terraform, k8s)
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      -- Snippets Ansible en Lua (s'appliquent au filetype yaml)
      ls.add_snippets("yaml", {
        s("ans_play", {
          t({ "---", "- name: " }), i(1, "Nom du playbook"),
          t({ "", "  hosts: " }), i(2, "all"),
          t({ "", "  become: " }), i(3, "true"),
          t({ "", "  gather_facts: " }), i(4, "true"),
          t({ "", "", "  tasks:", "    - name: " }), i(5, "Task principale"),
          t({ "", "      " }), i(6, "module"), t(":"),
          t({ "", "        " }), i(7, "option"), t(": "), i(8, "valeur"),
        }),
        s("ans_task", {
          t("- name: "), i(1, "Description"),
          t({ "", "  " }), i(2, "module"), t(":"),
          t({ "", "    " }), i(3, "option"), t(": "), i(4, "valeur"),
          t({ "", "  when: " }), i(5, "condition"),
        }),
        s("ans_pkg", {
          t("- name: Installer "), i(1, "package"),
          t({ "", "  ansible.builtin.package:", "    name: " }), i(1),
          t({ "", "    state: " }), i(2, "present"),
          t({ "", "  become: true" }),
        }),
        s("ans_service", {
          t("- name: "), i(1, "Gérer"), t(" le service "), i(2, "service"),
          t({ "", "  ansible.builtin.service:", "    name: " }), i(2),
          t({ "", "    state: " }), i(3, "started"),
          t({ "", "    enabled: " }), i(4, "true"),
          t({ "", "  become: true" }),
        }),
        s("ans_copy", {
          t("- name: Copier "), i(1, "fichier"),
          t({ "", "  ansible.builtin.copy:", "    src: " }), i(2, "source"),
          t({ "", "    dest: " }), i(3, "destination"),
          t({ "", "    owner: " }), i(4, "root"),
          t({ "", "    mode: '" }), i(5, "0644"), t("'"),
          t({ "", "  become: true" }),
        }),
        s("ans_debug", {
          t("- name: Debug "), i(1, "variable"),
          t({ "", "  ansible.builtin.debug:", '    msg: "{{ ' }), i(1), t(' }}"'),
        }),
        s("ans_reg", {
          t("- name: "), i(1, "Commande"),
          t({ "", "  ansible.builtin.command: " }), i(2, "cmd"),
          t({ "", "  register: " }), i(3, "result"),
          t({ "", "  changed_when: false", "", "- name: " }), i(4, "Task conditionnelle"),
          t({ "", "  " }), i(5, "module"), t(":"),
          t({ "", "  when: " }), i(3), t(".rc == 0"),
        }),
        s("ans_handler", {
          t("- name: "), i(1, "handler"),
          t({ "", "  ansible.builtin.service:", "    name: " }), i(2, "service"),
          t({ "", "    state: " }), i(3, "restarted"),
        }),
        s("ans_block", {
          t({ "- name: " }), i(1, "Block"),
          t({ "", "  block:", "    - name: " }), i(2, "Task"),
          t({ "", "      " }), i(3, "module"), t(":"),
          t({ "", "  rescue:", "    - name: Erreur", "      ansible.builtin.debug:", '        msg: "Erreur"', }),
          t({ "", "  always:", "    - name: Toujours", "      ansible.builtin.debug:", '        msg: "Terminé"' }),
        }),
      })
    end,
  },

  -- blink.cmp
  {
    "saghen/blink.cmp",
    opts = {
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            opts = {
              search_paths = { vim.fn.stdpath("config") .. "/snippets" },
              friendly_snippets = false,
            },
          },
        },
      },
    },
  },
}
