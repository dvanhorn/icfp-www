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
   (person 'pcm "Michael" "Hanus" '("Christian-Albrechts-Universit" auml "t zu Kiel") "http://www.informatik.uni-kiel.de/~mh/")
   (person 'pcm "Fritz" "Henglein" "University of Copenhagen" "http://www.diku.dk/~henglein/")
   (person 'pcm "Mauro" "Jaskelioff" "Universidad Nacional de Rosario" "http://www.fceia.unr.edu.ar/~mauro/")
   (person 'pcm "Alan" "Jeffrey" "Alcatel-Lucent Bell Labs" "http://ect.bell-labs.com/who/ajeffrey/")
   (person 'pcm "Shin-ya" "Katsumata" "Kyoto University" "http://www.kurims.kyoto-u.ac.jp/~sinya/index-e.html")
   (person 'pcm "Shriram" "Krishnamurthi" "Brown University" "http://cs.brown.edu/~sk/")
   (person 'pcm "John" "Launchbury" "Galois" "http://corp.galois.com/john-launchbury")
   (person 'pcm "Ryan" "Newton" "Indiana University" "http://www.cs.indiana.edu/~rrnewton/homepage.html")
   (person 'pcm "Sungwoo" "Park" "Pohang University of Science and Technology" "http://www.postech.ac.kr/~gla/")
   (person 'pcm "Sam" "Staton" "University of Cambridge" "http://www.cl.cam.ac.uk/~ss368/")
   (person 'pcm "Nikhil" "Swamy" "Microsoft Research, Redmond" "http://research.microsoft.com/en-us/people/nswamy/")
   (person 'pcm "Dimitrios" "Vytiniotis" "Microsoft Research, Cambridge" "http://research.microsoft.com/en-us/people/dimitris/")))

;; end PC

(define contest-committee
  (list
   (person 'cc "Nikhil" "Swamy" "Microsoft Research, Redmond" "http://research.microsoft.com/en-us/people/nswamy/")
   (person 'cc "Michal" "Moskal" "Microsoft Research, Redmond" "http://research.microsoft.com/en-us/um/people/moskal/")
   (person 'cc "Nikolai" "Tillmann" "Microsoft Research, Redmond" "http://research.microsoft.com/en-us/people/nikolait/")
   (person 'cc "Peli" "de Halleux" "Microsoft Research, Redmond" "http://research.microsoft.com/en-us/people/jhalleux/")))

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
          contest-committee
          (list greg tarmo sam patrik david malcolm jean-baptiste andy)))

;; Role -> [Listof Person]
(define (get-roles r)
  (sort (filter (λ (p) (eq? r (person-role p))) people)
        string-ci<?
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
        ,@(local [(define affil (person-affil p))]
            (if (cons? affil) affil (list affil))))))

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
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "cfp.html"))
         "Call for papers"))
     (li
      ((class "roomy"))
      (a ((class "navigation")
	  (href "affiliated.html")) 
	 "Affiliated events"))
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
         "More about ICFP"))

     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "industry.html"))
         "Industrial partners")
      (p ((class "indent1")) "Platinum partners")
      (p ((class "indent2")) (a ((href "http://janestreet.com/")) "Jane Street Capital"))
      (p ((class "indent1")) "Silver partners")
      (p ((class "indent2")) (a ((href "http://www.erlang-solutions.com/")) "Erlang Solutions"))
      (p ((class "indent2")) (a ((href "https://www.fpcomplete.com/")) "FP Complete"))
      (p ((class "indent2")) (a ((href "http://corp.galois.com/")) "Galois"))
      (p ((class "indent2")) (a ((href "http://ccs.neu.edu/")) "Northeastern University, College of Computer and Information Science"))
      (p ((class "indent2")) "Bronze partners")
      (p ((class "indent2")) (a ((href "http://www.intellifactory.com/")) "IntelliFactory"))
      (p ((class "indent2")) (a ((href "http://www.quviq.com/")) "QuviQ"))))))

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

(define important-dates
  '[(h3 "Important dates")
    (table
     ((cellpadding "5"))
     (tr (td "Submissions due:")
         (td (a ((href "http://www.timeanddate.com/worldclock/city.html?n=1033"))
                "Thursday, 28 March 2013, 23:59 UTC-11 American Samoa time")))
     (tr (td "Author response:")
         (td "Wednesday, 22 May, 2013 " ndash " Friday, 24 May, 2013"))
     (tr (td "Notification:")
         (td "Friday, 7 June, 2013"))
     (tr (td "Final copy due:")
         (td "Friday, 5 July, 2013"))
     (tr (td "Conference:")
         (td "Wednesday, 25 September - Friday, 27 September, 2013")))])

(define (make-page title col)
  `(html
    (head
     @title{ICFP @,year : @,title}
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
         @h1[((style "font-size:400%"))]{ICFP @,year}
         @h2{The @,nth ACM SIGPLAN International
                  Conference on Functional Programming})))
      (div
       ((class "colmask leftmenu"))
       (div
        ((class "colleft"))
	,col
	,col2))
      ,@footers))))

(define cfp.xexpr
  (make-page 
   "Call for Papers"
   `(div
     ((class "col1"))
     (center
      (h1 "Call for Papers"))
     ,@important-dates         

     (h3 "Scope")
     (p "ICFP 2013 seeks original papers on the art and science of functional
programming.  Submissions are invited on all topics from principles to
practice, from foundations to features, and from abstraction to
application.  The scope includes all languages that encourage
functional programming, including both purely applicative and
imperative languages, as well as languages with objects, concurrency,
or parallelism.  Topics of interest include (but are not limited to):")
     (ul
      (li "Language Design: concurrency and distribution; modules; components
  and composition; metaprogramming; interoperability; type systems;
  relations to imperative, object-oriented, or logic programming")
      (li "Implementation: abstract machines; virtual machines; interpretation;
  compilation; compile-time and run-time optimization; memory
  management; multi-threading; exploiting parallel hardware; interfaces
  to foreign functions, services, components, or low-level machine
  resources")
      (li "Software-Development Techniques: algorithms and data structures;
  design patterns; specification; verification; validation; proof
  assistants; debugging; testing; tracing; profiling")
      (li "Foundations: formal semantics; lambda calculus; rewriting; type
  theory; monads; continuations; control; state; effects; program
  verification; dependent types")
      (li "Analysis and Transformation: control-flow; data-flow; abstract
  interpretation; partial evaluation; program calculation")
      (li "Applications and Domain-Specific Languages: symbolic computing;
  formal-methods tools; artificial intelligence; systems programming;
  distributed-systems and web programming; hardware design; databases;
  XML processing; scientific and numerical computing; graphical user
  interfaces; multimedia programming; scripting; system
  administration; security")
      (li "Education: teaching introductory programming; parallel programming;
  mathematical proof; algebra")
      (li "Functional Pearls: elegant, instructive, and fun essays on
  functional programming")
      (li "Experience Reports: short papers that provide evidence that
  functional programming really works or describe obstacles that have
  kept it from working"))
     (p "If you are concerned about the appropriateness of some topic, do not
hesitate to contact the program chair.")
     (h3 "Abbreviated instructions for authors")
     (ul
      (li "By Thursday, 28 March 2013, 23:59 UTC-11 (American Samoa time),
  submit a full paper of at most 12 pages (6 pages for an Experience
  Report), including bibliography and figures."))
     (p "The deadlines will be strictly enforced and papers exceeding the page
limits will be summarily rejected.")
     (ul
      (li "Authors have the option to attach supplementary material to a submission,
  on the understanding that reviewers may choose not to look at it.")
      (li "Each submission must adhere to SIGPLAN's republication policy, as
  explained on the web at "
	  (a ((href "http://www.sigplan.org/Resources/Policies/Republication"))
	     "http://www.sigplan.org/Resources/Policies/Republication"))
      (li "Authors of resubmitted (but previously rejected) papers have the
  option to attach an annotated copy of the reviews of their previous
  submission(s), explaining how they have addressed these previous
  reviews in the present submission.  If a reviewer identifies
  him/herself as a reviewer of this previous submission and wishes to
  see how his/her comments have been addressed, the program chair will
  communicate to this reviewer the annotated copy of his/her previous
  review.  Otherwise, no reviewer will read the annotated copies of
  the previous reviews."))
     (p "Overall, a submission will be evaluated according to its relevance,
correctness, significance, originality, and clarity.  It should
explain its contributions in both general and technical terms, clearly
identifying what has been accomplished, explaining why it is
significant, and comparing it with previous work.  The technical
content should be accessible to a broad audience.  Functional Pearls
and Experience Reports are separate categories of papers that need not
report original research results and must be marked as such at the
time of submission.  Detailed guidelines on both categories are on the
conference web site.")
     (p "Proceedings will be published by ACM Press.  Authors of accepted
submissions are expected to transfer the copyright to the
ACM.  Presentations will be videotaped and released online if the
presenter consents.")
     (p (em "Formatting: ")
	"Submissions must be in PDF format printable in black and
white on US Letter sized paper and interpretable by
Ghostscript. Papers must adhere to the standard ACM conference format:
two columns, nine-point font on a ten-point baseline, with columns
20pc (3.33in) wide and 54pc (9in) tall, with a column gutter of 2pc
(0.33in).  A suitable document template for LaTeX is available: "
             (a ((href "http://www.acm.org/sigs/sigplan/authorInformation.htm"))
                "http://www.acm.org/sigs/sigplan/authorInformation.htm"))
          (p (em "Submission: ") 
             "Submissions will be accepted on the web at "
	     (a ((href "https://www.easychair.org/conferences/?conf=icfp2013"))
                "https://www.easychair.org/conferences/?conf=icfp2013")
". Improved
versions of a paper may be submitted at any point before the
submission deadline using the same web interface.")
          (p (em "Author response: ")
             "Authors will have a 72-hour period, starting at 0:00
UTC-11 on Wednesday, 22 May 2013, to read reviews and respond to them.")

          (p (em "Special Journal Issue: ") 
             "There will be a special issue of the Journal of
Functional Programming with papers from ICFP 2013.  The program
committee will invite the authors of select accepted papers to submit
a journal version to this issue.")
          
          (h3 "Organizers")
          (table
           ((cellpadding "5")
            (summary "Organizers"))
           ,(role-row "General Chair" 'gc)
           ,(role-row "Program Chair" 'pc)
           (tr (td "Program Committee:"))
           ,@(map (lambda (p) (row "" p)) program-committee)))))     

(define industry.xexpr
  (make-page 
    "Industrial partnership program"
   `(div
     ((class "col1"))
     (center
      (h1 "Industrial partnership program"))
      (p "Would you be willing to provide corporate financial support for the " @,nth " ACM SIGPLAN International Conference on Functional Programming (ICFP)?")
      (p "Corporate support funds are primarily used to subsidize students" mdash "the lifeblood of our community" mdash "and in turn serve to raise the community profile of the supporting companies.")
      (p "Your generosity would make it possible for students from all over the world to attend ICFP, which is the premier conference in functional programming. There, they will meet luminaries in the field, as well as people who've succeeded in building a successful career built on functional programming. They will return home further motivated to continue pursuing functional programming in the confidence that exciting careers are available.")
      (p "This year, we're again offering levels of financial support to enable smaller companies to contribute while allowing larger companies to be as generous as they wish (with additional benefits, in recognition of that generosity).")
      (p "The proposed support levels, and their associated benefits and pledge amounts and benefits are as follows (costs in US dollars).")
      (table (tr (td (strong "Bronze"))
		 (td "$500")
		 (td "Logo on website, poster at industrial reception,
              listed in proceedings."))
	     (tr (td (strong "Silver"))
		 (td "$2000")
		 (td "As above plus: logo in proceedings, logo on
              publicity materials (e.g., posters, etc.)"))
	     (tr (td (strong "Gold"))
		 (td "$5000")
		 (td "As above plus: named supporter of industrial reception, opportunity to include branded merchandise in participants' swag bag."))
	     (tr (td (strong "Platinum"))
		 (td "$10000")
		 (td "As above plus: logo on swag bag, named supporter of whole event, logo on lanyards, badge ribbon, table/booth-like space available (in coffee break areas), other negotiated benefits (subject to ACM restrictions on commercial involvement).")))
      (p "As the premier conference in the field, ICFP is the ideal venue to promote your company's interests in functional programming, and to meet with prospective employees and leading figures in the community.")
      (p "For more information, please contact " (a ((href "mailto:andy.adamsmoran@gmail.com")) "Andy Adams-Moran") ", the Industrial Relations Chair."))))
	     
		 


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
              @em["Affiliated events: "  ,@affiliated-dates]))
         @p{ICFP 2013 provides a forum for researchers and
            developers to hear about the latest work on the design,
            implementations, principles, and uses of functional
            programming. The conference covers the entire spectrum of
            work, from practice to theory, including its
            peripheries.}
         

         (h3 "News")
         (ul
          (li (img ((src "img/new.gif")))
              "ICFP 2013 received a record setting 133 submissions!  Thanks to "
	      "all the authors for their hard work!"
	      (img ((src "img/new.gif"))))
          (li (img ((src "img/new.gif")))
              "The schedule of " (a ((href "affiliated.html")) "affiliated events")
	      " has been announced."
              (img ((src "img/new.gif"))))

          (li (img ((src "img/new.gif")))
              "The RiSE group at MSR Redmond has agreed to run the programming contest!"
              (img ((src "img/new.gif"))))
          (li "The " (a ((href "cfp.html")) "Call for Papers") " has been announced.")
          (li "Interested in sponsoring? "
              (a ((href ,(string-append "mailto:" industry-email)))
                 "Contact the Industrial Relations Chair"))
          (li "Dates have been chosen for ICFP and affiliated events."))
         
         ,@important-dates
         
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
          ,@(role-rows "Programming Contest Co-Chairs" 'cc)
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
            )

         (h3 "Industrial Partners")
         (h4 "Platinum partners")
         (img ((class "sponsor") (src "img/JS.png")))
         (h4 "Silver partners")
         (img ((class "sponsor") (src "img/erl_solutions_logo.png")))
	 " "
	 (img ((class "sponsor") (src "img/fp-complete.png")))
	 " "	 
	 (img ((class "sponsor") (src "img/galois.png")))
	 " "
	 (img ((class "sponsor") (src "img/CCIS.png")))
	 (h4 "Bronze partners")
         (img ((class "sponsor") (src "img/IntelliFactory.png")))
	 (img ((class "sponsor") (src "img/quviq.jpeg"))))
	
        ,col2)))
     ,@footers)))
  

(define workshop-date-par
  '(p "The workshops are scheduled to occur on September 22-24 (the three days before ICFP) "
      "and September 28 (the day after ICFP)."))
(define workshop-email
  (let ((addr (string-append "icfp" (substring year 2 4) "-workshops@" workshop-domain)))
    `(a ((href ,(string-append "mailto:" addr)))
        ,addr)))


(define CUFP `(a ((href "http://cufp.org/")) "ACM SIGPLAN Commercial Users of Functional Programming"))
(define FARM `(a ((href "http://www.cis.upenn.edu/~byorgey/farm13/"))
		 "ACM SIGPLAN Workshop on Functional Art, Music, Modeling and Design"))
(define Erlang `(a ((href "http://www.erlang.org/workshop/2013/"))
		   "ACM SIGPLAN Erlang Workshop"))
(define Haskell `(a ((href "http://www.haskell.org/haskell-symposium/"))
		    "ACM SIGPLAN Haskell Symposium"))
(define ML `(a ((href "http://research.microsoft.com/en-us/um/people/daan/mlworkshop2013/")) "ACM SIGPLAN Workshop on ML"))
(define HIW `(a ((href "http://www.haskell.org/haskellwiki/HaskellImplementorsWorkshop"))
		"ACM SIGPLAN Haskell Implementors Workshop"))
(define FPCDSL
  `(a ((href "http://quantum.bbn.com/FPCDSL/"))
      "ACM SIGPLAN Functional Programming Concepts in Domain-Specific Languages"))
(define WGP
  `(a ((href "http://www.wgp-sigplan.org/2013"))
      "ACM SIGPLAN Workshop on Generic Programming"))

(define affiliated.xexpr
  (make-page
   "Affiliated events"
   `(div
     ((class "col1"))
     (center
      (h1 "Affilated events"))

     (h3 "Sunday, September 22")
     (ul 
      (li ,CUFP " " ndash " Day 1, Tutorials")      
      (li "ACM SIGPLAN Dependently-typed programming")
      (li "ACM SIGPLAN International Workshop on Logical Frameworks and Meta-Languages: Theory and Practice")
      (li ,HIW)
      (li ,ML))

     (h3 "Monday, September 23")
     (ul
      (li ,CUFP " " ndash " Day 2, Tutorials")
      (li ,FPCDSL)
      (li "ACM SIGPLAN Workshop on Functional High-Performance Computing")
      (li ,Haskell " " ndash " Day 1"))
      

     (h3 "Tuesday, September 24")
     (ul
      (li ,Haskell "  " ndash " Day 2")
      (li "ACM SIGPLAN OCaml Workshop")
      (li ,CUFP " " ndash " Day 3, Talks"))

     (h3 "Wednesday, September 25 " ndash " Friday, September 27")
     (ul (li "ICFP"))

     (h3 "Saturday, September 28")
     (ul
      (li ,Erlang)
      (li ,FARM)
      (li "ACM SIGPLAN Workshop on Higher-order Programming with Effects")
      (li ,WGP)))))

(define cfwp.xexpr
  (make-page 
   "Call for Workshop and Co-Located Event Proposals"	     
   `(div
     ((class "col1"))
     (center
      (h1 "Call for workshop and co-located event proposals"))
     (h3 "Overview")
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
	"."))))

(define (write-page xexpr fn)
  (with-output-to-file (string-append www fn)
    #:exists 'replace
    (λ ()      
      @displayln{<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">}
      (write-xexpr xexpr))))

(write-page index.xexpr "index.html")
(write-page cfwp.xexpr "cfwp.html")
(write-page cfp.xexpr "cfp.html")
(write-page industry.xexpr "industry.html")
(write-page affiliated.xexpr "affiliated.html")


