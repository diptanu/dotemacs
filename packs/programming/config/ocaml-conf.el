;;; OCaml support via Tuareg mode.

(live-add-pack-lib "tuareg")

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
  "Configuration of imenu for tuareg" t)


(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))

(add-hook 'tuareg-mode-hook
          '(lambda ()
            (define-key tuareg-mode-map (kbd "M-q")
             'tuareg-indent-phrase)
            (define-key tuareg-mode-map (kbd "C-c C-i")
             'caml-types-show-ident)
            (define-key tuareg-mode-map (kbd "C-c C-c") 'tuareg-eval-phrase)
            (define-key tuareg-mode-map (kbd "C-c C-k") 'tuareg-eval-buffer)
            (define-key tuareg-mode-map [f4] 'goto-line)
            (define-key tuareg-mode-map [f5] 'compile)
            (define-key tuareg-mode-map [f6] 'recompile)
            (define-key tuareg-mode-map [f7] 'next-error)
            (auto-fill-mode 1)
            (setq tuareg-sym-lock-keywords nil)))

;;; you need to have Opam & Utop for this to work
;;; http://opam.ocamlpro.com/
;;; https://github.com/diml/utop
(autoload 'utop "utop" "Toplevel for OCaml" t)
(eval-after-load "utop"
  (setq utop-command "opam config exec \"utop -emacs\""))

(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
