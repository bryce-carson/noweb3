(use-modules (ice-9 format) (srfi srfi-1) (rnrs base))

(define options (make-hash-table))

(define (option sym default description validator category)
  (hash-set! options sym
             (list (cons 'value #nil)
                   (cons 'default default)
                   (cons 'description description)
                   (cons 'validator validator)
                   (cons 'category category)))
  default)

(define (option-get sym)
  (let* ((entry (hash-ref options sym)))
    (if entry
        (if (nil? (assq-ref entry 'value))
            (assq-ref entry 'default)
            (assq-ref entry 'value))
        #f)))

(define (option-set sym val)
  (let ((entry (hash-ref options sym)))
    (when entry
      (hash-set! options sym
                 (assq-set! entry 'value val))
      val)))

(define (option-validate sym)
  (let* ((entry (hash-ref options sym))
         (val (and entry (assq-ref entry 'value)))
         (validator (and entry (assq-ref entry 'validator))))
    (if (not validator)
        #t
        (let ((check (lambda (v)
                       (cond ((procedure? validator) (validator v))
                             (else #f)))))
          (if (list? val)
              (every check val)
              (check val))))))

(define (option-print)
  (hash-for-each
   (lambda (sym entry)
     (format #t "~a (~a): ~a = ~s~%" sym (assq-ref entry 'category)
             (assq-ref entry 'description) (assq-ref entry 'value)))
   options))

;; Example definitions (fixed/updated from provided)
(option 'PIPE "fork"
        "How to run pipelines of programs and utilities."
        (lambda (v) (member v '("fork" "spawn")))
        "System Calls")

(option 'BIN "/usr/bin"
        "The installation location for the 'no' command"
        (lambda (v) (and (string? v) (file-exists? v)))
        "Paths")

(option 'LIBEXEC "/usr/libexec/rammel"
        "The installation location of Rammel scripts and configuration files"
        (lambda (v) (and (string? v) (file-exists? v)))
        "Paths")

(option 'TEXINPUTS "/usr/share/texlive/texmf-local/tex/latex/rammel"
        "The installation location for LaTeX styles and macros (following the TeX Directory Standard)"
        (lambda (v) (string? v))
        "Paths")

(option 'SHELL "/usr/bin/bash"
        "The shell to use when calling scripts."
        (lambda (v) (and (string? v) (file-exists? v)))
        "Paths")

(option 'CC "gcc"
        "The name of an ANSI C compiler."
        (lambda (v) (and (string? v) (file-exists? v)))
        "C Compilation")

(option 'CFLAGS #nil
        "General C compilation flags used througout the entire C build process."
        #nil
        "C Compilation")

(option 'XCFLAGS #nil
        "Flags used in addition to ``CFLAGS'' when building the ``no'' binary. If your system provides tempnam(3), noweb's indexing will be more efficient if you add -DTEMPNAM to XCFLAGS, which is given to the C compiler."
        #nil
        "C Compilation")

(option 'LD #nil
        "A C linker-loader."
        #nil
        "C Compilation")

(option 'LDFLAGS #nil
        "Compilation flags for the linking stage, pased to ``ld''."
        #nil
        "C Compilation")

(option 'LIBPROLOGUE #nil
        "Options and flags passed to LINKER_LOADER prior to listing libraries; i.e. anything you need to write after listing libraries. It is used like the following: ld $LFLAGS $NOOBJS $LIBPROLOGUE ../cii/libcii ../lua/liblua.so ../lua/liblualibs.so $LIBEPILOGUE."
        #nil
        "C Compilation")

(option 'LIBEPILOGUE #nil
        "Options and flags passed to LINKER_LOADER after listing libraries; i.e. anything you need to write after listing libraries. It is used like the following: ld $LFLAGS $NOOBJS $LIBPROLOGUE ../cii/libcii ../lua/liblua.so ../lua/liblualibs.so $LIBEPILOGUE."
        #nil
        "C Compilation")

(option 'AR #nil
        "What to call to build an object-code library. An archiver or bundler tool used to produce object-code libraries from multiple object files; whatever ``ar'' is on your system, or whatever produces object-code libraries like .so or .dll."
        #nil
        "C Compilation")

(option 'RANLIB #nil
        "How to index an object-code library."
        ;; ranlib is a program for indexing object-code libraries; echo is a fallback.
        (lambda (v) (member v '("ranlib" "echo")))
        "Utilities")

(option 'CIIMAXALIGN #nil
        "The alignment (in bytes) of pointers returned by malloc; see cii/install.html for more"
        #nil
        "Utilities")

(option 'XINCLUDES #nil
        #nil
        #nil
        "Utilities")

(option 'POPEN #nil
        #nil
        #nil
        "Utilities")

(option 'POSIX #nil
        #nil
        #nil
        "Utilities")

(option 'STRERROR #nil
        #nil
        #nil
        "Utilities")

;; Conditionally assign the value of the option to a variable, setting it only
;; if it's not already defined in make.
(hash-for-each
 (lambda (opt entry)
   (gmk-eval (format #f "~a ?= ~a" (symbol->string opt)
                     (if (nil? (option-get opt))
                         ""
                         (option-get opt))))
   (let* ((option-name (symbol->string opt))
          (origin (gmk-expand (format #f "$(origin ~a)" option-name))))
     (gmk-eval (format #f "$(info \"The origin of ~a is: ~a.\")" option-name origin))
     (when (string=? "undefined" origin)
       (gmk-eval (format #f "$(error \"~a was not defined properly by Guile!\")"
                         option-name)))))
 options)

(when (string=? (gmk-expand "$(MAKECMDGOALS)") "help")
  (option-print))
