#lang at-exp racket
(require xml)
;; (person Role String String String (U #f String))
(struct person (role first last affil url) #:transparent)

;; start PC

(define program-committee
  (list
   (person 'pcm "Thorsten" "Altenkirch" "University of Nottingham" "http://www.cs.nott.ac.uk/~txa/")
   (person 'pcm "Olaf" "Chitil" "University of Kent" "http://www.cs.kent.ac.uk/people/staff/oc/")
   (person 'pcm "Silvia" "Ghilezan" "University of Novi Sad" "http://imft.ftn.uns.ac.rs/~silvia/")
   (person 'pcm "Michael" "Hanus" "Christian-Albrechts-Universität zu Kiel" "http://www.informatik.uni-kiel.de/~mh/")
   (person 'pcm "Fritz" "Henglein" "University of Copenhagen" "http://www.diku.dk/~henglein/")
   (person 'pcm "Mauro" "Jaskelioff" "Universidad Nacional de Rosario" "http://www.fceia.unr.edu.ar/~mauro/")
   (person 'pcm "Alan" "Jeffrey" "Alcatel-Lucent Bell Labs" "http://ect.bell-labs.com/who/ajeffrey/")
   (person 'pcm "Shin-ya" "Katsumata" "Kyoto University" "http://www.kurims.kyoto-u.ac.jp/~sinya/index-e.html")
   (person 'pcm "Shriram" "Krishnamurthi" "Brown University" "http://cs.brown.edu/~sk/")
   (person 'pcm "John" "Launchbury" "Galois, Inc." "http://corp.galois.com/john-launchbury")
   (person 'pcm "Ryan" "Newton" "Indiana University" "http://www.cs.indiana.edu/~rrnewton/homepage.html")
   (person 'pcm "Sungwoo" "Park" "POSTECH" "http://www.postech.ac.kr/~gla/")
   (person 'pcm "Sam" "Staton" "University of Cambridge" "http://www.cl.cam.ac.uk/~ss368/")
   (person 'pcm "Nikhil" "Swamy" "MSR Redmond" "http://research.microsoft.com/en-us/people/nswamy/")
   (person 'pcm "Dimitrios" "Vytiniotis" "MSR Cambridge" "http://research.microsoft.com/en-us/people/dimitris/")))

;; end PC

(define greg
  (person 'gc "Greg" "Morrisett" "Harvard University" "http://www.eecs.harvard.edu/~greg/"))

(define tarmo
  (person 'pc "Tarmo" "Uustalu" "Institute of Cybernetics" "http://cs.ioc.ee/~tarmo/"))

(define sam 
  (person 'wc "Sam" "Tobin-Hochstadt" "Northeastern University" "http://www.ccs.neu.edu/home/samth/"))

(define patrik
  (person 'wc "Patrik" "Jansson" "Chalmers University of Technology" "http://www.cse.chalmers.se/~patrikj/"))

(define david
  (person 'pub "David" "Van Horn" "Northeastern University" "http://www.ccs.neu.edu/home/dvanhorn/"))

(define malcolm
  (person 'video "Malcolm" "Wallace" "Standard Chartered Bank" #f))

(define jean-baptiste
  (person 'treasurer "Jean-Baptiste" "Tristan" "Oracle Labs" "http://labs.oracle.com/people/tristan"))

(define andy
  (person 'industry "Andy" "Adams-Moran" "" "mailto:andy.adamsmoran@gmail.com"))

(define unknown
  (person 'unknown "???" "" "???" #f))


(define people
  (append program-committee
          (list greg tarmo sam patrik david malcolm jean-baptiste andy)))

;; Role -> [Listof Person]
(define (get-roles r)
  (sort (filter (λ (p) (eq? r (person-role p))) people)
        string<?
        #:key person-last))

;; Role -> Person
(define (get-role r)
  (match (get-roles r)
    [(list p) p]
    [(list) unknown]
    [_ (error 'get-role "Multiple roles")]))

;; Still need: 'industry 'local 'contest 'src

(define www "icfp2013/")
(define year "2013")
(define nth "18th")
(define city-img "img/boston.png")
(define city "Boston, Massachusetts")
(define dates '("September 25 " ndash " 27"))
(define affiliated-dates '("September 22 " ndash " 24 and 28"))
(define industry-email "adams-moran@galois.com")
(define cfwp-deadline "December 7, 2012")
(define cfwp-notification "January 7, 2013")
(define workshop-domain "ccs.neu.edu")

(define keywords
  @string-append{functional programming, functional programming languages, 
                 software design, software engineering, types, type system,
                 objects, object systems, classes, class systems, paper,
                 workshop, Erlang, Haskell, ML, Scheme, 2013})

(define (link url . s)
  (if url
      `((a ((href ,url)) ,@s))
      s))

(define (row desc p)
  `(tr
    (td ((align "left")) ,desc ,@(if (string=? desc "") '() '(":")))
    (td ((align "left"))
        ,@(link (person-url p) (person-first p) " " (person-last p)))
    (td ((align "left"))
        ,(person-affil p))))

(define (role-row desc r)
  (row desc (get-role r)))

(define (role-rows desc r)
  (define ps (get-roles r))
  (cons (row desc (first ps))
        (map (λ (p) (row "" p)) (rest ps))))

(define (role-oxford r)
  (define ps (get-roles r)) 
  (add-between (map person-name/link ps) ", " 
               #:before-last 
               (cond [(< (length ps) 3) " and "]
                     [else ", and "])))

(define (person-name p)
  (string-append (person-first p) " " (person-last p)))

(define (person-name/link p)
  (if (person-url p)
      `(a ((href ,(person-url p)))
          ,(person-name p))
      (person-name p)))

(define col2
  `(div 
    ((class "col2"))
    (a ((href "http://www.acm.org"))
       (img ((class "logo") (src "img/acm.png") (alt "ACM logo"))))
    
    (ul 
     ((class "hidden"))
     (li 
      ((class "roomy"))
      (a 
       ((class "navigation")
        (href "index.html"))
       "Home"))
     #;
     (li
      ((class "roomy"))
      "Call for papers")
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "cfwp.html"))
         "Call for workshop proposals"))
     #;
     (li
      ((class "roomy"))
      "Programming contest")
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "http://www.icfpconference.org"))
         "More about ICFP")))))

(define footers
  `((div
    ((id "footer"))
    (div 
     ((class "whited"))
     (p ((class "left"))
        (a ((class "footer-link")
            (href "http://sigplan.org/"))
           "ACM SIGPLAN"))
     (p ((class "right"))
        ,(let ((p (get-role 'pub)))
           `(a ((class "footer-link")
                (href ,(person-url p)))
               ,(person-name p)
               ", ICFP Publicity Chair")))))    
     
     @script[((type "text/javascript"))]{var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
                                         document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));}
     @script[((type "text/javascript"))]|{try {
                                          var pageTracker = _gat._getTracker("UA-10975741-1");
                                          pageTracker._trackPageview();
                                          } catch(err) {}}|))

(define index.xexpr
  `(html
    (head
     @title{ICFP @,year : The @,nth ACM SIGPLAN International Conference on Functional Programming}
     (meta ((http-equiv "Content-Type")
            (content "text/html; charset=us-ascii")))
     (meta ((name "keywords")
            (content ,keywords)))
     (meta ((name "content")
            (content "The conference provides a forum for researchers and developers to hear about the latest work on the design, implementations, principles, and uses of functional programming. The conference covers the entire spectrum of work, from practice to theory, including its peripheries.")))
     (link ((href "column.css")
            (rel "stylesheet")
            (type "text/css"))))
    (body
     (div 
      ((id "content"))
      (div
       ((id "header"))
       (center
        (div 
         ((class "whited"))
         @h1[((style "font-size:400%"))]{ICFP @,year}
         @h2{The @,nth ACM SIGPLAN International Conference on
                 Functional Programming})))
      (div
       ((class "colmask leftmenu"))
       (div
        ((class "colleft"))
        (div
         ((class "col1"))
         (center
          (div
           ((class "photo"))
           (img ((src ,city-img)))
           (p ((class "credit"))
              @em{Photo credit: @a[((href "http://www.flickr.com/people/werkunz/"))]{Werner Kunz}}))
          (h3 @em{@,city; @,@dates, @,year}
              (br)
              "Affiliated events: "
              ,@affiliated-dates))
         @p{ICFP 2013 provides a forum for researchers and
            developers to hear about the latest work on the design,
            implementations, principles, and uses of functional
            programming. The conference covers the entire spectrum of
            work, from practice to theory, including its
            peripheries.}
         
         (h3 "News")
         (ul
          (li (img ((src "img/new.gif")))
              "The Program Committee has been selected (below)."
              (img ((src "img/new.gif"))))
          (li (img ((src "img/new.gif")))
              "Important dates have been announced (below)."
              (img ((src "img/new.gif"))))
          (li "Interested in sponsoring? "
              (a ((href ,(string-append "mailto:" industry-email)))
                 "Contact the Industrial Relations Chair"))
          (li "Dates have been chosen for ICFP and affiliated events."))
         
         (h3 "Important dates")
         (table
          ((cellpadding "5"))
          (tr (td "Submissions due:")
              (td "Thursday, 28 March, 2013"))
          (tr (td "Author response:")
              (td "Wednesday, 22 May, 2013 " ndash " Friday, 24 May, 2013"))
          (tr (td "Notification:")
              (td "Friday, 7 June, 2013"))
          (tr (td "Final copy due:")
              (td "Friday, 5 July, 2013")))
         
         (h3 "Conference Organizers")
         (table
          ((cellpadding "5")
           (summary "Organizers"))
          ,(role-row "General Chair" 'gc)
          ,(role-row "Program Chair" 'pc)
          ;; No local arrangements chair at ICFP'13
          ;,(role-row "Local Arrangements Chair" 'local)
          ,(role-row "Industrial Relations Chair" 'industry)
          ,@(role-rows "Workshop Co-Chairs" 'wc)
          ;,@(role-rows "Programming Contest Co-Chairs" 'contest)
          ,(role-row "Publicity Chair" 'pub)
          ;,(role-row "Video Chair" 'video)
          ,(role-row "Treasurer" 'treasurer)
          ;,(role-row "Student Research Competition Chair" 'src)
          )

         (h3 "Program Committee")
         (table
            ((cellpadding "5")
             (summary "PC"))
	    ,@(map (lambda (p) (row "" p)) program-committee)
            ))

        ,col2)))
     ,@footers)))
  

(define workshop-date-par
  '(p "The workshops are scheduled to occur on September 22-24 (the three days before ICFP) "
      "and September 28 (the day after ICFP)."))
(define workshop-email
  (let ((addr (string-append "icfp" (substring year 2 4) "-workshops@" workshop-domain)))
    `(a ((href ,(string-append "mailto:" addr)))
        ,addr)))

(define cfwp.xexpr
  `(html
    (head
     @title{ICFP @,year : Call for Workshop and Co-Located Event Proposals}
     (meta ((http-equiv "Content-Type")
            (content "text/html; charset=us-ascii")))
     (meta ((name "keywords")
            (content ,keywords)))
     (link ((href "column.css")
            (rel "stylesheet")
            (type "text/css"))))
    (body
     (div
      ((id "content"))
      (div 
       ((id "header"))
       (center
        (div
         ((class "whited"))
         (h1 "Call for workshop and co-located event proposals")
         @h2{ICFP @,year : The @,nth ACM SIGPLAN International
                  Conference on Functional Programming})))
      (div
       ((class "colmask leftmenu"))
       (div
        ((class "colleft"))
        (div
         ((class "col1"))
         (center
          (h2
           (em ,city
               (br)
               ,@dates)))
         (p "The "
            ,nth
            " ACM SIGPLAN International Conference on Functional Programming ("
            (a ((href ,(string-append "http://www.icfpconference.org/icfp" year "/")))
               "ICFP " ,year)
            ") will be held in "
            ,city " on " @,@dates ". "
            "ICFP provides a forum for researchers and "
            "developers to hear about the latest work on the design, "
            "implementations, principles, and uses of functional "
            "programming.")
         (p "Proposals are invited for workshops (and other "
            "co-located events, such as tutorials) to be affiliated "
            "with ICFP " ,year " and sponsored by "
            (a ((href "http://acm.org/sigplan/")) "SIGPLAN")
            ".  "
            "These events should be more informal and focused than ICFP itself, "
            "include sessions that enable interaction among the "
            "attendees, and foster the exchange of new ideas. The preference is for "
            "one-day events, but other schedules can also be " 
            "considered.")
         
         ,workshop-date-par
         
         (h3 "Submission details")
         (table
          ((cellpadding "5"))
          (tbody
           (tr
            (td "Deadline for submission:")
            (td (font ((color "#FF0000")) (strong ,cfwp-deadline))))
           (tr 
            (td "Notification of acceptance:")
            (td ,cfwp-notification))))
         
         (p "Prospective organizers of workshops or other "
            "co-located events are invited to submit a completed "
            (a ((href ,(string-append "http://www.icfpconference.org/icfp" year
                                      "/icfp" (substring year 2 4) "-workshops-form.txt")))               
               "workshop proposal form")
            " in plain text format to the ICFP "
            ,year
            " workshop co-chairs ("
            ,@(role-oxford 'wc)
            ")"
            " via email to "
            ,workshop-email
            " by "
            ,cfwp-deadline
            ". "
            "(For proposals of co-located events other than workshops, "
            "please fill in the workshop proposal form and just leave "
            "blank any sections that do not apply.) Please note that "
            "this is a firm deadline.")
         (p "Organizers will be notified if their event proposal is "
            "accepted by "
            ,cfwp-notification
            ", and if successful, "
            "depending on the event, they will be asked to produce a "
            "final report after the event has taken place that is "
            "suitable for publication in SIGPLAN Notices. Further "
            "information about SIGPLAN sponsorship is available "
            (a ((href "http://www.sigplan.org/Resources/Proposals/Workshop"))
               "here")
            ".")
         (h3 "Selection committee")
         (p "The proposals will be evaluated by a committee "
            "comprising the following members of the ICFP "
            ,year
            " organizing committee, together with the members of the "
            (a ((href "http://acm.org/sigplan/SigplanOfficers.htm"))
               "SIGPLAN executive committee"))
         (table
          ((cellpadding "5"))
          (tbody
           ,@(role-rows "Workshop Co-Chairs" 'wc)
           ,(role-row "General Chair" 'gc)
           ,(role-row "Program Chair" 'pc)))
         
         (h3 "Further information")
         (p "Any queries should be addressed to the workshop "
            "co-chairs (" ,@(role-oxford 'wc) "), via email to "
            ,workshop-email
            "."))
        ,col2)))
     ,@footers)))

(define (write-page xexpr fn)
  (with-output-to-file (string-append www fn)
    #:exists 'replace
    (λ ()      
      @displayln{<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">}
      (write-xexpr xexpr))))

(write-page index.xexpr "index.html")
(write-page cfwp.xexpr "cfwp.html")



