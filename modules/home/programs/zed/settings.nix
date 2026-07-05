{ pkgs, config, ... }:
{
  # ---------------------------------------------------------------------
  # Разделение ответственности:
  #
  #   home-manager (этот файл) отвечает ТОЛЬКО за:
  #     - редакторские LSP общего назначения, не привязанные к языку
  #       проекта (TOML/YAML/JSON/Markdown/Nix/Bash/HTML-CSS-emmet)
  #     - универсальные форматтеры (prettier/black/shfmt/nixfmt/taplo)
  #   Это вещи, которые нужны ВСЕГДА, в любом проекте и вне проектов,
  #   и версия которых не имеет значения (не завязана на код в репе).
  #
  #   devenv.nix КАЖДОГО ПРОЕКТА отвечает за:
  #     - сам язык/тулчейн (go, rustc, python, node...)
  #     - его LSP (gopls, rust-analyzer, pyright, typescript-language-server,
  #       vue/svelte-language-server, clangd)
  #     - библиотеки/зависимости проекта
  #   Всё это версионируется вместе с проектом и приходит через
  #   direnv (load_direnv = "direct") — попадает в PATH раньше
  #   глобального и Zed берёт именно его.
  #
  #   Если .envrc/devenv в проекте нет — Zed скачает LSP сам (bundled
  #   auto-download), это встроенное поведение и Nix тут ни при чём.
  # ---------------------------------------------------------------------

  home.packages = with pkgs; [
    # --- редакторские LSP общего назначения ---
    taplo                         # TOML
    yaml-language-server          # YAML
    marksman                      # Markdown
    jsonnet-language-server       # Jsonnet
    vscode-langservers-extracted  # json/html/css/eslint LSP
    nixd
    nil                           # два Nix LSP
    tailwindcss-language-server
    emmet-ls
    bash-language-server

    # --- универсальные форматтеры ---
    black                         # Python-форматтер (сам по себе лёгкий,
                                  # даже если pyright — per-project)
    shfmt                         # Bash
    nixfmt                        # Nix (на старом канале — nixfmt-classic)
    prettier                      # TOML/YAML/MD/JSON/HTML/CSS/SCSS/TS/JS
    # ПРИМЕЧАНИЕ: ванильный prettier из nixpkgs не тянет сторонние
    # плагины (prettier-plugin-svelte/vue). Если нужно форматирование
    # .svelte/.vue — кладите свой prettier + плагин в devenv.nix проекта.
  ];

  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "make"
      "git-firefly"
    ];

    userSettings = {
      disable_ai = true;
      load_direnv = "direct";

      session = {
        restore_unsaved_buffers = true;
        trust_all_worktrees = true;
      };

      format_on_save = "on";
      formatter = "auto";
      lsp = {
        taplo.binary = {
          path = "taplo";
          arguments = [ "lsp" "stdio" ];
        };

        yaml-language-server.binary = {
          path = "yaml-language-server";
          arguments = [ "--stdio" ];
        };

        marksman.binary = {
          path = "marksman";
          arguments = [ "server" ];
        };

        jsonnet-language-server.binary = {
          path = "jsonnet-language-server";
          arguments = [ "--stdio" ];
        };

        vscode-json-language-server.binary = {
          path = "vscode-json-language-server";
          arguments = [ "--stdio" ];
        };

        vscode-html-language-server.binary = {
          path = "vscode-html-language-server";
          arguments = [ "--stdio" ];
        };

        vscode-css-language-server.binary = {
          path = "vscode-css-language-server";
          arguments = [ "--stdio" ];
        };

        eslint.binary = {
          path = "vscode-eslint-language-server";
          arguments = [ "--stdio" ];
        };

        bash-language-server.binary = {
          path = "bash-language-server";
          arguments = [ "start" ];
        };

        nixd.binary.path = "nixd";
        nil.binary.path = "nil";

        tailwindcss-language-server.binary = {
          path = "tailwindcss-language-server";
          arguments = [ "--stdio" ];
        };

        emmet-ls.binary = {
          path = "emmet-ls";
          arguments = [ "--stdio" ];
        };
      };

      languages = {
        TOML = {
          language_servers = [ "taplo" ];
          format_on_save = "on";
          formatter.external = {
            command = "taplo";
            arguments = [ "fmt" "-" ];
          };
          tab_size = 2;
        };

        YAML = {
          language_servers = [ "yaml-language-server" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "yaml" ];
          };
          tab_size = 2;
        };

        Markdown = {
          language_servers = [ "marksman" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "markdown" ];
          };
          tab_size = 2;
          soft_wrap = "editor_width";
        };

        JSON = {
          language_servers = [ "vscode-json-language-server" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "json" ];
          };
          tab_size = 2;
        };

        Jsonnet = {
          language_servers = [ "jsonnet-language-server" ];
          format_on_save = "on";
          tab_size = 2;
        };

        HTML = {
          language_servers = [ "vscode-html-language-server" "tailwindcss-language-server" "emmet-ls" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "html" ];
          };
          tab_size = 2;
        };

        CSS = {
          language_servers = [ "vscode-css-language-server" "tailwindcss-language-server" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "css" ];
          };
          tab_size = 2;
        };

        SCSS = {
          language_servers = [ "vscode-css-language-server" "tailwindcss-language-server" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "scss" ];
          };
          tab_size = 2;
        };

        Bash = {
          language_servers = [ "bash-language-server" ];
          format_on_save = "on";
          formatter.external = {
            command = "shfmt";
            arguments = [ "-i" "2" ];
          };
          tab_size = 2;
        };

        Nix = {
          language_servers = [ "nixd" "nil" ];
          format_on_save = "on";
          formatter.external.command = "nixfmt";
          tab_size = 2;
        };

        # --- языки ниже: LSP не биндится глобально, приходит из
        # devenv.nix конкретного проекта (или Zed качает сам) ---

        Svelte = {
          language_servers = [ "svelte-language-server" "tailwindcss-language-server" "emmet-ls" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "svelte" "--plugin" "prettier-plugin-svelte" ];
          };
          tab_size = 2;
        };

        Go = {
          language_servers = [ "gopls" ];
          format_on_save = "on";
          tab_size = 4;
        };

        TypeScript = {
          language_servers = [ "typescript-language-server" "eslint" "tailwindcss-language-server" "emmet-ls" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "typescript" ];
          };
          tab_size = 2;
        };

        TSX = {
          language_servers = [ "typescript-language-server" "eslint" "tailwindcss-language-server" "emmet-ls" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "typescript" ];
          };
          tab_size = 2;
        };

        JavaScript = {
          language_servers = [ "typescript-language-server" "eslint" "tailwindcss-language-server" "emmet-ls" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "babel" ];
          };
          tab_size = 2;
        };

        Vue = {
          language_servers = [ "vue-language-server" "tailwindcss-language-server" "emmet-ls" ];
          format_on_save = "on";
          formatter.external = {
            command = "prettier";
            arguments = [ "--parser" "vue" ];
          };
          tab_size = 2;
        };

        Python = {
          language_servers = [ "pyright" ];
          format_on_save = "on";
          formatter.external = {
            command = "black";
            arguments = [ "-" ];
          };
          tab_size = 4;
        };

        C = {
          language_servers = [ "clangd" ];
          format_on_save = "on";
          tab_size = 2;
        };

        "C++" = {
          language_servers = [ "clangd" ];
          format_on_save = "on";
          tab_size = 2;
        };

        Rust = {
          language_servers = [ "rust-analyzer" ];
          format_on_save = "on";
          tab_size = 4;
        };
      };
    };
  };
}
