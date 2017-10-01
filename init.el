;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t

   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   dotspacemacs-configuration-layers
   '(
     helm
     emacs-lisp
     git
     syntax-checking
     version-control
     semantic
     ;; vinegar
     ranger
     better-defaults
     org
     markdown
     html
     javascript
     ruby
     react
     windows-scripts
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      auto-completion-tab-key-behavior nil) ;; was 'complete
     (shell :variables
            shell-default-shell 'eshell
            ;; shell-default-height 30
            shell-default-position 'right)
     ;; spell-checking
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            ;; c-c++-enable-clang-support t
            )
     shaders
     )

   dotspacemacs-additional-packages '(doom-themes hlinum)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(evil-unimpaired org-agenda smartparens)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim ;; `vim', `emacs' or `hybrid'.
   ;; output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists '(
                                (todos . 5)
                                (recents . 5)
                                (projects . 7)
                                )
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(
                         doom-one
                         spacemacs-dark
                         spacemacs-light
                         )

  ;;  dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab t
  ;;  ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
  ;;  dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text t
  ;;  ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
  ;;  dotspacemacs-ex-substitute-global nil
  ;;  dotspacemacs-default-layout-name "Default"
  ;;  dotspacemacs-display-default-layout nil
  ;;  dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
  ;;  dotspacemacs-max-rollback-slots 5
  ;;  dotspacemacs-helm-resize nil
  ;;  dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
  ;;  ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
  ;;  ;; several times cycle between the kill ring content. (default nil)
  ;;  dotspacemacs-enable-paste-transient-state nil
  ;;  ;; Which-key delay in seconds. The which-key buffer is the popup listing
  ;;  ;; the commands bound to the current keystroke sequence. (default 0.4)
  ;;  dotspacemacs-which-key-delay 0.4
  ;;  dotspacemacs-which-key-position 'bottom
  ;;  dotspacemacs-loading-progress-bar nil
  ;;  dotspacemacs-fullscreen-at-startup nil
  ;;  dotspacemacs-fullscreen-use-non-native nil
  ;;  dotspacemacs-maximized-at-startup nil
  ;;  ;; Transparency can be toggled through `toggle-transparency'. (default 90)
  ;;  dotspacemacs-active-transparency 90
  ;;  dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
  ;;  ;; dotspacemacs-folding-method 'origami ;; `evil' or `origami'.
  ;;  dotspacemacs-smartparens-strict-mode nil
  ;;  dotspacemacs-smart-closing-parenthesis nil
  ;;  ;; `any', `current', `all' or `nil'. Default is `all'
  ;;  dotspacemacs-highlight-delimiters 'all
  ;;  dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
  ;;  ;; Not used for now. (default nil)
  ;;  dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'trailing

   js2-basic-offset 2
   js2-skip-preprocessor-directives t
   css-indent-offset 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2

   powerline-default-separator 'alternate

   syntax-checking-enable-by-default nil
  )
)

(defun dotspacemacs/user-init ()
  (defun sized-font (size)
    (append '("M+ 1m"
              :weight regular
              :width normal
              :powerline-scale 1.1
              :size
              ) (list size)))

  (defun set-font-size (size)
    (setq-default
     dotspacemacs-default-font (sized-font size))
    )

  (set-font-size 36) ;; needed because below detection not working on xps

  (cond
   ((string-equal system-name "jostein-xps") (set-font-size 34)) ;; Not working??
   ((string-equal system-name "Jossier") (set-font-size 14))
   ((string-equal system-name "JANOSCH") (set-font-size 16)))


  ;; Helper for compilation. Close the compilation window if
  ;; there was no error at all.
  (defun compilation-exit-autoclose (status code msg)
    ;; If M-x compile exists with a 0
    (when (and (eq status 'exit) (zerop code))
      ;; then bury the *compilation* buffer, so that C-x b doesn't go there
      (bury-buffer)
      ;; and delete the *compilation* window
      (delete-window (get-buffer-window (get-buffer "*compilation*"))))
    ;; Always return the anticipated result of compilation-exit-message-function
    (cons msg code))
  ;; Specify my function (maybe I should have done a lambda function)
  (setq compilation-exit-message-function 'compilation-exit-autoclose)

  ;; Dired sorting

  (defun mydired-sort ()
    "Sort dired listings with directories first."
    (save-excursion
      (let (buffer-read-only)
        (forward-line 2) ;; beyond dir. header
        (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
      (set-buffer-modified-p nil)))

  (defadvice dired-readin
      (after dired-after-updating-hook first () activate)
    "Sort dired listings with directories first before adding marks."
    (mydired-sort))
)

(defun dotspacemacs/user-config ()
  ;; (global-hl-line-mode -1) ; Disable current line highlight
  (global-linum-mode) ; Show line numbers by default
  (global-company-mode)
  (hlinum-activate)

  (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))

  ;; (setq split-height-threshold nil)
  (setq split-width-threshold 100)

  (setq global-visual-line-mode t)
  (global-set-key (kbd "TAB") 'hippie-expand)

  (define-key evil-insert-state-map (kbd "C-c") 'evil-escape)
  (define-key evil-visual-state-map (kbd "C-c") 'evil-escape)

  (define-key evil-normal-state-map (kbd "RET") 'evil-search-forward)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
  (define-key evil-normal-state-map (kbd "-")   'deer)

  (define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
  (set-quit-char "C-c")

  (add-to-list 'company-backends 'company-c-headers)
  ;; (add-to-list 'company-c-headers-path-user "./vendor/src")

  ;; (set-face-attribute 'helm-selection nil
  ;;                     :background "dark slate grey"
  ;;                     :foreground "snow")

  (c-add-style "jbe" '((indent-tabs-mode . nil)
                       (c-basic-offset . 2)
                       (c-offsets-alist
                        (substatement-open . 0)
                        (inline-open . 0)
                        (statement-cont . c-lineup-assignments)
                        (inextern-lang . 0)
                        (innamespace . 0))))

  (push '(other . "jbe") c-default-style)

  ;; (doom-themes-neotree-config)
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ranger xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill toc-org tagedit stickyfunc-enhance srefactor spaceline smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restart-emacs rbenv rake rainbow-delimiters pug-mode powershell popwin persp-mode paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree mwim multi-term move-text mmm-mode minitest markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc info+ indent-guide hungry-delete htmlize hlinum hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot glsl-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy flycheck-pos-tip flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav dumb-jump doom-themes disaster diff-hl define-word company-web company-tern company-statistics company-quickhelp company-c-headers column-enforce-mode coffee-mode cmake-mode clean-aindent-mode clang-format chruby bundler auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
