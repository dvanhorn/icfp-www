#lang at-exp racket
(require xml)
;; Role = Symbol | [Listof Symbol]
;; (person Role String String String (U #f String))
(struct person (role first last affil url) #:transparent)

(struct person/email person (email))

;; start PC

(define program-committee
  (list
   (person 'pcm "Edwin" "Brady" "University of St Andrews" "http://edwinb.wordpress.com")
   (person 'pcm "Derek" "Dreyer" "MPI-SWS" "https://www.mpi-sws.org/~dreyer/")
   (person 'pcm "Ralf" "Hinze" "University of Oxford" "http://www.cs.ox.ac.uk/ralf.hinze/")
   (person 'pcm "Zhenjiang" "Hu" "National Institute of Informatics" "http://research.nii.ac.jp/~hu/")
   (person 'pcm "Patricia" "Johann" "Appalachian State University" "http://cs.appstate.edu/~johannp/")
   (person 'pcm "Ken Friis" "Larsen" "University of Copenhagen" "http://www.diku.dk/~kflarsen/")
   (person 'pcm "Yukiyoshi" "Kameyama" "University of Tsukuba" "http://logic.cs.tsukuba.ac.jp/~kam/")
   (person 'pcm "Anil" "Madhavapeddy" "University of Cambridge" "http://anil.recoil.org")
   (person 'pcm "Geoffrey" "Mainland" "Drexel University" "https://www.cs.drexel.edu/~mainland/")
   (person 'pcm "David" '("Mazi" egrave "res") "Stanford University" "http://www.scs.stanford.edu/~dm/")
   (person 'pcm "Jay" "McCarthy" "Brigham Young University" "http://faculty.cs.byu.edu/~jay/home/")
   (person 'pcm "Matthew" "Might" "University of Utah" "http://matt.might.net")
   (person 'pcm "Ulf" "Norell" "Chalmers University of Technology" "http://www.cse.chalmers.se/~ulfn/")
   (person 'pcm "Tiark" "Rompf" "Oracle Labs and EPFL (Swiss Federal Institute of Technology in Lausanne)" "http://tiarkrompf.github.io")
   (person 'pcm "Chung-chieh" "Shan" "Indiana University" "http://homes.soic.indiana.edu/ccshan/")
   (person 'pcm "Mary" "Sheeran" "Chalmers University of Technology" "http://www.cse.chalmers.se/~ms/")
   (person 'pcm "Matt" "Sottile" "Galois" "http://corp.galois.com/matt-sottile/")
   (person 'pcm "Don" "Syme" "Microsoft Research" "http://research.microsoft.com/en-us/people/dsyme/")
   (person 'pcm "Jesse" "Tov" "Harvard University" "http://www.eecs.harvard.edu/~tov/")))

;; end PC

(define contest-committee
  (list
   (person 'cc "Nicolas" "Wu" "University of Oxford" "http://www.cs.ox.ac.uk/people/nicolas.wu/")
   (person 'cc "Duncan" "Coutts" "Well Typed LLP" "http://www.well-typed.com/people/duncan")))

(define contest-url
  "http://icfpcontest.org/")

(define johan
  (person 'gc "Johan" "Jeuring" "Utrecht University" "http://www.staff.science.uu.nl/~jeuri101/homepage/"))

(define manuel
  (person 'pc "Manuel" "Chakravarty" "University of New South Wales" "http://www.cse.unsw.edu.au/~chak/"))

(define sam 
  (person '(wc sr) "Sam" "Tobin-Hochstadt" "Indiana University" "http://samth.github.io/"))

(define tom
  (person 'wc "Tom" "Schrijvers" "Ghent University" "http://users.ugent.be/~tschrijv/"))

(define david
  (person 'pub "David" "Van Horn" "University of Maryland" "http://www.cs.umd.edu/~dvanhorn/"))

(define malcolm
  (person 'video "Malcolm" "Wallace" "Standard Chartered Bank" #f))
(define iavor
  (person 'video "Iavor" "Diatchki" "Galois" #f))

(define jean-baptiste
  (person 'treasurer "Jean-Baptiste" "Tristan" "Oracle Labs" "http://labs.oracle.com/people/tristan"))

(define bjorn
  (person 'local '("Bj" ouml "rn") "von Sydow" "Chalmers University" "http://www.chalmers.se/cse/EN/people/sydow-bjorn-von"))

(define meng
  (person 'src "Meng" "Wang" "Chalmers University"  "http://www.chalmers.se/cse/EN/people/wang-meng"))

(define anil
  (person/email 'industry "Anil" "Madhavapeddy" "University of Cambridge" "http://anil.recoil.org/"
		"anil@recoil.org"))

(define reid
  (person 'mac "Reid" "Holmes" "University of Waterloo" "https://cs.uwaterloo.ca/~rtholmes/"))

(define unknown
  (person 'unknown "???" "" "???" #f))


(define student-research-committee
  (list sam
	(person 'sr "Andrew" "Kennedy" "Microsoft Research Cambridge" "http://research.microsoft.com/en-us/um/people/akenn/")
	(person 'sr "Jeremy" "Gibbons" "University of Oxford" "http://www.cs.ox.ac.uk/jeremy.gibbons/")
	(person 'sr "Matthieu" "Sozeau" "INRIA Paris" "http://mattam.org/")
	(person 'sr "Stephanie" "Weirich" "University of Pennsylvania" "http://www.cis.upenn.edu/~sweirich/")))
	

(define people
  (set->list
    (apply set
	   (append program-committee
		   contest-committee
		   student-research-committee
		   (list johan manuel sam tom david malcolm iavor jean-baptiste anil bjorn meng reid)))))

;; Person Symbol -> Boolean
(define (has-role? p s)
  (define r (person-role p))
  (cond [(symbol? r) (eq? r s)]
        [else (ormap (lambda (r) (eq? r s)) r)]))

;; Role -> [Listof Person]
(define (get-roles r)
  (sort (filter (λ (p) (has-role? p r)) people)
        string-ci<?
        #:key person-last))

;; Role -> Person
(define (get-role r)
  (match (get-roles r)
    [(list p) p]
    [(list) unknown]
    [_ (error 'get-role "Multiple roles")]))

;; Still need: 'industry 'local 'contest 'src

(define www "icfp2014/")
(define year "2014")
(define nth "19th")
(define city-img "img/gothenburg.jpg")
(define city '("Gothenburg, Sweden")) ; '("G" ouml "teborg, Sweden"))
(define dates '("September 1 " ndash " 3"))
(define affiliated-dates '("August 31 " ndash " September 4 " ndash " 6"))
(define industry-email "adams-moran@galois.com")
(define cfwp-deadline "November 15, 2013")
(define cfwp-notification "December 15, 2013")
(define workshop-domain "ugent.be")

(define keywords
  @string-append{functional programming, functional programming languages, 
                 software design, software engineering, types, type system,
                 objects, object systems, classes, class systems, paper,
                 workshop, Erlang, Haskell, ML, Scheme, 2013})

(define (link url . s)
  (if url
      `((a ((href ,url)) ,@s))
      s))

(define (listify x)
  (if (cons? x) x (list x)))

(define (person-link p)
  (apply link (person-url p) (append (listify (person-first p))
				     (list " ")
				     (listify (person-last p)))))

(define (row desc p)
  `(tr
    (td ((align "left")) ,desc ,@(if (string=? desc "") '() '(":")))
    (td ((align "left"))
        ,@(person-link p)
          #;(let ((f  (person-first p)))
            (cond [(cons? f)
                   (apply link (person-url p) (append f (list " " (person-last p))))]
                  [else
                   (link (person-url p) f " " (person-last p))])))
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
  (cond [(cons? (person-first p))
         (append (person-first p) (list " " (person-last p)))]
        [else
         (list (person-first p) " " (person-last p))]))

(define (role-person/email r)
  (define p (get-role r))
  `(a ((href ,(string-append "mailto:" (person/email-email p))))
     ,@(person-name p)))

(define (person-name/link p)
  (if (person-url p)
      `(a ((href ,(person-url p)))
          ,@(person-name p))
      `(span ,@(person-name p))))

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
          (href "program.html"))
         "Program"))
     
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "https://regmaster4.com/2014conf/ICFP14/register.php"))
         "Registration"))     
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "local.html"))
         "Local information"))        
     
     (li
      ((class "roomy"))
      (a ((class "navigation")
	  (href "affiliated.html")) 
	 "Affiliated events"))

     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "src.html"))
         "Student Research Competition"))

     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "sv.html"))
         "Student Volunteer Program"))

     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "student-attendance.html"))
         "Student Attendance Programs"))

          
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "cfp.html"))
         "Call for papers"))
     
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "cfwp.html"))
         "Call for workshop proposals"))     
     
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href ,contest-url))
         "Programming contest"))
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
      (p ((class "indent1")) "Gold partners")
      (p ((class "indent2")) (a ((href "https://google.com/")) "Google"))
      (p ((class "indent2")) (a ((href "http://research.microsoft.com/")) "Microsoft Research"))
      (p ((class "indent2")) (a ((href "https://www.mozilla.org/")) "Mozilla"))
      #;(p ((class "indent2")) (a ((href "https://www.fpcomplete.com/")) "FP Complete"))      
      #;(p ((class "indent2")) (a ((href "http://nsf.gov/")) "National Science Foundation"))
      (p ((class "indent2")) (a ((href "http://labs.oracle.com/")) "Oracle Labs"))
      (p ((class "indent2")) (a ((href "http://www.standardchartered.com/")) "Standard Chartered Bank"))
      (p ((class "indent1")) "Silver partners")
      (p ((class "indent2")) (a ((href "http://www.bloomberg.com")) "Bloomberg"))
      (p ((class "indent2")) (a ((href "https://www.credit-suisse.com/global/en/")) "Credit Suisse"))
      (p ((class "indent2")) (a ((href "http://cyberpointllc.com/")) "CyberPoint"))
      (p ((class "indent2")) (a ((href "https://www.erlang-solutions.com/")) "Erlang Solutions"))
      (p ((class "indent2")) (a ((href "http://www.facebook.com/")) "Facebook"))
      (p ((class "indent2")) (a ((href "http://corp.galois.com/")) "Galois"))
      (p ((class "indent2")) (a ((href "http://hiperfit.dk/")) "HIPERFIT"))
      (p ((class "indent2")) (a ((href "https://klarna.com/")) "Klarna")) " "
      (p ((class "indent2")) (a ((href "http://www.lexifi.com/")) "Lexifi"))            
      #;(p ((class "indent2")) (a ((href "http://www.inria.fr/")) "INRIA"))
      #;(p ((class "indent2")) (a ((href "http://oreilly.com/")) "O'Reilly Media"))
      (p ((class "indent2")) (a ((href "http://twitter.com")) "Twitter"))
      (p ((class "indent1")) "Bronze partners")
      (p ((class "indent2")) (a ((href "http://www.alephcloud.com/")) "Alephcloud"))
      (p ((class "indent2")) (a ((href "http://www.intellifactory.com/")) "IntelliFactory"))
      (p ((class "indent2")) (a ((href "http://www.operasoftware.com/")) "Opera Software"))
      (p ((class "indent2")) (a ((href "http://www.quviq.com/")) "QuviQ"))
      (p ((class "indent2")) (a ((href "http://www.systorvest.no/")) "Systor Vest AS"))))))

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
               ,@(person-name p)
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
     #;(tr (td "Workshop proposals due:")
         (td "Friday, 15 November 2013"))
     (tr (td "Submissions due:")
         (td (a ((href "http://www.timeanddate.com/worldclock/fixedtime.html?msg=ICFP+2014+Paper+Submission&iso=20140301T2359&p1=1890"))
                "Saturday, 1 March 2014, 23:59 UTC-11 (anywhere in the world)")))
     (tr (td "Author response:")
         (td "Wednesday, 23 April, 2014 " ndash " Friday, 25 April, 2014"))
     (tr (td "Notification:")
         (td "Monday, 5 May, 2014"))
     (tr (td "Final copy due:")
         (td "Wednesday, 11 June, 2014"))
     #;(tr (td "Programming contest:")
         (td "Thursday, 8 August - Sunday, 11 August, 2013"))
     #;(tr (td "Early registration:")
         (td "Thursday, 22 August, 2013"))
     (tr (td "Conference:")
         (td "Monday, 1 September - Wednesday, 3 September 2014")))])

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
     (p "ICFP " ,year " seeks original papers on the art and science of functional
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
      (li "By Saturday, 1 March 2014, 23:59 UTC-11 (Samoa Standard Time),
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
presenter consents. The proceedings will be freely available for 
download from the ACM Digital Library from one week before the 
start of the conference until two weeks after the conference.")
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
             (a ((href "https://www.easychair.org/conferences/?conf=icfp2014"))
                "https://www.easychair.org/conferences/?conf=icfp2014")
	    ". Improved
versions of a paper may be submitted at any point before the
submission deadline using the same web interface.")
          (p (em "Author response: ")
             "Authors will have a 72-hour period, starting at 0:00
UTC-11 on Wednesday, 23 April 2014, to read reviews and respond to them.")

          #;(p (em "Special Journal Issue: ") 
             "There will be a special issue of the Journal of
Functional Programming with papers from ICFP 2013.  The program
committee will invite the authors of select accepted papers to submit
a journal version to this issue.")
          (p "ACM Author-Izer is a unique service that enables ACM
authors to generate and post links on either their home page or
institutional repository for visitors to download the definitive
version of their articles from the ACM Digital Library at no
charge. Downloads through Author-Izer links are captured in official
ACM statistics, improving the accuracy of usage and impact
measurements. Consistently linking the definitive version of ACM
article should reduce user confusion over article versioning. After
your article has been published and assigned to your ACM Author
Profile page, please visit "
(a ((href "http://www.acm.org/publications/acm-author-izer-service")) "http://www.acm.org/publications/acm-author-izer-service")
" to learn how
to create your links for fee downloads from the ACM DL.")
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
		 (td "$2500")
		 (td "As above plus: logo in proceedings, logo on
              publicity materials (e.g., posters, etc.)"))
	     (tr (td (strong "Gold"))
		 (td "$5000")
		 (td "As above plus: named supporter of industrial reception, opportunity to include branded merchandise in participants' swag bag."))
	     (tr (td (strong "Platinum"))
		 (td "$10000")
		 (td "As above plus: logo on swag bag, named supporter of whole event, logo on lanyards, badge ribbon, table/booth-like space available (in coffee break areas), other negotiated benefits (subject to ACM restrictions on commercial involvement).")))
      (p "As the premier conference in the field, ICFP is the ideal venue to promote your company's interests in functional programming, and to meet with prospective employees and leading figures in the community.")
      (p "For more information, please contact " ,(role-person/email 'industry) ", the Industrial Relations Chair."))))
	     
		 


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
              (em "Photo credit: "
                  (a ((href "http://www.goteborg.com/")) "www.goteborg.com/")
                  "Kjell Holmner")))
          (h3 @em{@,@city; @,@dates, @,year}
              (br)
              @em["Affiliated events: "  ,@affiliated-dates]))
         @p{ICFP @,year provides a forum for researchers and
            developers to hear about the latest work on the design,
            implementations, principles, and uses of functional
            programming. The conference covers the entire spectrum of
            work, from practice to theory, including its
            peripheries.}
         

         (h3 "News")
	 (ul
          (li "A zipped bundle of all of the papers from ICFP and co-located events is now "
	      (a ((href "ICFP_2014_emaster.zip")) "available to download") ".")
          (li "ICFP and affiliated events are now on " (a ((href "http://www.conferoapp.com")) "Confero")
              " for your mobile device. Can be viewed in any web browser or in the dedicted Confero app, available on Apple App store and Google Play.")
          (li "There will be an industrial reception, supported by "
	      "ICFP's platinum and gold sponsors, at the Museum of World "
	      "Culture on Thursday, 4 September starting at 18:30.  The museum is just a short walk from the conference venue.")
          (li "The " (a ((href "program.html")) "complete proceedings") " of ICFP 2014 "
	      "are now available through the ACM Digital Library.  Free access to the proceedings "
	      "will be granted for one year.")
          (li "Schedules for ICFP and all affiliated event are now available in one "
	      (a ((href "program.pdf")) "pdf document")
	      " (will be handed out to attendees in printed form). Also includes social events to enable you to plan your stay in Gothenburg.")
          (li "August 3 is the deadline for early " (a ((href "https://regmaster4.com/2014conf/ICFP14/register.php")) "registration") ".")
          (li "The " (a ((href "program.html")) "program") " has been finalized!")
          (li "The invited speakers for ICFP 2014 are:" 
	      (ul (li (a ((href "http://www.cs.tufts.edu/~kfisher/Kathleen_Fisher/Home.html")) "Kathleen Fisher") 
	      ": "
	      (em "Using Formal Methods to Enable More Secure Vehicles:
DARPA's HACMS Program"))
		  (li
		   (a ((href "http://www.eecs.northwestern.edu/~robby/")) "Robby Findler")
		   ": "
		   (em "Behavioral Software Contracts"))
		  (li
		   (a ((href "http://www.cis.upenn.edu/~sweirich/")) "Stephanie Weirich")
		   ": "
		   (em "Depending on Types"))))

          (li "Details of the 2014 " (a ((href "http://icfpcontest.org/")) "Programming Contest") " have been announced.  The contest starts 25 July.")
          (li (a ((href "https://regmaster4.com/2014conf/ICFP14/register.php")) "Registration") " is now open!  Early registration ends 3 August.")
          (li "The " (a ((href "accepted.html")) "list of accepted papers") " is now online.")
	  (li "The " (a ((href "src.html")) "student research competition") " has been announced.  Deadline for submission: 29 June.")
	  (li "The " (a ((href "affiliated.html")) "affiliated event") " schedule is now available."))
         
         ,@important-dates
         
         (h3 "Conference Organizers")
         (table
          ((cellpadding "5")
           (summary "Organizers"))
          ,(role-row "General Chair" 'gc)
          ,(role-row "Program Chair" 'pc)
          ,(role-row "Local Arrangements Chair" 'local)
          ,(role-row "Industrial Relations Chair" 'industry)
          ,@(role-rows "Workshop Co-Chairs" 'wc)
          ,@(role-rows "Programming Contest Co-Chairs" 'cc)
          ,(role-row "Student Research Competition Chair" 'src)
          ,(role-row "Publicity Chair" 'pub)
          ,@(role-rows "Video Chair" 'video)
          ;,(role-row "Treasurer" 'treasurer)
	  ,(role-row "Mobile App Chair" 'mac)
          )

         (h3 "Program Committee")
         (table
            ((cellpadding "5")
             (summary "PC"))
	    ,@(map (lambda (p) (row "" p)) program-committee)
            )

         
         (h3 "Industrial Partners")
         (img ((class "sponsor") (src "img/logos.png")))
         #|
         (h4 "Platinum partners")
         (img ((class "sponsor") (src "img/JS.png")))
         (h4 "Gold partners")
         (img ((class "sponsor") (src "img/google.png")))         
         (img ((class "sponsor") (src "img/msr.png")))         
         (img ((class "sponsor") (src "img/mozilla.png")))
	 #;(img ((class "sponsor") (src "img/fp-complete.png")))         
         #;(img ((class "sponsor") (src "img/nsf.png")))
         (img ((class "sponsor") (src "img/ol.jpg")))
         (img ((class "sponsor") (src "img/standard-chartered.png")))
         (h4 "Silver partners")
         (img ((class "sponsor") (src "img/bloomberg.png")))
	 (img ((class "sponsor") (src "img/creditsuisse.png")))
	 (img ((class "sponsor") (src "img/cyberpoint.png"))) " "
	 (img ((class "sponsor") (src "img/erl_solutions_logo.png")))
	 (img ((class "sponsor") (src "img/fb.png")))
	 (img ((class "sponsor") (src "img/galois.png"))) " "
         (img ((class "sponsor") (src "img/klarna.png")))
	 (img ((class "sponsor") (src "img/lexifi.png")))               	 
         #;" "	 
	 #;(img ((class "sponsor") (src "img/google.png")))
         #;(img ((class "sponsor") (src "img/inria.png")))
	 #;(img ((class "sponsor") (src "img/CCIS.png")))
         #;(img ((class "sponsor") (src "img/oreilly.png")))
         (img ((class "sponsor") (src "img/twitter-bird-light-bgs.png")))
	 (h4 "Bronze partners")
         (img ((class "sponsor") (src "img/IntelliFactory.png")))
         (img ((class "sponsor") (src "img/opera.png")))
	 (img ((class "sponsor") (src "img/quviq.jpeg"))) 
	 (img ((class "sponsor") (src "img/systorvestlogo.png")))
         |#
         )
	
        ,col2)))
     ,@footers)))
  

(define workshop-date-par
  '(p "The workshops are scheduled to occur on August 31 (the day before ICFP) "
      "and September 4-6 (the three days after ICFP)."))
(define workshop-email
  (let ((addr (string-append "icfp" year #;(substring year 2 4) "-workshops@" workshop-domain)))
    `(a ((href ,(string-append "mailto:" addr)))
        ,addr)))


(define CUFP `(a ((href "http://cufp.org/")) "ACM SIGPLAN Commercial Users of Functional Programming"))
(define FARM `(a ((href "http://functional-art.org/"))
		 "ACM SIGPLAN Workshop on Functional Art, Music, Modeling and Design"))
(define Erlang `(a ((href "http://www.erlang.org/workshop/2014/"))
		   "ACM SIGPLAN Erlang Workshop"))
(define Haskell 
  `(a ((href "http://www.haskell.org/haskell-symposium/2014/"))
      "ACM SIGPLAN Haskell Symposium"))
(define ML   
  `(a ((href "http://okmij.org/ftp/ML/ML14.html"))
      "ACM SIGPLAN ML Family Workshop"))
(define HIW `(a ((href "http://www.haskell.org/haskellwiki/HaskellImplementorsWorkshop"))
		"ACM SIGPLAN Haskell Implementors Workshop"))
(define HART 
  `(a ((href "http://www.program-transformation.org/HART14/"))
      "ACM SIGPLAN Workshop on Haskell and Rewriting Techniques"))
    
#;
(define FPCDSL
  `(a ((href "http://quantum.bbn.com/FPCDSL/"))
      "ACM SIGPLAN Functional Programming Concepts in Domain-Specific Languages"))
(define WGP
  `(a ((href "http://www.wgp-sigplan.org/2014"))
      "ACM SIGPLAN Workshop on Generic Programming"))
(define HOPE 
  `(a ((href "http://hope2014.mpi-sws.org"))
      "ACM SIGPLAN Workshop on Higher-order Programming with Effects"))

(define FHPC
  `(a ((href "https://sites.google.com/site/fhpcworkshops/fhpc-2014"))
      "ACM SIGPLAN Workshop on Functional High-Performance Computing"))
#;
(define DTP
  `(a ((href "http://www.seas.upenn.edu/~sweirich/dtp13"))
      "ACM SIGPLAN Dependently-typed programming"))
#;
(define LFMTP
  `(a ((href "http://complogic.cs.mcgill.ca/lfmtp13"))
      "ACM SIGPLAN International Workshop on Logical Frameworks and Meta-Languages: Theory and Practice"))
(define OCAML
  `(a ((href "http://ocaml.org/meetings/ocaml/2014/"))
      "ACM SIGPLAN OCaml Workshop"))

(define affiliated.xexpr
  (make-page
   "Affiliated events"
   `(div
     ((class "col1"))
     (center
      (h1 "Affiliated events"))

     (h3 "Sunday, August 31")
     (ul 
      (li ,WGP)
      (li ,HOPE))

     (h3 "Monday, September 1 " ndash " Wednesday, September 3")
     (ul (li "ICFP"))

     (h3 "Thursday, September 4")
     (ul
      (li ,CUFP " " ndash "Day 1, Tutorials")
      (li ,Haskell " " ndash " Day 1")
      (li ,FHPC)
      (li ,ML))

     (h3 "Friday, September 5")
     (ul
      (li ,CUFP " " ndash "Day 2, Tutorials")
      (li ,Haskell " " ndash "Day 2")
      (li ,OCAML)
      (li ,Erlang)
      #;(li ,HART))

     (h3 "Saturday, September 6")
     (ul 
      (li ,CUFP  " " ndash "Day 3, Talks")
      (li ,HIW)
      (li ,FARM)))))

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
	,@city " on " @,@dates ". "
	"ICFP provides a forum for researchers and "
	"developers to hear about the latest work on the design, "
	"implementations, principles, and uses of functional "
	"programming.")
     (p "Proposals are invited for workshops (and other "
	"co-located events, such as tutorials) to be affiliated "
	"with ICFP " ,year " and sponsored by "
	(a ((href "http://acm.org/sigplan/")) "SIGPLAN")
	".  "
	"These events should be less formal and focused than ICFP itself, "
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
	(a ((href "http://www.sigplan.org/Resources/Guidelines/Workshops"))
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

(define google-map-hotel
  `[(iframe ((width "550")
             (height "500")
             (frameborder "0")
             (scrolling "no")
             (marginheight "0")
             (marginwidth "0")
             (src "https://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=Hilton+Boston+Logan+Airport,+1+Hotel+Drive,+Boston,+MA&aq=0&oq=hilton+boston+logan+ai&sll=42.367296,-71.023178&sspn=0.122011,0.119305&gl=us&ie=UTF8&hq=Hilton+Boston+Logan+Airport,+1+Hotel+Drive,+Boston,+MA&t=m&ll=42.391769,-71.039658&spn=0.12171,0.219727&z=12&iwloc=A&output=embed")))
    (br)
    (small ()
      (a ((href "https://maps.google.com/maps/ms?msa=0&msid=217204641706693528920.0004db935c721ff3abaec&gl=us&ie=UTF8&t=m&ll=42.367383,-71.023189&spn=0.003805,0.006866&z=17&source=embed"))
           "View Hotel on larger map"))])

(define program.xexpr
  (make-page
   "Program"
   `(div
     ((class "col1"))
     (center
      (h1 "Conference program"))
     (p "The complete program for ICFP and affiliated events is also available as a " (a ((href "program.pdf")) "PDF") " document.")
     (p "The complete proceedings of ICFP 2014 and co-located events are available from the "
	(a ((href "http://dl.acm.org/citation.cfm?id=2628136")) "ACM Digital Library")
	" for free for one year.  A zipped collection of the complete proceedings is also "
	(a ((href "ICFP_2014_emaster.zip")) 
	   "available to download") ".")
     (h2 "Monday, 1 September")
     (dl (dt "8:45-9:00 Opening (General Chair)")
         (dt ((class "keynotetitle")) "9:00-10:00 Keynote (Chair: Manuel Chakravarty)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87643")) "Using Formal Methods to Enable More Secure Vehicles: DARPA's HACMS Program"))
	 (dd ((class "paper")) "Kathleen Fisher (Tufts University)")
         (dt "10:00-10:30 Coffee")
         (dt ((class "session")) "10:30-11:20 Session 1: Domain Specific Languages I (Chair: Anil Madhavapedd)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87644")) (em "Building Embedded Systems with Embedded DSLs (Experience Report)")) " (" (a ((href "https://www.youtube.com/watch?v=wC2tmo7l5Mc")) "video") ")")
         (dd ((class "paper")) "Patrick Hickey (Galois Inc); Lee Pike (Galois Inc); Trevor Elliott (Galois Inc); James Bielman (Galois Inc); John Launchbury (Galois Inc)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87755")) (em "Concurrent NetCore: From Policies to Pipelines")) " (" (a ((href "https://www.youtube.com/watch?v=f8Ni_D_lNHU")) "video") ")")
         (dd ((class "paper")) "Cole Schlesinger (Princeton University); Michael Greenberg (Princeton University); David Walker (Princeton University)")
         (dt "11:20-11:40 Break")
         (dt ((class "session")) "11:40-12:30 Session 2: Static Analysis (Chair: Ken Friis Larse)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87756")) (em "SeLINQ: Tracking Information Across Application-Database Boundaries")) " (" (a ((href "https://www.youtube.com/watch?v=Z_tJaySvMIc")) "video") ")")
         (dd ((class "paper")) "Daniel Schoepe (Chalmers University of Technology); Daniel Hedin (Chalmers University of Technology); Andrei Sabelfeld (Chalmers University of Technology)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87757")) (em "Type-Based Parametric Analysis of Program Families")) " (" (a ((href "https://www.youtube.com/watch?v=0C4lf39JYs8")) "video") ")")
         (dd ((class "paper")) "Sheng Chen (Oregon State University); Martin Erwig (Oregon State University)")
         (dt "12:30-14:00 Lunch")
         (dt ((class "session")) "14:00-14:50 Session 3: Binding Structure (Chair: Tarmo Uustal)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87758")) (em "Romeo: A System for More Flexible Binding-Safe Programming")) " (" (a ((href "https://www.youtube.com/watch?v=k9W7_Vjyz4g")) "video") ")")
         (dd ((class "paper")) "Paul Stansifer (Northeastern University);Mitchell Wand (Northeastern University)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87759")) (em "Maximal Sharing in the Lambda Calculus with letrec")) " (" (a ((href "https://www.youtube.com/watch?v=sxy-81ZPYOE")) "video") ")")
         (dd ((class "paper")) "Clemens Grabmayer (VU University Amsterdam); Jan Rochel (Universiteit Utrecht)")
	 (dt "14:50-15:10 Break")
         (dt ((class "session")) "15:10-16:00 Session 4: Program Optimisation (Chair: John Launchbury)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87750")) (em "Practical and Effective Higher-Order Optimizations")) " (" (a ((href "https://www.youtube.com/watch?v=dXrs4BB34Z4")) "video") ")")
	 (dd ((class "paper")) "Lars Bergstrom (Mozilla Research); Matthew Fluet (Rochester Institute of Technology); John Reppy University of Chicago); Nora Sandler (University of Chicago); Matthew Le (Rochester Institute of Technology)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87751")) (em "Worker/Wrapper/Makes It/Faster")) " (" (a ((href "https://www.youtube.com/watch?v=9Nm8sSRjAtM")) "video") ")")
	 (dd ((class "paper")) "Jennifer Hackett (University of Nottingham); Graham Hutton (University of Nottingham)")
	 (dt "16:00-16:30 Tea")
	 (dt ((class "session")) "16:30-17:20 Session 5: Context Dependence (Chair: Yukiyoshi Kameyama)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87752")) (em "Compositional Semantics for Composable Continuations: From Abortive to Delimited Control")) " (" (a ((href "https://www.youtube.com/watch?v=uMQ7Co7OMQU")) "video") ")")
	 (dd ((class "paper")) "Paul Downen (University of Oregon); Zena M. Ariola (University of Oregon)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87753")) (em "Coeffects: A Calculus of Context-Dependent Computation")) " (" (a ((href "https://www.youtube.com/watch?v=xtxx4iADMbM")) "video") ")")
	 (dd ((class "paper")) "Tomas Petricek (University of Cambridge); Dominic Orchard (University of Cambridge); Alan Mycroft (University of Cambridge)")
	 (dt "17:20-17:45 Program Chair's Report (" (a ((href "https://www.youtube.com/watch?v=-jmM7hFOw_w")) "video") ")")
	 (dt "17:45-19:30 Welcome reception")
	 (dd "Immediately after the scientic program on Monday, the City of Gothenburg will host a welcome
reception in the H lounge, just outside the ICFP lecture room."))

     (h2 "Tuesday, 2 September")
     (dl (dt ((class "keynotetitle")) "9:00-10:00 Keynote (Chair: Jesse Tov)")
         (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87754")) "Behavioral Software Contracts") " (" (a ((href "https://www.youtube.com/watch?v=gXTbMPVFP1M")) "video") ")")
	 (dd ((class "paper")) "Robert Bruce Findler (Northwestern University)")
	 (dt "10:00-10:30 Coffee")
	 (dt ((class "session")) "10:30-11:20 Session 6: Contracts " amp " Scheme (Chair: Michael Sperber)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87765")) (em "Soft Contract Verification")) " (" (a ((href "https://www.youtube.com/watch?v=o2VE4WwW6sA")) "video") ")")
	 (dd ((class "paper")) "Phuc C. Nguyen (University of Maryland); Sam Tobin-Hochstadt (Indiana University); David Van Horn (University of Maryland)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87766")) (em "On Teaching " (bold "How to Design Programs") ": Observations from a Newcomer")) " (" (a ((href "https://www.youtube.com/watch?v=Ae7g73jM4J4")) "video") ")")
	 (dd ((class "paper")) "Norman Ramsey (Tufts University)")
	 (dt "11:20-11:40 Break")
	 (dt ((class "session")) "11:40-12:30 Session 7: Tools Used in Anger (Chair: Jacques Garrigue)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87767")) (em "SML# in Industry: A Practical ERP System Development (Experience Report)")) " (" (a ((href "https://www.youtube.com/watch?v=IYGtWJc0do0")) "video") ")")
         (dd ((class "paper")) "Atsushi Ohori (Tohoku University); Katsuhiro Ueno (Tohoku University); Kazunori Hoshi (NEC Software Tohoku, Ltd.); Shinji Nozaki (NEC Software Tohoku, Ltd.); Takashi Sato (NEC Software Tohoku, Ltd.); Tasuku Makabe (NEC Software Tohoku, Ltd.); Yuki Ito (NEC Software Tohoku, Ltd.)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87768")) (em "Lem: Reusable Engineering of Real-World Semantics")) " (" (a ((href "https://www.youtube.com/watch?v=2h3IFJCWm2s")) "video") ")")
	 (dd ((class "paper")) "Dominic P. Mulligan (University of Cambridge); Scott Owens (University of Kent); Kathryn E. Gray (University of Cambridge); Tom Ridge (University of Leicester); Peter Sewell (University of Cambridge)")
	 (dt "12:30-14:00 Lunch")
	 (dt ((class "session")) "14:00 Session 8: Type Systems (Chair: Geoffrey Mainland)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87769")) (em "Safe Zero-Cost Coercions for Haskell")) " (" (a ((href "https://www.youtube.com/watch?v=xFy_8n_HdI4")) "video") ")")
	 (dd ((class "paper")) "Joachim Breitner (Karlsruhe Institute of Technology); Richard A. Eisenberg (University of Pennsylvania); Simon Peyton Jones (Microsoft Research); Stephanie Weirich (University of Pennsylvania)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87760")) (em "Hindley-Milner Elaboration in Applicative Style (Functional Pearl)")) " (" (a ((href "https://www.youtube.com/watch?v=8b79M4Nmh34")) "video") ")")
	 (dd ((class "paper")) "Francois Pottier (INRIA)")
	 (dt "14:50-15:10 Break")
	 (dt ((class "session")) "15:10-16:00 Session 9: Incremental Computing (Chair: Tiark Rompf)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87761")) (em "Settable and Non-Interfering Signal Functions for FRP")) " (" (a ((href "https://www.youtube.com/watch?v=zgNRM8tZguY")) "video") ")")
	 (dd ((class "paper")) "Daniel Winograd-Cort (Yale University); Paul Hudak (Yale University)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87762")) (em "Functional Programming for Dynamic and Large Data with Self-Adjusting Computation")) " (" (a ((href "https://www.youtube.com/watch?v=tv2uf22-R_c")) "video") ")")
	 (dd ((class "paper")) "Yan Chen (Max Planck Institute for Software Systems); Umut Acar (Carnegie Mellon University); Kanat Tangwongsan (Mahidol University)")
	 (dt "16:00-16:30 Tea")
	 (dt "16:30-17:10 ICFP Contest Presentation (" (a ((href "https://www.youtube.com/watch?v=wIuFFU8T0kI")) "video") ")")
	 (dt "17:10-17:30 ICFP 2004 Most Influential Paper Award (" (a ((href "https://www.youtube.com/watch?v=eQeW3vdcQVw")) "video") ")")
	 (dt "20:00-late Banquet")
	 (dd "The conference banquet takes place in Eriksbergshallen, on the north bank of the river. The building
used to house the mechanical workshops of Eriksbergsvarvet, one of the main shipyards in Gothenburg
in the 19th and 20th centuries. Buses will leave the conference centre at 19:00 to take participants to the banquet venue.
Buses also take participants back to the city centre/conference venue after the banquet."))
     (h2 "Wednesday, 3 September")
     (dl (dt ((class "keynotetitle")) "9:00-10:00 Keynote (Chair: Edwin Brady)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87763")) "Depending on Types"))
	 (dd ((class "paper")) "Stephanie Weirich (University of Pennsylvania)")
	 (dt "10:00-10:30 Coffee")
	 (dt ((class "session")) "10:30-11:20 Session 10: Homotopy Type Theory (Chair: Derek Dreyer)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87764")) (em "Homotopical Patch Theory")))
	 (dd ((class "paper")) "Carlo Angiuli (Carnegie Mellon University); Ed Morehouse (Carnegie Mellon University); Daniel Licata (Wesleyan University); Robert Harper (Carnegie Mellon University)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87775")) (em "Pattern Matching without K")))
	 (dd ((class "paper")) "Jesper Cockx (KU Leuven); Dominique Devriese (KU Leuven); Frank Piessens (KU Leuven)")
	 (dt "11:20-11:40 Break")
	 (dt ((class "session")) "11:40-12:30 Session 11: Abstract Interpretation (Chair: Patricia Johann)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87776")) (em "Refinement Types For Haskell")))
	 (dd ((class "paper")) "Niki Vazou (UC San Diego); Eric L. Seidel (UC San Diego); Ranjit Jhala (UC San Diego); Dimitrios Vytiniotis (Microsoft Research); Simon Peyton-Jones (Microsoft Research)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87777")) (em "A Theory of Gradual Effect Systems")))
	 (dd ((class "paper")) "Felipe Ba" ntilde "ados Schwerter (University of Chile); Ronald Garcia (University of British Columbia); " Eacute "ric Tanter (University of Chile)")
	 (dt "12:30-14:00 Lunch")
	 (dt ((class "session")) "14:00-14:50 Session 12: Dependent Types (Chair: Ulf Norell)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87778")) (em "How to Keep Your Neighbours in Order")) " (" (a ((href "https://www.youtube.com/watch?v=pNBPCnZEdSs")) "video") ")")
	 (dd ((class "paper")) "Conor McBride (University of Strathclyde)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87779")) (em "A Relational Framework for Higher-Order Shape Analysis")) " (" (a ((href "https://www.youtube.com/watch?v=SOjvCx2ZjWA")) "video") ")")
	 (dd ((class "paper")) "Gowtham Kaki (Purdue); Suresh Jagannathan (Purdue)")
	 (dt "14:50-15:10 Break")
	 (dt ((class "session")) "15:10-16:00 Session 13: Domain Specific Languages II (Chair: Yaron Minsky)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87770")) (em "There is no Fork: an Abstraction for Efficient, Concurrent, and Concise Data Access")) " (" (a ((href "https://www.youtube.com/watch?v=jG9PWdV1wso")) "video") ")")
	 (dd ((class "paper")) "Simon Marlow (Facebook); Louis Brandy (Facebook); Jonathan Coens (Facebook); Jon Purdy (Facebook)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87771")) (em "Folding Domain-Specific Languages: Deep and Shallow Embeddings (Functional Pearl)") " (" (a ((href "https://www.youtube.com/watch?v=xS7TJrrhYe8")) "video") ")"))
	 (dd ((class "paper")) "Jeremy Gibbons (University of Oxford); Nicolas Wu (University of Oxford)")
	 (dt "16:00-16:30 Tea")
	 (dt ((class "session")) "16:30-17:20 Session 14: Abstract Machines (Chair: David Van Horn)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87772")) (em "Krivine Nets")) " (" (a ((href "https://www.youtube.com/watch?v=qmwINAgdFVc")) "video") ")")
	 (dd ((class "paper")) "Olle Fredriksson (University of Birmingham); Dan Ghica (University of Birmingham)")
	 (dt ((class "paper")) (a ((href "http://dl.acm.org/authorize?N87773")) (em "Distilling Abstract Machines")) " (" (a ((href "https://www.youtube.com/watch?v=3k9UlpgXt0M")) "video") ")")
	 (dd ((class "paper")) "Beniamino Accattoli (University of Bologna); Pablo Barenbaum (University of Buenos Aires); Damiano Mazza (Universit" eacute " Paris 13)")
	 (dt "17:20-17:40 Student Research Competition Award Presentation (" (a ((href "https://www.youtube.com/watch?v=ZlfYhlUlVG0")) "video") ")")
	 (dt "17:40-18:00 ICFP 2015 Advert & Closing (" (a ((href "https://www.youtube.com/watch?v=LhLQA25_1yQ")) "video") ")"))
     (h2 "Thursday, 4 September")
     (dl (dt "18:30-20:30 Industrial reception")
	 (dd "The industrial reception, supported by our platinum and gold sponsors, takes place at the Museum of
World Culture, a 200 m walk from the conference venue.")))))

(define local.xexpr
  (make-page 
   "Local information"	     
   `(div
     ((class "col1"))
     (center
      (h1 "Local information"))
     (h2 "Conference venue")
     (p "The conference will take place at the " 
        (a ((href "http://www.svenskamassan.se/en/")) "Swedish Exhibition and Congress Centre") 
        " in central Gothenburg.")

     (p "View "
	(a ((href "https://maps.google.se/maps/ms?msa=0&msid=210997146033221229789.0004ef75436b30b7dddf6&ie=UTF8&t=m&ll=57.698369,11.978016&spn=0.032106,0.073128&z=13&source=embed"))
	   "ICFP2014 locations")
	" in a larger map.")

     (h2 "Support from the SIGPLAN Professional Activities Committee")
     (p "The " (a ((href "http://www.sigplan.org/PAC.htm")) "SIGPLAN Professional Activities Committee") " can potentially provide supplemental financial "
        "support for attending ICFP in the form of student grants, child-care support, companion travel "
        "grants, and long-distance internation travel support. "
        "To apply, follow the instructions found " (a ((href "http://www.sigplan.org/PAC.htm")) "here") ".")

     (h2 "Getting to the venue")
     (p (ul (li "If you arrive to Gothenburg Landvetter Airport (GOT; all airlines except
    Ryanair and Wizz air), take the airport coach and get off at the first stop
    (Korsv" auml "gen), which is immediately outside the conference venue. The bus ride
    takes 20 minutes. Tickets cost 99 SEK and can be bought on the bus using a
    credit card; cash is not accepted. Tickets can also be bought online in
    advance; see the " (a ((href "http://www.flygbussarna.se/en/landvetter")) "airport bus website") 
    " where also a timetable can be
    found. Buses leave every 20 minutes between 6AM (10AM on weeekends) and 8PM;
    less frequent at other times.")
	    (li "If you arrive by train, car or to Gothenburg City Airport (GSE; Ryanair and
    Wizz air), see directions "
		(a ((href "http://www.svenskamassan.se/en/for-visitors/getting-here")) "here")
		".")))

     (h2 "Accommodation")
     (p "We have made block reservations at four hotels. Prices below are per night and 
include buffet breakfast, wireless internet access and VAT."
	(ul (li (a ((href "http://www.gothiatowers.com/?lang=en")) "Hotel Gothia Towers") ". This hotel is
    part of the conference venue, and thus the most convenient alternative.
    Single room SEK 1495, double room SEK 1695. Booking code ICF310814; book via phone (+46 31 750 88 10) or hotel web site.")
	    (li (a ((href "http://www.scandichotels.com/Hotels/Sweden/Gothenburg/Scandic-Opalen")) "Hotel Scandic Opalen") ".
    Located 500 m from the conference venue. Single room SEK 1290/1390. Booking code BCHA310814; book via phone (+46 31 751 5300) or hotel web site.")
	    (li (a ((href "https://www.nordicchoicehotels.com/quality/quality-hotel-panorama1")) "Quality Hotel Panorama") ".
    Located 900 m from the conference venue. Single room SEK 935, double room
    SEK 1159. Booking code 247400; book via phone (+46 31 767 70 00) or mail to " (a ((href "mailto:reservation.q.panorama@choice.se")) "reservation.q.panorama@choice.se") ".")
	    (li (a ((href "http://book.bestwestern.com/bestwestern/SE/Gothenburg-hotels/BEST-WESTERN-Hotell-Goteborg/Hotel-Overview.do?propertyCode=88162")) "Best Western Hotel G" ouml "teborg") ".
    Located ca 2 km from the conference venue. Single room SEK 734, double room
    SEK 935. Booking code ICFP 2014; book via phone (+46 31 752 2800) or mail to " (a ((href "mailto:info@hotellgoteborg.se")) "info@hotellgoteborg.se") ".")))

     (p "Hotel booking is open. 
Some rooms in all four hotels stay reserved for ICFP
participants until August 1st, but there are also checkpoints for the number of reserved rooms
3 and 2 months before the conference, when some unused reservations will be
cancelled. Early September is a busy period for
hotels in Gothenburg, so we recommend you to book early. Note also
that it may actually be possible to get better rates through other booking sites.")
     (p "There are many more hotels and hostels in Gothenburg that you might want to 
explore. One suitable starting point is " (a ((href "http://www.goteborg.com/en/Stay/Stay-Startpage/")) "here") ".")

     (h2 "About Gothenburg")
     (p "Gothenburg is Sweden's second city, with a population of half
a million in the city and almost a million in the greater Gothenburg
area. For tourist information about Gothenburg, including information
about accommodation, restaurants, shopping, sights, history and more,
visit " (a ((href "http://www.goteborg.com/en/")) "goteborg.com") ".")

     (p "There are two universities in Gothenburg, " (a ((href "http://www.gu.se/english")) "University of
Gothenburg") " and " (a ((href "http://www.chalmers.se/en")) "Chalmers University of
Technology") ". The " (a ((href "http://www.chalmers.se/cse/EN/")) "Department of Computer
Science and Engineering") " is shared
between the two universities.")

     (p "The public transportation system includes trams, buses and
ferries, with a common ticket system. Ticket options include single
tickets, 1 and 3 day passes, and pay-as-you-go cards. The driver does
not sell tickets, but on trams (not buses) there is a ticket machine
that accepts credit cards. Tickets can be bought at various retailers
around town e.g. Tidpunkten, Pressbyr" aring "n, 7-Eleven or from any
other store or shop displaying the V" aring "sttrafik sign. For more
information and a travel planner, visit the " (a ((href
"http://www.vasttrafik.se/#!/en/")) "v" aring "sttrafik web site")
".")

     (p "There is a shared " (a ((href "http://en.goteborgbikes.se")) "bike system") " with around 1000 
bikes at more than 70 stations around the city, including one outside the 
conference venue. Three day passes are available.")

     (p "Weather in early September in Gothenburg is highly variable. It can be sunny 
with temperatures above 20" deg " C, but it can also be cooler with wind and rain.")


     (h2 "Other useful information")

     (dl
      (dt "Restaurants.")
      (dd (p "A list of recommended restaurants and pubs in Gothenburg (selected by local FP people) with locations on  a Google map is "
          (a ((href "https://docs.google.com/document/d/1sSpFqxqvq77MmGb1Nby36f8A4ncAKhTpwS_GLLOK6XA/edit")) "here") "."))

      (dt "Banks and currency.")
      (dd (p "Banks are open between 09.30/10.00 and 15.00 on
    weekdays. Some banks in central Gothenburg are open from 09.00 to 17.00.")

	  (p "The Swedish currency is the krona, with USD 1 = SEK 6.50
    and EUR 1 = SEK 8.80 (January 2014). For current exchange rates
    click " (a ((href
    "http://www.x-rates.com/table/?from=SEK&amount=1")) "here")
    ". Currency exchange offices can be found at Landvetter airport
    (International), at the central station and in Kungsportsavenyn,
    among other places. Cash machines (ATM's), called Bankomat, are
    common and accept credit and debit cards. They can be found in the
    main shopping centres, the airport and in the main streets."))

      (dt "Credit cards.")
      (dd "MasterCard and VISA cards are accepted almost everywhere,
    including shops, hotels, restaurants and taxis. The chip and pin is the
    common method. It is advisable to carry an identity card or some form of
    photo identification.")

      (dt "Election")
      (dd "The ICFP week is in the most intensive period of election
    campaign before the general elections (to the national parliament, but also
    regional and local bodies) that take place in Sweden on Sunday, September
    14. This will be very visible in the form of posters and campaign speeches
    in public places, and TV debates throughout the week.")

      (dt "Electricity.")
      (dd "Electrical voltage in Sweden is 220 V/50 Hz. Round,
    European-style two-pin plugs (Schuko, CEE 7/4) are used. Appliances designed
    to operate on 110/120 Volts need a voltage converter and a plug adapter.")

      (dt "Emergency phone number.")
      (dd "To call ambulance, police or fire brigade, simply
    call 112. No area code is needed, regardless of what phone you're using. The
    number works on any mobile phone, with or without a SIM card, even if it's
    locked.")

      (dt "Health care and insurance.")
      (dd "Ensure coverage by your own health insurance
    and bring necessary documents. Citizens from EU/EEA countries and some other
    countries, with which Sweden has a special agreement, are entitled to the
    same medical services as Swedes. Citizens from North America and other
    countries outside the EU/EEA must pay in full for medical treatment.")

      (dt "Dentist.")
      (dd "For urgent dental care, call the Emergency Dental Care.
    Mon-Fri 08:00-20:00, Sat-Sun 08:00-16:00.
    Tel: +46 (0)31-80 78 00.")

      (dt "Medical treatment.")
      (dd "Different options include the following."
	  (ul
	   (li "Phone the Medical Information Service (Sjukv" aring "rdsr" aring "dgivningen), tel +46
        1177, 24 hours a day, 7 days a week. Registered nurses give medical
        advice, answer questions on self-care and provide information as to what
        to do should your condition require medical treatment.")

	   (li "For medical treatment during weekdays, drop in or book an appointment at
        Specialistkliniken Heden, Engelbrektsgatan 59
        Mon-Thu 08:00-17:00
        Tel: +46 (0)31-20 82 20")

	   (li "During evenings and weekends, drop in at
        Jourcentral Gamlestadstorget, Gamlestadsvägen 4 B:15
        Mon-Fri 17:00-22:00, Sat-Sun 10:00-22:00
        Tel: +46 (0)31-345 07 53")

	   (li "Should you suddenly become very ill or seriously injured, make your way
        to the Casualty ward (Akutmottagningen) at Sahlgrenska sjukhuset
        (Sahlgrenska Hospital), open 24 hours a day, or phone the emergency
        number 112.")))

      (dt "Shopping.")
      (dd (p "Most shops are open between 10:00 and 18:00; on weekends until
    14:00. Department stores are open until 19:00 or longer on weekdays. Most
    are also open on Sundays between noon and 16:00. VAT is always included on
    the price tag.")

	  (p "Non-EU residents are entitled to a VAT refund on all purchases (min SEK 200)
    made in Sweden. " (a ((href "http://www.globalblue.com/destinations/sweden/tax-free-shopping-in-sweden/")) "Tax Free Shopping by Global Blue")
    " is a simple system that puts cash in your hand when you leave the EU. You
    get refunds of up to 19% on your purchases."))

      (dt "Visas.")
      (dd "Participants needing a visa for entry to Sweden are strongly
    advised to make their application in their home country and well in advance.
    If in doubt, information can be obtained from your nearest Swedish Embassy
    or consulate, or from your travel agency."))

     (h2 "VISA information")
     (p "The Association for Computing
Machinery " (a ((href "http://www.acm.org/sigs/volunteer_resources/conference_manual/visas")) "does
not issue formal invitation letters for visas") " to attend ACM
sponsored conferences. We can however issue a visa support letter. For
Visa support letters, please send all requests to the Office of SIG
Services supportletters@acm.org with the following information:")

     (p "Your name as it appears on your passport. Current postal mailing
address. The name of the conference you wish to attend. Your
Registration Confirmation Number. If you have any papers accepted for
the conference, please provide the title and indicate whether you are
the 'sole author' or a 'co- author'. Please note visa support letters
are issued via email by PDF and the original is mailed to your current
postal address."))))

(define student-attendance.xexpr
  (make-page 
   "Student Attendance Program"	     
   `(div
     ((class "col1"))
     (center
      (h1 "Student Attendance Programs"))
     (h2 "Student Support")
     (p "There are several ways that students may receive support for participation at the conference.")
     (dl
      (dt (b "Volunteering"))
      (dd "ICFP is pleased to offer a number of opportunities for "
	  (a ((href "sv.html")) "student volunteers")
	  ", who are vital to the efficient operation and "
	  "continued success of the conference each year. The student volunteer "
	  "program is a chance for students from around the world to participate "
	  "in the conferences whilst assisting us in preparing and running the "
	  "event.  Free registration, meals and banquet ticket will be "
	  "provided.")
      (dt (b "The ACM Student Research Competition, Sponsored by Microsoft"))
      (dd "Support will be provided for Students wishing to enter the "
	  "competition. For more information on the Competition and how to apply, "
	  "follow the instruction found " 
	  (a ((href "src.html")) "here") ".")
      (dt (b "The SIGPLAN Professional Activities Committee (PAC Fund)"))
      (dd "The SIGPLAN Professional Activities Committee provide "
	  "supplemental financial support for attending ICFP in the form of "
	  "student grants, child-care support, companion travel grants and long "
	  "distance international travel support.  To apply, follow the "
	  "instructions found " 
	  (a ((href "http://www.sigplan.org/PAC.htm")) "here") ".")
      (dt (b "ACM-W Scholarships for Attendance at Research Conferences"))
      (dd "ACM-W provides " (a ((href "http://women.acm.org/scholarship")) "support")
	  " for women undergraduate and graduate students "
	  "in Computer Science and related programs to attend research conferences.")))))

(define src.xexpr
  (make-page
   "Student Research Competition"
   `(div
     ((class "col1"))
     (center
      (h1 "Student Research Competition"))
     (p "This year ICFP will host a " 
	(emph "Student Research Competition")
	" where undergraduate and postgraduate students can "
	"present posters. The " 
	(a ((href "http://src.acm.org/")) "SRC")
	" at the ICFP 2014 consists of three rounds:"

	(dl (dt (b "Extended abstract round: "))
	    (dd "All students are encouraged to submit an extended "
		"abstract outlining their research (800 words).")
	    (dt (b "Poster session at ICFP 2014:"))
	    (dd "Based on the abstracts, a panel of judges will select "
		"the most promising entrants to participate in the poster session which "
		"will take place at ICFP. Students who make it to this round will be "
		"eligible for some travel support to attend the conference. In the "
		"poster session, students will have the opportunity to present their "
		"work to the judges, who will select three finalists in each "
		"category (graduate/undergraduate) to advance to the next round.")
	    (dt (b "ICFP presentation:"))
	    (dd "The last round will consist of an oral presentation "
		"at the ICFP to compete for the final awards in each "
		"category and selection of an overall winner who will advance to the "
		"ACM SRC Grand Finals.")))
     (h2 "Transport of your poster")
     (p "You can either bring your poster on your own to the "
	"conference or mail it to the local organizers:")
     (p	 "Attn.: Meng Wang" (br)
	 "Chalmers University of Technology" (br)
	 "Department of Computer Science and Engineering" (br)
	 "SE-412 96 G" ouml "teborg, Sweden")
     (p "If you choose to mail, please make sure that the poster will "
	"arrive at the latest on 30th August 2014.")
     (h2 "Prizes")
     (ul
      (li "Both the top three graduate and the top three "
	  "undergraduate winners will receive prizes of $500, $300, "
	  "and $200, respectively.")
      (li "All six winners will receive award medals and a two-year "
	  "complimentary ACM student membership, including a subscription to "
	  "ACM's Digital Library.")
      (li "The names of the winners will be posted on the SRC web site.")
      (li "The overall first place winner of the SRC will be invited to participate "
	  "in the ACM SRC Grand Finals, an on-line round of competitions among "
	  "the winners of other conference-hosted SRCs.")
      (li "Grand Finalists and their advisors will be invited to the "
	  "Annual ACM Awards Banquet for an all-expenses-paid trip, where they "
	  "will be recognized for their accomplishments along with other "
	  "prestigious ACM award winners, including the winner of the Turing "
	  "Award (also known as the Nobel Prize of Computing).")
      (li "The top three Grand Finalists will receive an "
	  "additional $500, $300, and $200.  All "
	  "Grand Finalists will receive Grand Finalist certificates.")
      (li "The ACM, Microsoft Research, and our industrial partners "
	  "provide financial support for students attending the SRC. You can find "
	  "more information about this on the "
	  (a ((href "http://src.acm.org/students.html")) "ACM website") 
	  "."))
     (h2 "Eligibility")
     (p "The SRC is open to both undergraduate (not in a PhD program) "
	"and graduate students (in a PhD program). Upon submission, entrants "
	"must be enrolled as a student at their universities, and are ACM "
	"student members.")
     (p "Furthermore, there are some constraints on what kind of work may be submitted.")
     (dl (dt (b "Previously published work:"))
	 (dd "Submissions should consist of original work (not yet "
	     "accepted for publication). If the work is a continuation of previously "
	     "published work, the submission should focus on the contribution over "
	     "what has already been published. We encourage students to see this as "
	     "an opportunity to get early feedback and exposure for the work they "
	     "plan to submit to the next ICFP or POPL.")
	 (dt (b "Collaborative work:"))
	 (dd "Students are encouraged to submit work they have been "
	     "conducting in collaboration with others, including advisors, "
	     "internship mentors, or other students. However, submissions are "
	     "individual, so they must focus on the contributions of the student."))
     (h2 "Submission Details")
     (p "Each submission should include the student author's name, "
	"institutional affiliation, e-mail address, and postal address; "
	"research advisor's name; ACM student member number; "
	"category (undergraduate or graduate); research title; and an extended "
	"abstract addressing the following:")
     (ul
      (li "Problem and Motivation: Clearly state the problem being "
	  "addressed and explain the reasons for seeking a solution to this "
	  "problem.")
      (li "Background and Related Work: Describe the "
	  "specialized (but pertinent) background necessary to appreciate the "
	  "work. Include references to the literature where appropriate, and "
	  "briefly explain where your work departs from that done by others.")
      (li "Approach and Uniqueness: Describe your approach in "
	  "attacking the problem and clearly state how your approach is novel.")
      (li "Results and Contributions: Clearly show how the results "
	  "of your work contribute to computer science and explain the "
	  "significance of those results."))
     (p "The abstract must describe the student's individual research "
	"and must be authored solely by the student. If the work is "
	"collaborative with others and/or part of a larger group project, the "
	"abstract should make clear what the student's role was and should "
	"focus on that portion of the work. The extended abstract must not "
	"exceed 800 words and must not be longer than 2 pages. The reference "
	"list does not count towards these limits. To submit an abstract, "
	"please register through the " 
	(a ((href "https://www.easychair.org/conferences/?conf=icfp2014src")) "submission page") 
	" and follow the "
	"instructions. Abstracts submitted after the deadline may be considered "
	"at the committee's discretion, but only after decisions have been made "
	"on all abstracts submitted before the deadline. If you have any "
	"problems, don't hesitate to contact the competition chair. ")
     (h2 "Important Dates")
     (ul
      (li "Deadline for submission: 29th June")
      (li "Notification of acceptance: 14th July"))
     (h2 "Selection Committee")
     (table
      ,(row "Chair" (get-role 'src))
      ,@(map (lambda (p) (row "" p)) (get-roles 'sr))))))


(define sv.xexpr
  (make-page
   "Student Volunteer Program"
   `(div
     ((class "col1"))
     (center
      (h1 "Student Volunteer Program"))
     (p "Sign up to be a Student Volunteer and help us make ICFP 2014 "
	"a unique experience for all attendants!")
     (p "ICFP is pleased to offer a number of opportunities for "
	"student volunteers, who are vital to the efficient operation and "
	"continued success of the conference each year. The student volunteer "
	"program is a chance for students from around the world to participate "
	"in the conferences whilst assisting us in preparing and running the "
	"event.")
     (p "Job assignments for student volunteers include assisting with "
	"technical sessions, workshops, tutorials and panels, helping the "
	"registration desk, operating the information desk, helping with "
	"traffic flow, and general assistance to keep the conferences running "
	"smoothly.")
     (h2 "Eligibility")
     (p "Applicants can be undergraduate, Master's, Ph.D. full- or "
	"part-time students, of computer science or related fields.")
     (h2 "Location")
     (p "Gothenburg, Sweden.")
     (h2 "Duration")
     (p "Applicants must be available for at least three (3) full days "
	"between 31st of August and the 6th of September 2014 in order to offer "
	"16 hours of volunteering work. Note that we will prioritise students "
	"who will be available the full week. Naturally presentations etc. at "
	"workshops and technical sessions take precedence.")
     (h2 "Compensation")
     (ul
      (li "A Complimentary Conference Registration, offering access "
	  "to all open sessions (i.e., parallel paper presentations, "
	  "demonstrations, and workshops) and conference proceedings.")
      (li "Free lunches and refreshments during breaks.")
      (li "Free conference banquet ticket.")
      (li "An ICFP 2014 Student Volunteers T-shirt.")
      (li "Please note that ICFP 2014 Student Volunteers are "
	  "responsible for their own travel arrangements and accommodation. The "
	  "conference organisers will do their best to provide affordable "
	  "accommodation for student volunteers, for example in student housing."))
     (h2 "Important Dates")
     (p "Application Deadline:    15th June 2014")
     (p "Initial Acceptance and Reserve List announcement:    30th June 2014")
     (h2 "About volunteering")
     (p "The ICFP 2014 Program for Student Volunteers gives full- or "
	"part-time university students from around the world the opportunity to "
	"attend and contribute to premier international conference covering all "
	"areas of design implementation, principles and uses of functional "
	"programming. As an ICFP 2014 Student Volunteer, you will interact "
	"closely with researchers, academics and developers from various "
	"disciplines and meet other students from around the world. The skills, "
	"talents and dedication of the Student Volunteers contribute to the "
	"overall quality of the Conference. The Student Volunteer role involves "
	"a range of duties, including, but not limited to:"
	(ul
	 (li "Providing assistance to the Conference management and Registration staff.")
	 (li "Helping and directing other Conference participants.")
	 (li "Contributing to the overall smooth running of the "
	     "Conference functions and social events. This also includes assisting "
	     "during presentations and poster sessions as well as manning the "
	     "information and registration desks.")))
     (h2 "Qualifications")
     (p "A Student Volunteer should:"
	(ul
	 (li "Be enthusiastic and highly motivated, with strong interpersonal skills,")
	 (li "Be fluent in English, which is the language of the conference,")
	 (li "Be reliable, punctual and organized,")
	 (li "Be a self-starter.")))
     (h2 "How to apply")
     (p "To be considered as a Student Volunteer for the ICFP 2014 "
	"Conference, you need to send an email to Ramona Enache "
	(a ((href "mailto:icfp-sv@lambda-calcul.us")) "icfp-sv@lambda-calcul.us")
	" with the following information: "
	(ul
	 (li "Your full name.")
	 (li "Your email address.")
	 (li "Your program of study, current status and year in "
	     "the cycle, and current affiliation (university and/or laboratory).")
	 (li "Contact information to your supervisor or director of "
	     "study (name and email address).")
	 (li "Special Food requirements (i.e Vegetarian, vegan, food "
	     "allergies etc).")
	 (li "Date(s) you are available to work (preferably the entire week).")
	 (li "A short description of yourself and your motivation for attending ICFP 2014.")))
     (h2 "Acceptance notification")
     (p "All applications received by June 15th, 2014 will be "
	"reviewed and volunteers selected will be notified by June 30th, "
	"2014. A reserve list will also be drawn up upon applications received "
	"by the preliminary registration deadline, but not initially selected.")
     (h2 "Enquiries")
     (p "If you have any questions, please send them via email to "
	(a ((href "mailto:icfp-sv@lambda-calcul.us")) "Ramona Enache")
	". We are looking forward to receiving your "
	"application and seeing you at ICFP 2014!"))))


(define accepted.xexpr
  (make-page
    "Accepted papers"
    `(div
      ((class "col1"))
      (center
       (h1 "Accepted papers"))

      (dl
       (dt "On Teaching *How to Design Programs*: Observations from a Newcomer")
       (dd (a ((href "http://www.cs.tufts.edu/~nr")) "Norman Ramsey"))
       
       (dt "Folding Domain-Specific Languages: Deep and Shallow Embeddings")
       (dd (a ((href "http://www.cs.ox.ac.uk/jeremy.gibbons/")) "Jeremy Gibbons")
	   " and "
	   (a ((href "http://www.cs.ox.ac.uk/people/nicolas.wu/")) "Nicolas Wu"))
       
       (dt "Pattern matching without K")
       (dd "Jesper Cockx, Dominique Devriese and Frank Piessens")

       (dt "Settable and Non-Interfering Signal Functions for FRP")
       (dd "Daniel Winograd-Cort and Paul Hudak")

       (dt "Safe Zero-cost Coercions for Haskell")
       (dd (a ((href "http://www.joachim-breitner.de/")) "Joachim Breitner")
	   ", "
	   (a ((href "http://www.cis.upenn.edu/~eir/")) "Richard A. Eisenberg")
	   ", "
	   (a ((href "http://research.microsoft.com/en-us/people/simonpj/")) "Simon Peyton Jones")
	   " and "
	   (a ((href "http://www.seas.upenn.edu/~sweirich")) "Stephanie Weirich"))

       (dt "Worker/Wrapper/Makes It/Faster")
       (dd (a ((href "http://www.cs.nott.ac.uk/~jph/")) "Jennifer Hackett")
	   " and "
	   (a ((href "http://www.cs.nott.ac.uk/~gmh/")) "Graham Hutton"))

       (dt "Lem: reusable engineering of real-world semantics")
       (dd "Dominic P. Mulligan, Scott Owens, Kathryn E. Gray, Tom Ridge and "
	   (a ((href "http://www.cl.cam.ac.uk/~pes20")) "Peter Sewell"))

       (dt "There is no Fork: an Abstraction for Efficient, Concurrent, and Concise Data Access")
       (dd "Simon Marlow, Louis Brandy, Jonathan Coens and Jon Purdy")

       (dt "Hindley-Milner elaboration in applicative style")
       (dd (a ((href "http://gallium.inria.fr/~fpottier/")) "Francois Pottier"))

       (dt "Building Embedded Systems with Embedded DSLs")
       (dd (a ((href "http://www.galois.com/")) "Patrick Hickey")
	   ", Lee Pike, Trevor Elliott, James Bielman and John Launchbury")

       (dt "Compositional Semantics for Composable Continuations: From Abortive to Delimited Control")
       (dd (a ((href "http://ix.cs.uoregon.edu/~pdownen")) "Paul Downen")
	   " and "
	   (a ((href "http://ix.cs.uoregon.edu/~ariola")) "Zena Ariola"))

       (dt "Maximal Sharing in the Lambda Calculus with letrec")
       (dd (a ((href "http://www.few.vu.nl/~cgr600")) "Clemens Grabmayer")
	   " and "
	   (a ((href "http://rochel.info/")) "Jan Rochel"))

       (dt "A Theory of Gradual Effect Systems")
       (dd (a ((href "http://pleiad.cl/people/fbanados")) "Felipe Ba" ntilde "ados Schwerter") 
           ", "
           (a ((href "http://www.cs.ubc.ca/~rxg/")) "Ronald Garcia") 
           " and " 
           (a ((href "http://pleiad.cl/people/etanter")) Eacute "ric Tanter"))

       (dt "Functional Programming for Dynamic and Large Data with Self-Adjusting Computation")
       (dd (a ((href "http://www.mpi-sws.org/~chenyan")) "Yan Chen")
	   ", "
	   (a ((href "http://www.umut-acar.org/")) "Umut A. Acar")
	   " and Kanat Tangwongsan")

       (dt "SeLINQ: Tracking Information Across Application-Database Boundaries")
       (dd "Daniel Schoepe, Daniel Hedin and Andrei Sabelfeld")

       (dt "Krivine Nets")
       (dd (a ((href "http://www.cs.bham.ac.uk/~ohf162/")) "Olle Fredriksson")
	   " and "
	   (a ((href "http://www.cs.bham.ac.uk/~drg")) "Dan R. Ghica"))

       (dt "Practical and Effective Higher-Order Optimizations")
       (dd (a ((href "http://www.lars.com/")) "Lars Bergstrom")
	   ", "
	   (a ((href "http://www.cs.rit.edu/~mtf/")) "Matthew Fluet")
	   ", "
	   (a ((href "http://cs.uchicago.edu/~jhr")) "John Reppy")
	   ", Nora Sandler and Matthew Le")

       (dt "Distilling Abstract Machines")
       (dd (a ((href "https://sites.google.com/site/beniaminoaccattoli/")) "Beniamino Accattoli")
	   ", "
	   "Pablo Barenbaum and "
	   (a ((href "http://lipn.univ-paris13.fr/~mazza/")) "Damiano Mazza"))

       (dt "Type-Based Parametric Analysis of Program Families")
       (dd "Sheng Chen and "
	   (a ((href "http://eecs.oregonstate.edu/~erwig")) "Martin Erwig"))

       (dt "Soft Contract Verification")
       (dd "Phuc Nguyen"
	   ", "
	   (a ((href "http://samth.github.io/")) "Sam Tobin-Hochstadt")
	   " and "
	   (a ((href "http://www.cs.umd.edu/~dvanhorn/")) "David Van Horn"))

       (dt "Concurrent NetCore: From Policies to Pipelines")
       (dd "Cole Schlesinger, Michael Greenberg and David Walker")

       (dt "Homotopical Patch Theory")
       (dd (a ((href "http://cs.cmu.edu/~cangiuli")) "Carlo Angiuli")
	   ", "
	   (a ((href "http://www.cs.cmu.edu/~edmo/")) "Ed Morehouse")
	   ", "
	   (a ((href "http://dlicata.web.wesleyan.edu/")) "Daniel Licata")
	   " and "
	   (a ((href "http://cs.cmu.edu/~rwh")) "Robert Harper"))

       (dt "A Relational Framework for Higher-Order Shape Analysis")
       (dd (a ((href "http://gowthamk.github.io/")) "Gowtham Kaki")
	   " and "
	   (a ((href "https://www.cs.purdue.edu/homes/suresh")) "Suresh Jagannathan"))

       (dt "Coeffects: A calculus of context-dependent computation")
       (dd (a ((href "http://www.cl.cam.ac.uk/~tp322")) "Tomas Petricek")
	   ", "
	   (a ((href "http://dorchard.co.uk/")) "Dominic Orchard")
	   " and "
	   (a ((href "http://www.cl.cam.ac.uk/users/am")) "Alan Mycroft"))

       (dt "Refinement Types For Haskell")
       (dd (a ((href "http://goto.ucsd.edu/~nvazou/")) "Niki Vazou")
	   ", "
	   (a ((href "http://www.eseidel.org/")) "Eric L. Seidel")
	   ", "
	   (a ((href "http://www.cs.ucsd.edu/~rjhala/")) "Ranjit Jhala")
	   ", Dimitrios Vytiniotis and Simon Peyton-Jones")
       
       (dt "Romeo: a system for more flexible binding-safe programming")
       (dd (a ((href "http://www.ccs.neu.edu/home/pauls")) "Paul Stansifer")
	   " and " 
	   (a ((href "http://www.ccs.neu.edu/home/wand")) "Mitchell Wand"))

       (dt "How to Keep Your Neighbours in Order")
       (dd (a ((href "http://www.strictlypositive.org/")) "Conor McBride"))

       (dt "SML# in Industry: A Practical ERP System Development")
       (dd "Atsushi Ohori, Katsuhiro Ueno, Kazunori Hoshi, Shinji Nozaki, Takashi Sato, Tasuku Makabe and Yuki Ito")

       ))))


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
(write-page local.xexpr "local.html")
(write-page student-attendance.xexpr "student-attendance.html")
(write-page src.xexpr "src.html")
(write-page sv.xexpr "sv.html")
(write-page accepted.xexpr "accepted.html")
(write-page program.xexpr "program.html")


