#lang at-exp racket
(require xml)
;; (person Role String String String (U #f String))
(struct person (role first last affil url) #:transparent)

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
  (person 'industry "Andy" "Adams-Moran" "Galois" "http://corp.galois.com/andrew-adams-moran/"))

(define unknown
  (person 'unknown "???" "" "???" #f))


(define people
  (list greg tarmo sam patrik david malcolm jean-baptiste andy))

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
(define affiliated-dates '("September ?? and ?? " ndash " ??"))
(define industry-email "adams-moran@galois.com")

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
  
(define (person-name p)
  (string-append (person-first p) " " (person-last p)))

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
              #;"Affiliated events: "
              #;,@affiliated-dates))
         @p{ICFP 2013 provides a forum for researchers and
            developers to hear about the latest work on the design,
            implementations, principles, and uses of functional
            programming. The conference covers the entire spectrum of
            work, from practice to theory, including its
            peripheries.}
         
         (h3 "News")
         (ul
          (li "Interested in sponsoring? "
              (a ((href ,(string-append "mailto:" industry-email)))
                 "Contact the Industrial Relations Chair"))
          (li (img ((src "img/new.gif")))
              "Dates have been chosen."
              (img ((src "img/new.gif")))))
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
         #;(h3 "Program Committee")
         #;(table
          ((cellpadding "5")
           (summary "PC"))
          ))
        
        (div 
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
          #;
          (li
           ((class "roomy"))
           "Call for workshop proposals")
          #;
          (li
           ((class "roomy"))
           "Programming contest")
          (li
           ((class "roomy"))
           (a ((class "navigation")
               (href "http://www.icfpconference.org"))
              "More about ICFP"))))))
      
      (div
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
                  ", ICFP Publicity Chair"))))))
     
     @script[((type "text/javascript"))]{var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
  document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));}
     @script[((type "text/javascript"))]|{try {
  var pageTracker = _gat._getTracker("UA-10975741-1");
  pageTracker._trackPageview();
  } catch(err) {}}|)))
     
                 
              

               

(with-output-to-file (string-append www "index.html")
  #:exists 'replace
  (λ () (write-xexpr index.xexpr)))

         
          