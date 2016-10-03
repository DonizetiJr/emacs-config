
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (atom-one-dark)))
 '(custom-safe-themes
   (quote
    ("4f0f2f5ec60a4c6881ba36ffbfef31b2eea1c63aad9fe3a4a0e89452346de278" "ec0c9d1715065a594af90e19e596e737c7b2cdaa18eb1b71baf7ef696adbefb0" "d8f76414f8f2dcb045a37eb155bfaa2e1d17b6573ed43fb1d18b936febc7bbc2" "eb362c06579833584e5f8a49fe118920dc7fd2a27fa86bef195618de99478678" "365d8aa2dcffdf657e9ed5313656663dac50caf7f79555cba6cc7e540f9427d3" "bc39bfc20dffdba6e9882f273a0028d1ac88001e04d818b53f66e65f8fdfc402" "8b30636c9a903a9fa38c7dcf779da0724a37959967b6e4c714fdc3b3fe0b8653" default)))
 '(fci-rule-color "#343d46")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (atom-one-dark-theme neotree spacegray-theme magit iedit evil-visual-mark-mode)))
 '(show-paren-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#bf616a")
     (40 . "#DCA432")
     (60 . "#ebcb8b")
     (80 . "#B4EB89")
     (100 . "#89EBCA")
     (120 . "#89AAEB")
     (140 . "#C189EB")
     (160 . "#bf616a")
     (180 . "#DCA432")
     (200 . "#ebcb8b")
     (220 . "#B4EB89")
     (240 . "#89EBCA")
     (260 . "#89AAEB")
     (280 . "#C189EB")
     (300 . "#bf616a")
     (320 . "#DCA432")
     (340 . "#ebcb8b")
     (360 . "#B4EB89"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

 (require 'package)

 (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
 (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
 (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

 (setq package-enable-at-startup nil)
 (package-initialize)

 (require 'evil)
 (evil-mode t)

 (defun ensure-package-installed (&rest packages)
   "Assure every package is installed, ask for installation if it’s not.

 Return a list of installed packages or nil for every skipped package."
   (mapcar
    (lambda (package)
      (if (package-installed-p package)
          nil
        (if (y-or-n-p (format "Package %s is missing. Install it? " package))
            (package-install package)
          package)))
    packages))

 ;; Make sure to have downloaded archive description.
 (or (file-exists-p package-user-dir)
     (package-refresh-contents))

 ;; Activate installed packages
 (package-initialize)

 ;; Assuming you wish to install "iedit" and "magit"
 (ensure-package-installed 'iedit 'magit)

 (add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Themes configuration

(global-linum-mode 1)

(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

(fringe-mode -1)

;; Neotree

(add-to-list 'package-archives
              '("melpa" . "http://melpa.org/packages/"))
(setq neo-smart-open t)
(add-to-list 'load-path "/Dropbox/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(defun neotree-project-dir ()
   "Open NeoTree using the git root."
   (interactive)
   (let ((project-dir (ffip-project-root))
         (file-name (buffer-file-name)))
     (if project-dir
         (progn
           (neotree-dir project-dir)
           (neotree-find file-name))
       (message "Could not find git project root."))))

 (add-hook 'neotree-mode-hook
           (lambda ()
             (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
             (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
             (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
             (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))


;; Twittering

(add-to-list 'load-path "~/epg")

(setq twitterong-use-master-password t)
(setq twittering-icon-mode t)                   ;; Show icons
(setq twittering-timer-intervald 300
      twittering-tinyurl-service 'migre.me
      twittering-url-show-status nil
      twitttering-use-icon-storage t
      )           
(setq twittering-url-show-statis nil)           ;; Keeps the echo area from showing all the http processes


