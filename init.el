; 言語を日本語にする
(set-language-environment 'Japanese)

;; 極力 UTF-8 とする
;(prefer-coding-system 'utf-8)

;; デフォルトの文字コードと改行コード
(set-default-coding-systems 'utf-8-dos)

;; パスとファイル名はShift_JIS
(setq default-file-name-coding-system 'japanese-cp932-dos)

;; カレントディレクトリをホームディレクトリに設定
;; ""内は任意のディレクトリを指定可能
(cd "~/")

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号表示
;;(global-linum-mode t)
;;(set-face-attribute 'linum nil
;;                    :foreground "#800"
;;                    :height 0.9)

;; バックアップを残さない
(setq make-backup-files nil)

; C-h を backspace にする
(global-set-key "\C-h" 'delete-backward-char)

; 現在行をハイライトする
(global-hl-line-mode t)
(defface my-hl-line-face
  '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
     (:background "DarkSlateBlue" t))   ; 背景を黒に.
    (((class color) (background light)) ; カラーかつ, 背景が light ならば,
     (:background "ForestGreen" t))     ; 背景を ForestGreen に.
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)

; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)

;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)

;; タブ幅
(custom-set-variables '(tab-width 4))

;;現在行、現在何文字目かを表示
(line-number-mode 1)
(column-number-mode 1)

;;背景色と前景色
;;(set-background-color "black")
(set-background-color "#1c1c1c")
;;(set-foreground-color "#e6e6fa")
(set-foreground-color "#e6e6fa")

;;ツールバースタイル非表示
(tool-bar-mode 0)

;;スクロールバー非表示
(scroll-bar-mode 0)

;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.90))

;; 分割ウインドウ内の移動
(global-set-key (kbd "C-<left>") 'windmove-left) 
(global-set-key (kbd "C-<down>") 'windmove-down) 
(global-set-key (kbd "C-<up>")   'windmove-up) 
(global-set-key (kbd "C-<right>") 'windmove-right) 

;; 文字サイズ
(set-face-attribute 'default nil
:family "メイリオ" ;; font 
;;:family "Meiryo UI" ;; font 
;;:family "ＭＳ 明朝" ;; font 
;;:family "HG丸ｺﾞｼｯｸM-PRO" ;; font 
:height 100) ;; font size

;; Proxyの設定
(setq url-proxy-services '(("http" . "proxy.ome.toshiba.co.jp:8080")))

;; ELPAの設定
(when (require 'package nil t)
     ;;パッケージリポジトリにMELPAとSoftware DesignのELPAを追加
     (add-to-list 'package-archives
                  '("melpa" . "http://melpa.milkbox.net/packages/"))
     (add-to-list 'package-archives
                  '("ELPA" . "http://tromey.com/elpa/"))
;;インストールしたパッケージにロードパスを通してロードする
(package-initialize))

;; auto-completeの設定
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-use-menu-map t) ;;;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t) ;; 曖昧マッチ

;; org-autolist enter等で前行のリストを引き継げる
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))

;; org-ac org mode向けauto complete
(require 'org-ac)
(org-ac/config-default)



;; Web-modeの設定
(when (require 'web-mode nil t)
  ;; 自動的にweb-modeを起動したい拡張子を追加する
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))

  ;;; web-modeのインデント設定用フック
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev))
          )
        )
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

)

;; org-redmine
(require 'org-redmine)

;; org-textile
(add-to-list 'load-path "~/.emacs.d/org-textile/")
(require 'ox-textile)

;; org-modeのTODO項目を追加
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAIT(w)" "SOMEDAY(s)" "|" "DONE(d)" "REJECT(r)")))
;; DONEの時刻を記録
;; (setq org-log-done 'time)

;; 見出しの余分なstarが見えなくなる
(setq org-hide-leading-stars t)

;; scratch-log
;; (require 'scratch-log)

;; scratchのデフォルトをorgmodeで
(switch-to-buffer (get-buffer-create "*scratch*"))
;;(insert "#+TITLE:Scratch buffer with org-mode.\n\n") なぜかこれ効かない
(org-mode)

;; org-tree-slide
(require 'org-tree-slide)
(define-key org-mode-map (kbd "<f5>") 'org-tree-slide-mode)
(define-key org-mode-map (kbd "S-<f5>") 'org-tree-slide-skip-done-toggle)

;; ctags path
(setq tags-table-list '("~/Documents/cloud/tc-rendezvous-client/timeon_remotejp_demo/TAGS" "~/Documents/cloud/jpngfront/TAGS"))

;; ox-html5slide
(require 'ox-html5slide)
