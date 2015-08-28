#lang at-exp racket
(require xml)
;; Role = Symbol | [Listof Symbol]
;; (person Role String String String (U #f String))
(struct person (role first last affil url) #:transparent)

(struct person/email person (email))
(struct person/co person (country))

;; start PC

(define david
  (person/co '(pub pcm sr) "David" "Van Horn" "University of Maryland" "http://www.cs.umd.edu/~dvanhorn/" "USA"))

(define program-committee
  (list
   (person/co 'pcm "Amal" "Ahmed" "Northeastern University" "http://www.ccs.neu.edu/home/amal/" "USA")
   (person/co 'pcm "Jean-Philippe" "Bernardy" "Chalmers University of Technology" "http://www.cse.chalmers.se/~bernardy/" "Sweden")
   (person/co 'pcm "Matthias" "Blume" "Google" "http://research.google.com/pubs/author39313.html" "USA")
   (person/co 'pcm "William" "Byrd" "University of Utah" "http://webyrd.net/" "USA")
   (person/co 'pcm "Andy" "Gill" "University of Kansas" "https://ku-fpg.github.io/people/andygill/" "USA")
   (person/co 'pcm "Neal" "Glew" "Google" "http://glew.org/nglew/" "USA")
   (person/co 'pcm "Fritz" "Henglein" "University of Copenhagen" "http://www.diku.dk/~henglein/" "Denmark")
   (person/co 'pcm "Gabriele" "Keller" "University of New South Wales and NICTA" "http://www.cse.unsw.edu.au/~keller/" "Australia")
   (person/co 'pcm "Andrew" "Kennedy" "Microsoft Research Cambridge" "http://research.microsoft.com/en-us/um/people/akenn/" "UK")
   (person/co 'pcm "Neelakantan" "Krishnaswami" "Birmingham University" "http://www.cs.bham.ac.uk/~krishnan/" "UK")
   (person/co 'pcm "Daan" "Leijen" "Microsoft Research Redmond" "http://research.microsoft.com/en-us/people/daan/" "USA")
   (person/co 'pcm "Keiko" "Nakata" "FireEye Dresden" "http://cs.ioc.ee/~keiko/" "Germany")
   (person/co 'pcm "Mike" "Rainey" "INRIA Rocquencourt" "http://gallium.inria.fr/~rainey/" "France")
   (person/co 'pcm "Andreas" "Rossberg" "Google" "http://www.mpi-sws.org/~rossberg/" "Germany")
   (person/co 'pcm "Manuel" "Serrano" "INRIA Sophia Antipolis" "http://www-sop.inria.fr/members/Manuel.Serrano/" "France")
   (person/co 'pcm "Simon" "Thompson" "University of Kent" "http://www.cs.kent.ac.uk/people/staff/sjt/" "UK")
   david
   (person/co '(pcm sr mentor) "Stephanie" "Weirich" "University of Pennsylvania" "http://www.cis.upenn.edu/~sweirich/" "USA")))

#|
   (person 'pcm "Edwin" "Brady" "University of St Andrews" "http://edwinb.wordpress.com")
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
|#
;; end PC

(define contest-committee
  (list
   (person 'cc "Joe" "Kiniry" "Galois" "http://galois.com/team/joe-kiniry/")))

(define contest-url
  "http://icfpcontest.org/")

(define fisher
  (person/co 'gc "Kathleen" "Fisher" "Tufts University" "http://www.cs.tufts.edu/~kfisher/Kathleen_Fisher/Home.html" "USA"))

(define reppy
  (person/co 'pc "John" "Reppy" "University of Chicago" "http://people.cs.uchicago.edu/~jhr/" "USA"))

(define wu
  (person 'wc "Nicolas" "Wu" "University of Bristol" "http://www.bristol.ac.uk/engineering/departments/computerscience/people/nicolas-wu/index.html"))

#;
(define sam 
  (person 'sr "Sam" "Tobin-Hochstadt" "Indiana University" "http://samth.github.io/"))

(define tom
  (person 'wc "Tom" "Schrijvers" "KU Leuven" "http://people.cs.kuleuven.be/~tom.schrijvers/"))

(define diatchki
  (person 'video "Iavor" "Diatchki" "Galois" #f))

(define jean-baptiste
  (person 'treasurer "Jean-Baptiste" "Tristan" "Oracle Labs" "http://labs.oracle.com/people/tristan"))

(define garcia
  (person '(local mentor) "Ronald" "Garcia" "University of British Columbia" "http://www.cs.ubc.ca/~rxg/"))

(define kennedy
  (person 'src "Andrew" "Kennedy" "Microsoft Research"  "https://research.microsoft.com/en-us/um/people/akenn/"))

(define anil
  (person/email 'industry "Anil" "Madhavapeddy" "University of Cambridge" "http://anil.recoil.org/"
		"anil@recoil.org"))

(define reid
  (person 'mac "Reid" "Holmes" "University of Waterloo" "https://cs.uwaterloo.ca/~rtholmes/"))

(define scherer
  (person 'sv "Gabriel" "Scherer" "INRIA" "http://gallium.inria.fr/~scherer/"))
(define banados-schwerter
  (person 'sv "Felipe" '("Ba" ntilde "ados Schwerter") "University of British Columbia" "http://www.cs.ubc.ca/~fbanados"))

(define unknown
  (person 'unknown "???" "" "???" #f))

(define dreyer
  (person 'sr "Derek" "Dreyer" "MPI-SWS, Saarbrucken" "http://www.mpi-sws.org/~dreyer/"))

(define lindley
  (person 'sr "Sam" "Lindley" "University of Edinburgh" "http://homepages.inf.ed.ac.uk/slindley/"))

(define student-research-committee
  (list kennedy dreyer lindley))
	

(define people
  (set->list
    (apply set
	   (append program-committee
		   contest-committee
		   student-research-committee
		   (list fisher reppy wu tom david diatchki anil garcia kennedy reid scherer banados-schwerter)))))

;; Person Symbol -> Boolean
(define (has-role? p s)
  (define r (person-role p))
  (cond [(symbol? r) (eq? r s)]
        [else (ormap (lambda (r) (eq? r s)) r)]))


;; Person -> String
(define (person-last-normalize p)
  (define l (person-last p))
  (if (string? l)
      l
      (apply string-append 
	     (map (lambda (s)
		    (case s
		      [(ntilde) "n"]
		      [else s]))
		  l))))


;; Role -> [Listof Person]
(define (get-roles r)
  (sort (filter (λ (p) (has-role? p r)) people)
        string-ci<?
        #:key person-last-normalize))

;; Role -> Person
(define (get-role r)
  (match (get-roles r)
    [(list p) p]
    [(list) unknown]
    [_ (error 'get-role "Multiple roles")]))

;; Still need: 'industry 'local 'contest 'src

(define www "icfp2015/")
(define year "2015")
(define nth "20th")
(define city-img "img/vancouver4.jpg")
(define city '("Vancouver, British Columbia, Canada"))
(define dates '("August 31 " ndash " September 2"))
(define affiliated-dates '("August 30 and September 3 " ndash " 5"))
(define cfwp-deadline "November 16, 2014")
(define cfwp-notification "December 15, 2014")
(define workshop-domain "cs.kuleuven.be")

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
  (row/co desc p #f))

(define (row/co desc p person-country)
  `(tr
    (td ((align "left")) ,desc ,@(if (string=? desc "") '() '(":")))
    (td ((align "left"))
        ,@(person-link p))
    (td ((align "left"))
        ,@(local [(define affil (person-affil p))]
	    (append (if (cons? affil) affil (list affil))
                    (if person-country (list " (" (person-country p) ")") '()))))))


(define (role-row desc r)
  (row desc (get-role r)))

(define (role-row/co desc r)
  (row/co desc (get-role r) person/co-country))


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
    (img ((class "logo") (src "img/icfp2015-logo.png"))) (br)
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
          (href "https://regmaster4.com/2015conf/ICFP15/register.php"))
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
          (href "cfp.html"))
         "Call for papers"))
 
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "student-attendance.html"))
         "Student Attendance Programs"))
    
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
          (href "http://www.icfpconference.org/"))
         "More about ICFP"))

     (li ((class "roomy"))
	 (a ((class "navigation")
	     (href "https://twitter.com/icfp_conference"))
	    "@icfp_conference"))
     
     (li
      ((class "roomy"))
      (a ((class "navigation")
          (href "industry.html"))
         "Industrial partners")
      
      (p ((class "indent1")) "Platinum partners")
      (p ((class "indent2")) (a ((href "http://janestreet.com/")) "Jane Street Capital"))
      (p ((class "indent1")) "Gold partners")
      (p ((class "indent2")) "Anonymous donor")
      (p ((class "indent2")) (a ((href "https://ahrefs.com/")) "Ahrefs"))
      (p ((class "indent2")) (a ((href "https://google.com/")) "Google"))
      (p ((class "indent2")) (a ((href "https://www.mozilla.org/en-US/research/")) "Mozilla Research"))
#|
      (p ((class "indent2")) (a ((href "http://research.microsoft.com/")) "Microsoft Research"))
      #;(p ((class "indent2")) (a ((href "https://www.fpcomplete.com/")) "FP Complete"))      
      #;(p ((class "indent2")) (a ((href "http://nsf.gov/")) "National Science Foundation"))
|#
      (p ((class "indent2")) (a ((href "http://labs.oracle.com/")) "Oracle Labs"))
      (p ((class "indent2")) (a ((href "http://www.uchicago.edu/")) "The University of Chicago"))
#|
      (p ((class "indent2")) (a ((href "http://www.standardchartered.com/")) "Standard Chartered Bank"))
|#
      (p ((class "indent1")) "Silver partners")
      (p ((class "indent2")) (a ((href "http://www.bloomberg.com")) "Bloomberg"))
      (p ((class "indent2")) (a ((href "http://www.tsurucapital.com/en/")) "Tsuru Capital"))
#|
      (p ((class "indent2")) (a ((href "https://www.credit-suisse.com/global/en/")) "Credit Suisse"))
      (p ((class "indent2")) (a ((href "http://cyberpointllc.com/")) "CyberPoint"))
      (p ((class "indent2")) (a ((href "http://www.facebook.com/")) "Facebook"))
|#
      (p ((class "indent2")) (a ((href "http://corp.galois.com/")) "Galois"))
#|
      (p ((class "indent2")) (a ((href "http://hiperfit.dk/")) "HIPERFIT"))
      (p ((class "indent2")) (a ((href "https://klarna.com/")) "Klarna")) " "
      (p ((class "indent2")) (a ((href "http://www.lexifi.com/")) "Lexifi"))            
      #;(p ((class "indent2")) (a ((href "http://www.inria.fr/")) "INRIA"))
      #;(p ((class "indent2")) (a ((href "http://oreilly.com/")) "O'Reilly Media"))
      (p ((class "indent2")) (a ((href "http://twitter.com")) "Twitter"))
|#
      (p ((class "indent1")) "Bronze partners")
      (p ((class "indent2")) (a ((href "https://www.erlang-solutions.com/")) "Erlang Solutions"))
      (p ((class "indent2")) (a ((href "https://www.fireeye.com/")) "FireEye"))
      (p ((class "indent2")) (a ((href "http://www.intellifactory.com/")) "IntelliFactory"))
      (p ((class "indent2")) "PivotCloud")
      (p ((class "indent2")) (a ((href "http://www.systorvest.no/")) "Systor Vest"))
      (p ((class "indent2")) (a ((href "http://unbounce.com/")) "Unbounce"))

#|
      (p ((class "indent2")) (a ((href "http://www.alephcloud.com/")) "Alephcloud"))
      (p ((class "indent2")) (a ((href "http://www.operasoftware.com/")) "Opera Software"))
      (p ((class "indent2")) (a ((href "http://www.quviq.com/")) "QuviQ"))
      |#
      ))))

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

(define deadline-link
 '(a ((href "http://www.timeanddate.com/countdown/generic?iso=20150227T235959&p0=1033&msg=ICFP+2015")) "Friday, February 27 2015, 23:59 (UTC-11)"))

(define author-response-start
  "Tuesday, 21 April, 2015")

(define important-dates
  `[(h3 "Important dates")
    (table
     ((cellpadding "5"))
     #;(tr (td "Workshop proposals due:")
         (td "Friday, 15 November 2013"))
     (tr (td "Submissions due:")
         (td ,deadline-link (br) (a ((href "https://icfp15.hotcrp.com")) "https://icfp15.hotcrp.com")))
     (tr (td "Author response:")
         (td ,author-response-start " " ndash " Thursday, 23 April, 2015"))
     (tr (td "Notification:")
         (td "Friday, 1 May, 2015"))
     (tr (td "Final copy due:")
         (td "Friday, 12 June, 2015"))
     #;(tr (td "Programming contest:")
         (td "Thursday, 8 August - Sunday, 11 August, 2013"))
     (tr (td "Early registration:")
         (td "Monday, 3 August, 2015"))
     (tr (td "Conference:")
         (td "Monday, 31 August - Wednesday, 2 September 2015")))])

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
     (p "ICFP " ,year  " "
	"seeks original papers on the art and science of functional "
	"programming.  Submissions are invited on all topics from principles to "
	"practice, from foundations to features, and from abstraction to "
	"application.  The scope includes all languages that encourage "
	"functional programming, including both purely applicative and "
	"imperative languages, as well as languages with objects, concurrency, "
	"or parallelism.  Topics of interest include (but are not limited to):"
	(ul
	 (li "Language Design: concurrency, parallelism, and distribution; modules; "
	     "components and composition; metaprogramming; type systems; "
	     "interoperability; domain-specific languages; and relations to "
	     "imperative, object-oriented, or logic programming.")
	 (li "Implementation: abstract machines; virtual machines; interpretation; "
	     "compilation; compile-time and run-time optimization; garbage "
	     "collection and memory management; multi-threading; exploiting "
	     "parallel hardware; interfaces to foreign functions, services, "
	     "components, or low-level machine resources.")
	 (li "Software-Development Techniques: algorithms and data structures; "
	     "design patterns; specification; verification; validation; proof "
	     "assistants; debugging; testing; tracing; profiling.")
	 (li "Foundations: formal semantics; lambda calculus; rewriting; type "
	     "theory; monads; continuations; control; state; effects; program "
	     "verification; dependent types.")
	 (li "Analysis and Transformation: control-flow; data-flow; abstract "
	     "interpretation; partial evaluation; program calculation.")
	 (li "Applications: symbolic computing; formal-methods tools; artificial "
	     "intelligence; systems programming; distributed-systems and web "
	     "programming; hardware design; databases; XML processing; "
	     "scientific and numerical computing; graphical user interfaces; "
	     "multimedia and 3D graphics programming; scripting; system "
	     "administration; security.")
	 (li "Education: teaching introductory programming; parallel programming; "
	     "mathematical proof; algebra.")
	 (li "Functional Pearls: elegant, instructive, and fun essays on "
	     "functional programming.")
	 (li "Experience Reports: short papers that provide evidence that "
	     "functional programming really works or describe obstacles that have "
	     "kept it from working."))
     (p "If you are concerned about the appropriateness of some topic, do not "
	"hesitate to contact the program chair."))
     (h3 "Abbreviated instructions for authors")
     (ul
      (li "By " ,deadline-link
	  ", submit a full paper of at most 12 pages (6 pages for an Experience "
	  "Report), in standard ACM conference format, including bibliography, "
	  "figures, and appendices."))
     (p "The deadlines will be strictly enforced and papers exceeding the page "
	"limits will be summarily rejected.")
     (ul 
      (li "Authors have the option to attach supplementary material to a submission, "
	  "on the understanding that reviewers may choose not to look at it.")
      (li "Each submission must adhere to SIGPLAN's republication policy, as "
	  "explained on the web at "
     	  (a ((href "http://www.sigplan.org/Resources/Policies/Republication"))
	     "http://www.sigplan.org/Resources/Policies/Republication"))
      (li "Authors of resubmitted (but previously rejected) papers have the "
	  "option to attach an annotated copy of the reviews of their previous "
	  "submission(s), explaining how they have addressed these previous "
	  "reviews in the present submission.  If a reviewer identifies "
	  "him/herself as a reviewer of this previous submission and wishes to "
	  "see how his/her comments have been addressed, the program chair will "
	  "communicate to this reviewer the annotated copy of his/her previous "
	  "review.  Otherwise, no reviewer will read the annotated copies of "
	  "the previous reviews."))    
     (p "Overall, a submission will be evaluated according to its relevance, "
	"correctness, significance, originality, and clarity.  It should "
	"explain its contributions in both general and technical terms, clearly "
	"identifying what has been accomplished, explaining why it is "
	"significant, and comparing it with previous work.  The technical "
	"content should be accessible to a broad audience.  Functional Pearls "
	"and Experience Reports are separate categories of papers that need not "
	"report original research results and must be marked as such at the "
	"time of submission.  Detailed guidelines on both categories are given below.")
     (p "Presentations will be videotaped and released online if the presenter "
	"consents.  The proceedings will be freely available for download from "
	"the ACM Digital Library from one week before the start of the "
	"conference until two weeks after the conference. ")
     (p (em "Formatting") 
	": Submissions must be in PDF format printable in black and "
	"white on US Letter sized paper and interpretable by "
	"Ghostscript. Papers must adhere to the standard ACM conference format: "
	"two columns, nine-point font on a ten-point baseline, with columns "
	"20pc (3.33in) wide and 54pc (9in) tall, with a column gutter of 2pc "
	"(0.33in).  A suitable document template for LaTeX is available at "
	(a ((href "http://www.acm.org/sigs/sigplan/authorInformation.htm"))
	   "http://www.acm.org/sigs/sigplan/authorInformation.htm")) 
     (p (em "Submission") ": Submissions will be accepted at "
     	(a ((href "https://icfp15.hotcrp.com"))
	   "https://icfp15.hotcrp.com"))
     (p "Improved versions of a paper may be submitted at any point before the "
	" submission deadline using the same web interface.")
     (p (em "Author response: ")
	"Authors will have a 72-hour period, starting at 0:00 "
	"UTC-11 on " ,author-response-start ", to read reviews and respond to them.")
     
     (p "ACM Author-Izer is a unique service that enables ACM "
	"authors to generate and post links on either their home page or "
	"institutional repository for visitors to download the definitive "
	"version of their articles from the ACM Digital Library at no "
	"charge. Downloads through Author-Izer links are captured in official "
	"ACM statistics, improving the accuracy of usage and impact "
	"measurements. Consistently linking the definitive version of ACM "
	"article should reduce user confusion over article versioning. After "
	"your article has been published and assigned to your ACM Author "
	"Profile page, please visit "
	(a ((href "http://www.acm.org/publications/acm-author-izer-service")) 
	   "http://www.acm.org/publications/acm-author-izer-service")
	" to learn how "
	"to create your links for fee downloads from the ACM DL.") 

     (p (em "Publication date")
	": The official publication date of accepted papers "
"is the date the proceedings are made available in the ACM Digital "
"Library. This date may be up to two weeks prior to the first day "
"of the conference. The official publication date affects the deadline "
"for any patent filings related to published work.")

     (h3 "Special categories of papers")
     (p "In addition to research papers, ICFP solicits two kinds of "
	"papers that do not require original research contributions: Functional "
	"Pearls, which are full papers, and Experience Reports, which are "
	"limited to six pages. Authors submitting such papers may wish to "
	"consider the following advice.")
     (h4 "Functional Pearls")
     (p "A Functional Pearl is an elegant essay about something "
	"related to functional programming. Examples include, but are not "
	"limited to:")
     (ul
      (li "a new and thought-provoking way of looking at an old idea")
      (li "an instructive example of program calculation or proof")
      (li "a nifty presentation of an old or new data structure")
      (li "an interesting application of functional programming techniques")
      (li "a novel use or exposition of functional programming in the classroom"))
     (p "While pearls often demonstrate an idea through the "
	"development of a short program, there is no requirement or expectation "
	"that they do so. Thus, they encompass the notions of theoretical and "
	"educational pearls.")
     (p "Functional Pearls are valued as highly and judged as "
	"rigorously as ordinary papers, but using somewhat different "
	"criteria. In particular, a pearl is not required to report original "
	"research, but, it should be concise, instructive, and "
	"entertaining. Your pearl is likely to be rejected if your readers get "
	"bored, if the material gets too complicated, if too much specialized "
	"knowledge is needed, or if the writing is inelegant. The key to "
	"writing a good pearl is polishing.")
     (p "A submission you wish to have treated as a pearl must be "
	"marked as such on the submission web page, and should contain the "
	"words ``Functional Pearl'' somewhere in its title or subtitle. These "
	"steps will alert reviewers to use the appropriate evaluation "
	"criteria. Pearls will be combined with ordinary papers, however, for "
	"the purpose of computing the conference's acceptance rate.")
     (h4 "Experience Reports")
     (p "The purpose of an Experience Report is to help create a body "
	"of published, refereed, citable evidence that functional programming "
	"really works --- or to describe what obstacles prevent it from "
	"working.")
     (p "Possible topics for an Experience Report include, but are not limited to:")
     (ul 
      (li "insights gained from real-world projects using functional programming")
      (li "comparison of functional programming with conventional "
	  "programming in the context of an industrial project or a university "
	  "curriculum")
      (li "project-management, business, or legal issues encountered "
	  "when using functional programming in a real-world project")
      (li "curricular issues encountered when using functional programming in education")
      (li "real-world constraints that created special challenges for "
	  "an implementation of a functional language or for functional "
	  "programming in general"))
     (p "An Experience Report is distinguished from a normal ICFP "
	"paper by its title, by its length, and by the criteria used to "
	"evaluate it.")
     (ul
      (li "Both in the proceedings and in any citations, the title of "
	  "each accepted Experience Report must begin with the words ``Experience "
	  "Report'' followed by a colon. The acceptance rate for Experience "
	  "Reports will be computed and reported separately from the rate for "
	  "ordinary papers.")
      (li "An Experience Report is at most six pages long. Each "
	  "accepted Experience Report will be presented at the conference, but "
	  "depending on the number of Experience Reports and regular papers "
	  "accepted, authors of Experience reports may be asked to give shorter "
	  "talks.") 
      (li "Because the purpose of Experience Reports is to enable our "
	  "community to accumulate a body of evidence about the efficacy of "
	  "functional programming, an acceptable Experience Report need not add "
	  "to the body of knowledge of the functional-programming community by "
	  "presenting novel results or conclusions. It is sufficient if the "
	  "Report states a clear thesis and provides supporting evidence. The "
	  "thesis must be relevant to ICFP, but it need not be novel."))
     (p "The program committee will accept or reject Experience "
	"Reports based on whether they judge the evidence to be "
	"convincing. Anecdotal evidence will be acceptable provided it is well "
	"argued and the author explains what efforts were made to gather as "
	"much evidence as possible. Typically, more convincing evidence is "
	"obtained from papers which show how functional programming was used "
	"than from papers which only say that functional programming was "
	"used. The most convincing evidence often includes comparisons of "
	"situations before and after the introduction or discontinuation of "
	"functional programming. Evidence drawn from a single person's "
	"experience may be sufficient, but more weight will be given to "
	"evidence drawn from the experience of groups of people.")
     (p "An Experience Report should be short and to the point: make a "
	"claim about how well functional programming worked on your project and "
	"why, and produce evidence to substantiate your claim. If functional "
	"programming worked for you in the same ways it has worked for others, "
	"you need only to summarize the results---the main part of your paper "
	"should discuss how well it worked and in what context. Most readers "
	"will not want to know all the details of your project and its "
	"implementation, but please characterize your project and its context "
	"well enough so that readers can judge to what degree your experience "
	"is relevant to their own projects. Be especially careful to highlight "
	"any unusual aspects of your project. Also keep in mind that specifics "
	"about your project are more valuable than generalities about "
	"functional programming; for example, it is more valuable to say that "
	"your team delivered its software a month ahead of schedule than it is "
	"to say that functional programming made your team more productive.")
     (p "If your paper not only describes experience but also presents "
	"new technical results, or if your experience refutes cherished beliefs "
	"of the functional-programming community, you may be better off "
	"submitting it as a full paper, which will be judged by the usual "
	"criteria of novelty, originality, and relevance. If you are unsure in "
	"which category to submit, the program chair will be happy to help you "
	"decide.")

     (h3 "Organizers")
     (table
      ((cellpadding "5")
       (summary "Organizers"))
      ,(role-row/co "General Chair" 'gc)
      ,(role-row/co "Program Chair" 'pc)
      (tr (td "Program Committee:"))
      ,@(map (lambda (p) (row/co "" p person/co-country)) (get-roles 'pcm))))))

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
		 (td "As above plus: logo on swag bag, named supporter of whole event, logo on lanyards, table/booth-like space available (in coffee break areas), other negotiated benefits (subject to ACM restrictions on commercial involvement).")))
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
                  (a ((href "https://secure.flickr.com/photos/kwl/")) "Kenny Louie")
		  " "
		  (a ((href "https://secure.flickr.com/photos/kwl/2432868269/")) "(CC BY 2.0)"))))
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
	  (li "Don't miss the many ICFP social events: the opening "
	      "reception and poster session on Monday night (18:15) at "
	      "the Regency Foyer of the conference hotel, the banquet dinner on Tuesday "
	      "night (22:00) at the "
	      "Vancouver Aquarium, and the industrial reception "
	      "on Thursday night (18:00) in the Regency C ballroom of the conference hotel.  These events are made possible by the "
	      "generous support from our industrial partners.")

	  (li "The full proceedings are now " (a ((href "toc.html")) "available") ".")
	  (li "The conference hotel is booked.  A new hotel block has been reserved at "
	      "the nearby Metropolitan Hotel.  Reservations "
	      "can be made " (a ((href "http://tiny.cc/metvan_ICFP2015")) "here") ".")
	  (li "The hotel reservation block ends 8 August.  See "
	      (a ((href "local.html")) "local information") 
	      " for more details.")
	  (li "The " (a ((href "program.html")) "program") " for ICFP 2015 has been finalized.")
	  (li "The deadline for " (a ((href "src.html")) "Student Research Competition")
	      " submissions has been extended until 6th July.  Submit "
	      (a ((href "https://www.easychair.org/conferences/?conf=icfp2015src"))
		 "here")
	      ".  Submissions from undergraduates are encouraged!  Travel funding is provided, too!")
	  (li "Book your room " (a ((href "https://resweb.passkey.com/go/acmicfp2015conf")) "here") ".")
	  (li "The ICFP 2015 "  (a ((href "http://www.icfpcontest.org/")) "Programming Contest") " will take place from "
	      "Friday 7 August 2015 at 12:00 UTC and ends on Monday 10 "
	      "August 2015 at 12:00 UTC.")
	  (li (a ((href "https://regmaster4.com/2015conf/ICFP15/register.php")) "Registration")
	      " is now open.")
          (li "The " (a ((href "accepted.html")) "list of accepted papers") " is now online.")	 
	  (li "The "
	      (a ((href "https://www.cis.upenn.edu/~sweirich/icfp-plmw15/")) 
		 "Programming Languages Mentoring Workshop")
	      " is accepting "
	      "applications for travel grants to attend PLMW @ ICFP. "
	      "The deadline to apply is April 24th, 2015.")
	  (li "Submissions are closed; ICFP 2015 received 119 submissions, the second highest number in ICFP history!")
	     (li "The " (a ((href "src.html")) "student research competition") " has been announced.  Deadline for submission: 29 June (provisional)."))
	 #;(ul
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
          ,@(role-rows "Programming Contest Chair" 'cc)
          ,(role-row "Student Research Competition Chair" 'src)
	  ,@(role-rows "Mentoring Workshop Co-Chairs" 'mentor)
          ,(role-row "Publicity Chair" 'pub)
          ,@(role-rows "Video Chair" 'video)
          ,@(role-rows "Student Volunteer Co-Chairs" 'sv)
	  #;,(role-row "Mobile App Chair" 'mac)
          )

     (h3 "SIGPLAN Conference Anti-Harassment Policy") 

     (p (a ((href "http://www.sigplan.org/Resources/Policies/Anti-harassment")) 
	   "The open exchange of ideas and the freedom of thought and "
	"expression are central to the aims and goals of SIGPLAN")
	"; these require "
	"an environment that recognizes the inherent worth of every person and "
	"group, that fosters dignity, understanding, and mutual respect, and "
	"that embraces diversity. For these reasons, SIGPLAN is dedicated to "
	"providing a harassment-free conference experience, and implements "
	"the " 
	(a ((href "http://www.acm.org/sigs/volunteer_resources/officers_manual/anti-harassment-policy")) 
	   "ACM policy against harassment") 
	".")

     (p "Conference participants violating these standards may be "
	"sanctioned or expelled from the conference, at the discretion of the "
	"conference organizers. Conference organizers are requested to report "
	"serious incidents to the SIGPLAN Vice Chair.")


         #;(h3 "Program Committee")
         #;(table
            ((cellpadding "5")
             (summary "PC"))
	    ,@(map (lambda (p) (row "" p)) program-committee)
            )

         
         
         (h3 "Industrial Partners")         

	 ;;(img ((class "sponsor") (src "img/logos.png")))
         (h4 "Platinum partners")
         (img ((class "sponsor") (src "img/JS.png")))
         (h4 "Gold partners")
	 (img ((class "sponsor") (src "img/Ahrefs.png"))) 
	 (img ((class "sponsor") (src "img/google.png")))         
         (img ((class "sponsor") (src "img/moz.png")))
         #|
         (img ((class "sponsor") (src "img/msr.png")))         
	 #;(img ((class "sponsor") (src "img/fp-complete.png")))         
         #;(img ((class "sponsor") (src "img/nsf.png")))
|#
         (img ((class "sponsor") (src "img/ol.jpg")))
	 (img ((class "sponsor") (src "img/UChicago.png")))
#|
         (img ((class "sponsor") (src "img/standard-chartered.png")))
	 |#
         (h4 "Silver partners")	 
         (img ((class "sponsor") (src "img/bloomberg.png")))
         (img ((class "sponsor") (src "img/tsuru.png")))
	 #|
	 (img ((class "sponsor") (src "img/creditsuisse.png")))
	 (img ((class "sponsor") (src "img/cyberpoint.png"))) " "
	 (img ((class "sponsor") (src "img/fb.png")))
|#
	 (img ((class "sponsor") (src "img/galois.png")))
#|
         (img ((class "sponsor") (src "img/klarna.png")))
	 (img ((class "sponsor") (src "img/lexifi.png")))               	 
         #;" "	 
	 #;
         #;(img ((class "sponsor") (src "img/inria.png")))
	 #;(img ((class "sponsor") (src "img/CCIS.png")))
         #;(img ((class "sponsor") (src "img/oreilly.png")))
         (img ((class "sponsor") (src "img/twitter-bird-light-bgs.png")))
|#
	 (h4 "Bronze partners")
         (img ((class "sponsor") (src "img/erl_solutions_logo.png")))
         (img ((class "sponsor") (src "img/fireeye.png")))
         (img ((class "sponsor") (src "img/IntelliFactory.png")))
	 (img ((class "sponsor") (src "img/pivotcloud.png")))
	 (img ((class "sponsor") (src "img/systorvestlogo.png")))
	 (img ((class "sponsor") (src "img/unbounce.png")))
#|
         (img ((class "sponsor") (src "img/opera.png")))
	 (img ((class "sponsor") (src "img/quviq.jpeg"))) 
         |#
         )
	
        ,col2)))
     ,@footers)))
  

(define workshop-date-par
  '(p "The workshops are scheduled to occur on August 30 (the day before ICFP) "
      "and September 3-5 (the three days after ICFP)."))
(define workshop-email
  (let ((addr (string-append "icfp" year #;(substring year 2 4) "-workshops@" workshop-domain)))
    `(a ((href ,(string-append "mailto:" addr)))
        ,addr)))
(define ally `(a ((href "http://catamorphism.org/Ally2015/")) "Ally Skills Tutorial"))

(define SFPW `(a ((href "http://andykeep.com/SchemeWorkshop2015/"))
                 "Scheme and Functional Programming Workshop"))
(define PLMW `(a ((href "http://www.cis.upenn.edu/~sweirich/icfp-plmw15/")) 
		 "Programming Languages Mentoring Workshop"))

(define CUFP `(a ((href "http://cufp.org/2015/")) "Commercial Users of Functional Programming"))
(define FARM `(a ((href "http://functional-art.org/"))
		 "Functional Art, Music, Modeling and Design"))
(define Erlang `(a ((href "http://www.erlang.org/workshop/2015/ErlangWorkshop2015.html"))
		   "Erlang Workshop"))
(define Haskell 
  `(a ((href "http://www.haskell.org/haskell-symposium/2015/"))
      "Haskell Symposium"))
(define ML   
  `(a ((href "http://www.mlworkshop.org/ml2015/")) "ML Family Workshop"))

(define HIW `(a ((href "http://www.haskell.org/haskellwiki/HaskellImplementorsWorkshop"))
		"Haskell Implementors Workshop"))
(define HART 
  `(a ((href "http://www.program-transformation.org/HART14/"))
      "Workshop on Haskell and Rewriting Techniques"))
(define WGP
  `(a ((href "http://www.wgp-sigplan.org/farmer/doku.php?id=2015"))
      "Workshop on Generic Programming"))
(define HOPE 
  `(a ((href "http://users-cs.au.dk/birke/hope-2015/"))
      "Workshop on Higher-order Programming with Effects"))

(define FHPC
  `(a ((href "https://sites.google.com/site/fhpcworkshops/")) 
      "Workshop on Functional High-Performance Computing"))

(define OCAML
  `(a ((href "https://ocaml.org/meetings/ocaml/2015/")) "OCaml Workshop"))





(define affiliated.xexpr
  (make-page
   "Affiliated events"
   `(div
     ((class "col1"))
     (center
      (h1 "Affiliated events"))

     (h3 "Sunday, August 30")
     (ul 
      (li ,HIW)
      (li ,HOPE)
      (li ,WGP)
      (li ,PLMW)
      (li ,ally))

     (h3 "Monday, August 31 " ndash " Wednesday, September 2")
     (ul (li "ICFP"))

     (h3 "Thursday, September 3")
     (ul
      (li ,FHPC)
      (li ,Haskell " " ndash " Day 1")
      (li ,ML)
      (li ,CUFP " " ndash "Day 1"))


     (h3 "Friday, September 4")
     (ul
      (li ,Erlang)
      (li ,Haskell " " ndash "Day 2")
      (li ,OCAML)
      (li ,CUFP " " ndash "Day 2")
      (li ,SFPW))

     (h3 "Saturday, September 5")
     (ul 
      (li ,FARM)
      (li ,CUFP  " " ndash "Day 3")))))

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
	(a ((href "http://www.sigplan.org/ContactUs/"))
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
     (p "See the ACM Digital Library " (a ((href "toc.html")) "Table of Contents")
	" for access to papers.")

     (p "See the " (a ((href "affiliated.html")) "affiliated events") " page "
	"for information about ICFP co-located events.")

     (h2 "Monday, 31 August")
     (dl (dt "8:45-9:00 Opening (General Chair)")
         (dt ((class "keynotetitle")) "9:00-10:00 Keynote: Ras Bodik (University of Washington)")
         (dd "Program Synthesis: Opportunities for the next Decade")
         (dt "10:00-10:30 Coffee")
         (dt ((class "session")) "10:30-11:30 Session 1: Compilers")
         (dt ((class "paper")) (em "Functional Pearl: A SQL to C Compiler in 500 Lines of Code"))
	 (dd ((class "paper")) "Tiark Rompf, Purdue University (USA); Nada Amin, EPFL (Switzerland)")
         (dt ((class "paper")) (em "An Optimizing Compiler for a Purely Functional Web-Application Language"))
         (dd ((class "paper")) "Adam Chlipala, MIT CSAIL (USA)")
	 (dt ((class "paper")) (em "Pycket: A Tracing JIT For a Functional Language"))
         (dd ((class "paper")) 
	     "Spenser Bauman, Indiana University (USA); "
	     "Carl Friedrich Bolz, Kings College, London (UK); "
	     "Robert Hirschfeld, Hassno-Plattner-Institut, Potsdam (Germany); "
	     "Vasily Krilichev, Hassno-Plattner-Institut, Potsdam (Germany); "
	     "Tobias Pape, Hassno-Plattner-Institut, Potsdam (Germany); "
	     "Jeremy G. Siek, Indiana University (USA); "
	     "Sam Tobin-Hochstadt, Indiana University (USA)")
	 
         (dt "11:30-11:50 Break")
         (dt ((class "session")) "11:50-12:30 Session 2: Types")
         (dt ((class "paper")) (em "1ML - Core and modules united (F-ing first-class modules)"))
         (dd ((class "paper")) "Andreas Rossberg, Google (Germany)")
         (dt ((class "paper")) (em "Bounded Refinement Types"))
         (dd ((class "paper")) 
	     "Niki Vazou, UC San Diego (USA); "
	     "Alexander Bakst, UC San Diego (USA); "
	     "Ranjit Jhala, UC San Diego (USA)")

         (dt "12:30-14:00 Lunch")


         (dt ((class "session")) "14:00-15:00 Session 3: Miscellaneous")
	 (dt ((class "paper")) (em "Applicative Bidirectional Programming with Lenses"))
	 (dd ((class "paper")) 
	     "Kazutaka Matsuda, Tohoku University (Japan); "
	     "Meng Wang, University of Kent (UK)")
	 (dt ((class "paper")) (em "Hygienic Resugaring of Compositional Desugaring"))
	 (dd ((class "paper")) 
	     "Justin Pombrio, Brown University (USA); "
	     "Shriram Krishnamurthi, Brown University (USA)")
	 (dt ((class "paper")) (em "XQuery and Static Typing: Tackling the Problem of Backward Axes"))
	 (dd ((class "paper")) 
	     "Pierre Genev" egrave "s, CNRS (France); "
	     "Nils Gesbert, Universit" eacute " Grenoble Alpes (France)")

	 (dt "15:00-15:20 Break")

         (dt ((class "session")) "15:20-16:20 Session 4: Foundations I")
	 
	 (dt ((class "paper")) (em "Noninterference for Free"))
	 (dd ((class "paper")) 
	     "William J. Bowman, Northeastern University CCIS (USA); "
	     "Amal Ahmed, Northeastern University CCIS (USA)")
	 (dt ((class "paper")) (em "Algebras and Coalgebras in the Light Affine Lambda Calculus"))
	 (dd ((class "paper")) 
	     "Marco Gaboardi, University of Dundee (UK) and Harvard University (USA); "
	     "Romain P" eacute "choux, Universit" eacute " de Lorraine (France)")
	 (dt ((class "paper")) (em "Structures for structural recursion"))
	 (dd ((class "paper")) 
	     "Paul Downen, University of Oregon (USA); "
	     "Philip Johnson-Freyd, University of Oregon (USA); "
	     "Zena M. Ariola, University of Oregon (USA)")

	 (dt "16:20-16:50 Tea")

	 (dt ((class "session")) "16:50-17:30 Session 5: Cost analysis")

	 (dt ((class "paper")) (em "Denotational cost semantics for functional languages with inductive types"))
	 (dd ((class "paper")) 
	     "Norman Danner, Wesleyan University (USA); "
	     "Daniel R. Licata, Wesleyan University (USA); "
	     "Ramyaa Ramyaa, Wesleyan University (USA)")
	 (dt ((class "paper")) (em "Analysing the Complexity of Functional Programs: Higher-Order Meets First-Order"))
	 (dd ((class "paper")) 
	     "Martin Avanzini, University of Bologna (Italy) & INRIA (France); "
	     "Ugo Dal Lago, University of Bologna (Italy) & INRIA (France); "
	     "Georg Moser, University of Innsbruck (Austria)")

	 (dt "17:30-18:00 Program Chair's Report (John Reppy)")
	 (dt ((class "session")) "18:15-19:45 Poster Session / Welcome Reception: Hyatt Regency, Regency Foyer"))
	 
     (h2 "Tuesday, 1 September")
     (dl (dt ((class "keynotetitle")) "9:00-10:00 Keynote: Mary Sheeran, Chalmers University of Technology (Sweden)")     
	 (dd "Functional Programming and Hardware Design: Still Interesting after All These Years")

         (dt "10:00-10:30 Coffee")
	
	 (dt ((class "session")) "10:30-11:30 Session 6: Theorem provers")

	 (dt ((class "paper")) (em "Pilsner: A Compositionally Verified Compiler for a Higher-Order Imperative Language"))
	 (dd ((class "paper")) 
	     "Georg Neis, MPI-SWS (Germany); "
	     "Chung-Kil Hur, Seoul National University (Republic of Korea); "
	     "Jan-Oliver Kaiser, MPI-SWS (Germany); "
	     "Craig McLaughlin, University of Glasgow (UK); "
	     "Derek Dreyer, MPI-SWS (Germany); "
	     "Viktor Vafeiadis, MPI-SWS (Germany)")
	 (dt ((class "paper")) (em "A Unification Algorithm for Coq Featuring Universe Polymorphism and Overloading"))
	 (dd ((class "paper")) 
	     "Beta Ziliani, MPI-SWS (Germany); "
	     "Matthieu Sozeau, INRIA & PPS, Universit" eacute " Paris Diderot (France)")
	 (dt ((class "paper")) (em "Foundational Extensible Corecursion: A Proof Assistant Perspective"))
	 (dd ((class "paper")) 
	     "Jasmin Christian Blanchette, INRIA & LORIA, Nancy (France); "
	     "Andrei Popescu, Middlesex University. London (UK); "
	     "Dmitriy Traytel, TU M" uuml "nchen (Germany)")

	 (dt "11:30-11:50 Break")
	 (dt ((class "session")) "11:50-12:30 Student Research Competition I")

	 (dt "12:30-14:00 Lunch")

	 (dt ((class "session")) "14:00-15:00 Session 7: Parallelism")

	 (dt ((class "paper")) (em "Generating Performance Portable Code using Rewrite Rules: From High-level Functional Expressions to High-Performance OpenCL Code"))
	 (dd ((class "paper")) 
	     "Michel Steuwer, The University of Edinburgh (UK); "
	     "Christian Fensch, Heriot-Watt University (UK); "
	     "Sam Lindley, The University of Edinburgh (UK); "
	     "Christophe Dubach, The University of Edinburgh (UK)")
	 (dt ((class "paper")) (em "Adaptive Lock-Free Maps: Purely-Functional to Scalable"))
	 (dd ((class "paper")) 
	     "Ryan R. Newton, Indiana University (USA); "
	     "Peter Fogg, Indiana University (USA); "
	     "Ali Varamesh, Indiana University (USA)")
	 (dt ((class "paper")) (em "Partial Aborts for Transactions via First-Class Continuations"))
	 (dd ((class "paper")) 
	     "Matthew Le, Rochester Institute of Technology (USA); "
	     "Matthew Fluet, Rochester Institute of Technology (USA)")

	 (dt "15:00-15:20 Break")
	 
	 (dt ((class "session")) "15:20-16:20 Session 8: Foundations II")

	 (dt ((class "paper")) (em "Which simple types have a unique inhabitant?"))
	 (dd ((class "paper")) 
	     "Gabriel Scherer, INRIA (France); "
	     "Didier R" eacute "my, INRIA (France)")
	 (dt ((class "paper")) (em "Elaborating Evaluation-Order Polymorphism"))
	 (dd ((class "paper")) 
	     "Joshua Dunfield, University of British Columbia (Canada)")
	 (dt ((class "paper")) (em "Automatic Refunctionalization to a Language with Copattern Matching: With Applications to the Expression Problem"))
	 (dd ((class "paper")) 
	     "Tillmann Rendel, University of T" uuml "bingen (Germany); "
	     "Julia Trieflinger, University of T" uuml "bingen (Germany); "
	     "Klaus Ostermann, University of T" uuml "bingen (Germany)")

	 (dt "16:20-16:50 Tea")

	 (dt ((class "session")) "16:50-17:30 Session 9: Information flow")

	 (dt ((class "paper")) (em "Functional Pearl: Two can keep a secret, if one of them uses Haskell"))
	 (dd ((class "paper")) 
	     "Alejandro Russo, Chalmers University of Technology (Sweden)")
	 (dt ((class "paper")) (em "HLIO: Mixing Static and Dynamic Typing for Information-Flow Control in Haskell"))
	 (dd ((class "paper")) 
	     "Pablo Buiras, Chalmers University of Technology (Sweden); "
	     "Dimitrios Vytiniotis, Microsoft Research (UK); "
	     "Alejandro Russo, Chalmers University of Technology (Sweden)")

	 (dt ((class "session")) "17:30-18:15 ICFP Award Ceremony and Contest Presentation")
	 (dd "17:30 ICFP Award Ceremony")
	 (dd "17:45 ICFP Contest Presentation")

	 (dt ((class "session")) "20:00-22:30 Banquet: Vancouver Aquarium")
	 (dd "Busses depart from Hyatt Regency 19:30"))
	 
	 
     (h2 "Wednesday, 2 September")

     (dl (dt ((class "keynotetitle")) "9:00-10:00 Tribute to Paul Hudak")
	 (dd "John Hughes, Chalmers University of Technology (Sweden) and John Peterson, Western State Colorado University (USA)")     

	 (dt "10:00-10:30 Coffee")

	 (dt ((class "session")) "10:30-11:30 Session 10: Domain-specific languages")

	 (dt ((class "paper")) (em "Practical Principled FRP: Forget the past, change the future, FRPNow!"))
	 (dd ((class "paper")) 
	     "Atze van der Ploeg, Chalmers University of Technology (Sweden); "
	     "Koen Claessen, Chalmers University of Technology (Sweden)")
	 (dt ((class "paper")) (em "Certified Symbolic Management of Financial Multi-Party Contracts"))
	 (dd ((class "paper")) 
	     "Patrick Bahr, University of Copenhagen (Denmark); "
	     "Jost Berthold, Commonwealth Bank of Australia (Australia); "
	     "Martin Elsman, University of Copenhagen (Denmark)")
	 (dt ((class "paper")) (em "A Fast Compiler for NetKAT"))
	 (dd ((class "paper")) 
	     "Steffen Smolka, Cornell University (USA); "
	     "Spiridon Eliopoulos, Inhabited Type LLC (USA); "
	     "Nate Foster, Cornell University (USA); "
	     "Arjun Guha, University of Massachusetts Amherst (USA)")
	 (dt "11:30-11:50 Break")

	 (dt ((class "session")) "11:50-12:30 Student Research Competition II")

	 (dt "12:30-14:00 Lunch")

	 (dt ((class "session")) "14:00-15:00 Session 11: Data structures")

	 (dt ((class "paper")) (em "RRB Vector: A Practical General Purpose Immutable Sequence"))
	 (dd ((class "paper")) 
	     "Nicolas Stucki, EPFL (Switzerland); "
	     "Tiark Rompf, Purdue University (USA); "
	     "Vlad Ureche, EPFL (Switzerland)")
	 (dt ((class "paper")) (em "Functional Pearl: A Smart View on Datatypes"))
	 (dd ((class "paper")) 
	     "Mauro Jaskelioff, CIFASIS - CONICET (Argentina); "
	     "Exequiel Rivas, CIFASIS - CONICET (Argentina)")
	 (dt ((class "paper")) (em "Efficient Communication and Collection with Compact Normal Forms"))
	 (dd ((class "paper")) 
	     "Abhishek Kulkarni, Indiana University (USA); "
	     "Ahmed El-Hassany, Indiana University (USA); "
	     "Edward Z. Yang, Stanford University (USA); "
	     "Giovanni Campagna, Stanford University (USA); "
	     "Ryan Newton, Indiana University (USA); "
	     Ouml "mer S. A" 287 "acan, Indiana University (USA)")


	 (dt "15:00-15:20 Break")

	 (dt ((class "session")) "15:20-16:20 Session 12: Contracts")

	 (dt ((class "paper")) (em "Blame Assignment for Higher-Order Contracts with Intersection and Union"))
	 (dd ((class "paper")) 
	     "Matthias Keil, University of Freiburg (Germany); "
	     "Peter Thiemann, University of Freiburg (Germany)")
	 (dt ((class "paper")) (em "Expressing Contract Monitors as Patterns of Communication"))
	 (dd ((class "paper")) 
	     "Cameron Swords, Indiana University (USA); "
	     "Amr Sabry, Indiana University (USA); "
	     "Sam Tobin-Hochstadt, Indiana University (USA)")
	 (dt ((class "paper")) (em "Learning Refinement Types"))
	 (dd ((class "paper")) 
	     "He Zhu, Purdue University (USA); "
	     "Aditya V. Nori, Microsoft Research (USA); "
	     "Suresh Jagannathan, Purdue University (USA)")

	 (dt "16:20-16:50 Tea")
	 (dt ((class "session")) "16:50-17:30 Session 13: Type checking")

	 (dt ((class "paper")) (em "Practical SMT-Based Type Error Localization"))
	 (dd ((class "paper")) 
	     "Zvonimir Pavlinovic, New York University (USA); "
	     "Tim King, Verimag (France); "
	     "Thomas Wies, New York University (USA)")
	 (dt ((class "paper")) (em "GADTs Meet their Match: Pattern-Matching Warnings That Account for GADTs, Guards, and Laziness"))
	 (dd ((class "paper")) 
	     "Georgios Karachalias, Ghent University (Belgium); "
	     "Tom Schrijvers, KU Leuven (Belgium); "
	     "Dimitrios Vytiniotis, Microsoft Research Cambridge (UK); "
	     "Simon Peyton Jones, Microsoft Research Cambridge (UK)")

	 (dt ((class "session")) "17:30-18:10 SRC Awards presentation - ICFP 2015 Closing - ICFP 2016 Presentation")

	 (dt ((class "session")) "18:30-20:30 " (a ((href "http://www.meetup.com/PolyglotVancouver/events/222208655/"))
						    "Polyglot meetup")
	     ", Unbounce, Suite #400 - 401 W. Georgia St."))

     (h2 "Thursday, 3 September")

     (dl (dt ((class "session")) "18:00-19:45 Industrial reception, Regency C ballroom, Hyatt Regency")))))

(define local.xexpr
  (make-page 
   "Local information"	     
   `(div
     ((class "col1"))
     (center
      (h1 "Local information"))
     (h2 "Conference venue")
     (p "The conference will take place at the " 
	(a ((href "http://vancouver.hyatt.com/en/hotel/home.html")) "Hyatt Regency Vancouver") 
	" in Vancouver BC Canada.")

     (p "Hyatt Regency Vancouver" (br)       
	"655 Burrard Street" (br)
	"Vancouver, British Columbia, Canada, V6C 2R7")

     (p ((style "color: red")) "Accomodations at the conference hotel are fully booked at this point.")
     (p "A second hotel block has been reserved at the very nearby (1 block away) Metropolitan "
	"Hotel Vancouver.")
     (p "Book your room " (a ((href "http://tiny.cc/metvan_ICFP2015")) "here") " for the "
	"discounted rate of $189 + tax.")

     #;(p "Book your room here: " (a ((href "https://resweb.passkey.com/go/acmicfp2015conf"))
				   "https://resweb.passkey.com/go/acmicfp2015conf")
	". "
	(span ((style "text-decoration:line-through")) "The hotel rate is CAD $185 / night + tax."))

     #;(p ((style "color: red")) "The hotel block of standard rooms is fully booked. "
	"The hotel has a block of balcony / view rooms at a rate of "
 	"CAD $235, or approximately USD $178, per night. "
	"The cut-off date for this block is August 8th.")


     #;(p "If you prefer to call in, please dial 1-888-421-1442 (North America) or 1-402-592-6464 (International)")

     (h3 "Getting to the conference hotel")

     (p "To / From Vancouver International Airport:")

     (p "Canada Line:")

     (p
      (a ((href "http://www.translink.ca")) "TransLink")
      " operates trains on the Canada Line, which takes you from Vancouver
International Airport (YVR) "
      "to downtown Vancouver in about 30 minutes. "
      "The conference hotel is three blocks from Vancouver City Centre
station on the Canada Line. "
      "To get even closer, change to the Expo/Millennium Line at Waterfront,
and ride one stop to Burrard.")
      
     (p "The regular adult fare from the airport is $9 ($4 + $5 airport surcharge). "
	"After 6:30pm (18:30) Monday-Friday, and anytime Saturday-Sunday, the
fare is $7.75 ($2.75 + $5 airport surcharge)."
	)

     (p "Tickets expire 90 minutes after purchase. "
	"Fares are checked by police throughout the system, with large "
	"fines (over $150) for fare evasion.")

     (p "For more information, see "
	(a ((href "http://www.translink.ca/en/Fares-and-Passes/Single-Fares.aspx"))
	   "TransLink fares") 
	". "
	"The airport surcharge does not apply to trips " (i "to") " the airport.")
     
     (p "Taxi:")

     (p "Taxis are available at the airport 24 hours a day, including wheelchair accessible vans. Taxi queue areas are located at both the domestic and international arrivals terminals. There is a flat rate from the Airport to the Hyatt of $31.00 CAD, and is approximately $35.00 CAD from the Hyatt to the Airport as a metered fare. ")

 
     (p "To / From the Cruise Ship Dock:")
     
     (p "Taxi services are available to and from Canada Place or Ballantyne Pier to our hotel. Cost is approximately $10.00 CAD to $20.00 CAD. Please see our concierge for arrangements.")

 
     (p "Via Rail and Amtrak:")

     (p "Both Via Rail and Amtrak serve Vancouver. Taxi to Pacific Central Station is approximately $12.00 CAD. Service is also available on Skytrain (three stops away).")

 
     (p "Around the city:")
     #;
     (p "View "
	(a ((href "https://maps.google.se/maps/ms?msa=0&msid=210997146033221229789.0004ef75436b30b7dddf6&ie=UTF8&t=m&ll=57.698369,11.978016&spn=0.032106,0.073128&z=13&source=embed"))
	   "ICFP2014 locations")
	" in a larger map.")

     (p "TransLink also operates dozens of bus lines throughout Metro Vancouver. "
	"On buses, you need to pay the fare ($2.75 for trips within the city "
	"of Vancouver) using coins; "
	"bus drivers cannot make change.  If you expect to pay 8 or more fares during "
	"your visit, you can save money (and fumbling with coins) by buying "
	(a ((href "http://www.translink.ca/en/Fares-and-Passes/FareSaver-Tickets.aspx"))
	   "FareSavers")
	"---books of 10 tickets---from drugstores and convenience stores, "
	"such as London Drugs, Shoppers Drug Mart, and 7-Eleven.")

     (p "The TransLink site has a decent "
	(a ((href "http://tripplanning.translink.ca")) "trip planner") ". "
	"Useful bus lines include the 19 from the Kingsway and Main Street to "
	"Stanley Park, "
	"and the 99 express bus on Broadway (take the Canada Line to "
	"Broadway-City Hall station).")
     

     (h3 "Restaurants")

     (p "There is a " (a ((href "https://www.google.com/maps/d/edit?mid=z9qwa7h0iGE0.kN2QLuYO25Q4&usp=sharing")) "map")
	" of nearby restaurants.")



     (h2 "Support from the SIGPLAN Professional Activities Committee")
     (p "The " (a ((href "http://www.sigplan.org/PAC.htm")) "SIGPLAN Professional Activities Committee") " can potentially provide supplemental financial "
        "support for attending ICFP in the form of student grants, child-care support, companion travel "
        "grants, and long-distance internation travel support. "
	"These grants are only available to student presenters and co-authors. "
        "To apply, follow the instructions found " (a ((href "http://www.sigplan.org/PAC.htm")) "here") ".")
   #|  
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
|#
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
      (dt (b "The SIGPLAN Programming Languages Mentoring Workshop at ICFP"))
      (dd "ICFP is hosting the SIGPLAN Programming Languages Mentoring Workshop, "
	  "which will provide a number travel grants for student attendees. "
	  "See the " 
	  (a ((href "https://www.cis.upenn.edu/~sweirich/icfp-plmw15/"))
	     "PLMW")
	  " site for more details.")
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
	" at the ICFP " ,year " consists of three rounds:"

	(dl (dt (b "Extended abstract round: "))
	    (dd "All students are encouraged to submit an extended "
		"abstract outlining their research (800 words).")
	    (dt (b "Poster session at ICFP " ,year ":"))
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
     (p "You will be responsible for transporting your poster to the "
	"conference. If this will be a problem, please contact the "
	"chair of the SRC.")

     (h2 "Prizes")
     (ul
      (li "The top three graduate and the top three "
	  "undergraduate winners will receive prizes of $500, $300, "
	  "and $200, respectively.")
      (li "All six winners will receive award medals and a two-year "
	  "complimentary ACM student membership, including a subscription to "
	  "ACM's Digital Library.")
      (li "The names of the winners will be posted on the SRC web site.")
      (li "The first place winners of the SRC will be invited to participate "
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
      (li ((style "color: red")) "The ACM, Microsoft Research, and our industrial partners "
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
     (p (center (a ((href "https://www.easychair.org/conferences/?conf=icfp2015src"))
		   "https://www.easychair.org/conferences/?conf=icfp2015src")))
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
	(a ((href "https://www.easychair.org/conferences/?conf=icfp2015src"))
	   "submission page") 
	", and put all information requested above in the PDF that you submit, ignoring the field marked 'Abstract'. "
	"Abstracts submitted after the deadline may be considered "
	"at the committee's discretion, but only after decisions have been made "
	"on all abstracts submitted before the deadline. If you have any "
	"problems, don't hesitate to contact the competition chair. ")
     (h2 "Important Dates")
     (ul
      (li ((style "color: red")) "Deadline for submission: 6th July (extended)")
      (li "Notification of acceptance: 14th July"))
     (h2 "Selection Committee")
     (table
      ,(row "Chair" (get-role 'src))
      ,@(map (lambda (p) (row "" p)) (get-roles 'sr))
      )
     (p "The remaining members of the SRC selection committee will be announced at a later date."))))


(define sv.xexpr
  (make-page
   "Student Volunteer Program"
   `(div
     ((class "col1"))
     (center
      (h1 "Student Volunteer Program"))
     (p "Sign up to be a Student Volunteer and help us make ICFP " ,year " "
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


     (p "The Student Volunteer Program helps more students attend the "
	"ICFP conference by covering conference fees (but not travel "
	"or lodging expenses) in exchange for a fixed number of work "
	"hours (usually from 8 to 12) helping with the conference "
	"organization (registration and information desks, assistance "
	"during talk sessions, etc.).")
     (p "The Student Volunteer registration covers:"
	(ul
	 (li "Access to all workshops and the main conference,")
	 (li "Daily lunches and coffee breaks,")
	 (li "Access to social events, including the banquet.")))

     (p "To apply as a Student Volunteers, please send an email to "
	"Gabriel Scherer and Felipe Ba" ntilde "ados Schwerter "
	"at " (a ((href "mailto:icfp-sv@lambda-calcul.us")) "icfp-sv@lambda-calcul.us")
	" with the following information:")
     (h2 "Identity")
     (p (ul 
	 (li "your name")
	 (li "your affiliation")
	 (li "your program of study and current year of study") 
	 (li "the name and email of your supervisor, or (if you don't "
	     "have a supervisor yet) a professor that would recommend you")))
     (h2 "Organization")
     (p (ul
	 (li "the time period between Sunday, August 30 and Saturday, "
	     "September 5 where you are sure to be available")
	 (li "a list of workshops you would not mind attending")
	 (li "author information: tell us if you're presenting something "
	     "during the conference, or are co-author from a paper")
	 (li "application information: tell us if you're applying to "
	     "other student ICFP attendance programs")
	 (li "past SV positions: where and when you have already been "
	     "a Student Volunteer before")))
     (p "All applications received by June 15th, 2014 will be reviewed "
	"and volunteers selected will be notified by June 30th, 2015."))))



(define accepted.xexpr
  (make-page
    "Accepted papers"
    `(div
      ((class "col1"))
      (center
       (h1 "Accepted papers"))

      (dl
       (dt "Foundational Extensible Corecursion: A Proof Assistant Perspective")
       (dd "Jasmin Christian Blanchette (Inria & LORIA, Nancy), "
	   "Andrei Popescu (Middlesex University), "
	   "and Dmitriy Traytel (TU M" uuml "nchen)")

       (dt "Noninterference for Free")
       (dd "William J. Bowman (Northeastern University CCIS) "
	   "and Amal Ahmed (Northeastern University CCIS)")

       (dt "Adaptive Lock-Free Data: Purely-Functional to Scalable")
       (dd "Peter Fogg (Indiana University), "
	   "Ali Varamesh (Indiana University), "
	   "and Ryan R. Newton (Indiana University)")

       (dt "Efficient Communication and Collection with Compact Normal Forms")
       (dd "Abhishek Kulkarni (Indiana University), "
	   "Ahmed El-Hassany (Indiana University), "
	   "Edward Z. Yang (Stanford University), "
	   "Giovanni Campagna (Stanford University), "
	   "Ryan Newton (Indiana University), "
	   "and " Ouml "mer S. A" 287 "acan (Indiana University)")

       (dt "Partial Aborts for Transactions via First-Class Continuations")
       (dd "Matthew Le (Rochester Institute of Technology) "
	   "and Matthew Fluet (Rochester Institute of Technology)")

       (dt "Blame Assignment for Higher-Order Contracts with Intersection and Union")
       (dd "Matthias Keil (University of Freiburg) "
	   "and Peter Thiemann (University of Freiburg)")

       (dt "1ML - Core and modules united (F-ing first-class modules)")
       (dd "Andreas Rossberg (Google)")

       (dt "RRB Vector: A Practical General Purpose Immutable Sequence")
       (dd "Nicolas Stucki (EPFL, Switzerland), "
	   "Tiark Rompf (Purdue University), "
	   "and Vlad Ureche (EPFL, Switzerland)")

       (dt "Pycket: A Tracing JIT For a Functional Language")
       (dd "Spenser Bauman (Indiana University), "
	   "Carl Friedrich Bolz (Kings College, London), "
	   "Robert Hirschfeld (Hassno-Plattner-Institut, Potsdam), "
	   "Vasily Krilichev (Hassno-Plattner-Institut, Potsdam), "
	   "Tobias Pape (Hassno-Plattner-Institut, Potsdam), "
	   "Jeremy G. Siek (Indiana University), "
	   "and Sam Tobin-Hochstadt (Indiana University)")

       (dt "An Optimizing Compiler for a Purely Functional Web-Application Language")
       (dd "Adam Chlipala (MIT CSAIL)")

       (dt "Expressing Contract Monitors as Patterns of Communication")
       (dd "Cameron Swords (Indiana University), "
	   "Amr Sabry (Indiana University), "
	   "and Sam Tobin-Hochstadt (Indiana University)")

       (dt "Functional Pearl: A Smart View on Datatypes")
       (dd "Mauro Jaskelioff (CIFASIS - CONICET) "
	   "and Exequiel Rivas (CIFASIS - CONICET)")

       (dt "Elaborating Evaluation-Order Polymorphism")
       (dd "Joshua Dunfield (University of British Columbia)")

       (dt "Bounded Refinement Types")
       (dd "Niki Vazou (UC San Diego), "
	   "Alexander Bakst (UC San Diego), "
	   "and Ranjit Jhala (UC San Diego)")

       (dt "XQuery and Static Typing: Tackling the Problem of Backward Axes")
       (dd "Pierre Genev" egrave  "s (CNRS) "
	   "and Nils Gesbert (Universit" eacute " Grenoble Alpes)")

       (dt "Certified Symbolic Management of Financial Multi-Party Contracts")
       (dd "Patrick Bahr (University of Copenhagen), "
	   "Jost Berthold (University of Copenhagen), "
	   "and Martin Elsman (University of Copenhagen)")

       (dt "GADTs meet their match")
       (dd "Georgios Karachalias (Ghent University), "
	   "Tom Schrijvers (KU Leuven), "
	   "Dimitrios Vytiniotis (Microsoft Research Cambridge), "
	   "and Simon Peyton Jones (Microsoft Research Cambridge)")

       (dt "Denotational cost semantics for functional languages with inductive types")
       (dd "Norman Danner (Wesleyan University), "
	   "Daniel R. Licata (Wesleyan University), "
	   "and Ramyaa Ramyaa (Wesleyan University)")

       (dt "Bidirectional Programming in a More Applicative Style")
       (dd "Kazutaka Matsuda (The University of Tokyo) "
	   "and Meng Wang (University of Kent)")

       (dt "A Predictable Unification Algorithm for Coq Featuring Universe Polymorphism and Overloading")
       (dd "Beta Ziliani (MPI-SWS) "
	   "and Matthieu Sozeau (Inria & PPS, Universit" eacute " Paris Diderot)")

       (dt "Practical Principled FRP: Forget the past, change the future, FRPNow!")
       (dd "Atze van der Ploeg (Chalmers University of Technology) "
	   "and Koen Claessen (Chalmers University of Technology)")

       (dt "Analysing the Complexity of Functional Programs: Higher-Order Meets First-Order")
       (dd "Martin Avanzini (University of Bologna, Italy & Inria, France), "
	   "Ugo Dal Lago (University of Bologna, Italy & Inria, France), "
	   "and Georg Moser (University of Innsbruck)")

       (dt "Generating Performance Portable Code using Rewrite Rules: From High-level Functional Expressions to High-Performance OpenCL Code")

       (dd "Michel Steuwer (The University of Edinburgh, UK), "
	   "Christian Fensch (Heriot-Watt University, UK), "
	   "Sam Lindley (The University of Edinburgh, UK), "
	   "and Christophe Dubach (The University of Edinburgh, UK)")

       (dt "Hygienic Resugaring of Compositional Desugaring")
       (dd "Justin Pombrio (Brown University) "
	   "and Shriram Krishnamurthi (Brown University)")

       (dt "Functional Pearl: Two can keep a secret, if one of them uses Haskell")
       (dd "Alejandro Russo (Chalmers University of Technology)")

       (dt "Which simple types have a unique inhabitant?")
       (dd "Gabriel Scherer (INRIA) "
	   "and Didier R" egrave "my (INRIA)")

       (dt "HLIO: Mixing Static and Dynamic Typing for Information-Flow Control in Haskell")
       (dd "Pablo Buiras (Chalmers University of Technology), "
	   "Dimitrios Vytiniotis (Microsoft Research), "
	   "and Alejandro Russo (Chalmers University of Technology)")

       (dt "Algebras and Coalgebras in the Light Affine Lambda Calculus")
       (dd "Marco Gaboardi (University of Dundee and Harvard University) "
	   "and Romain P" eacute "choux (Universit" egrave " de Lorraine)")

       (dt "Functional Pearl: A SQL to C Compiler in 500 Lines of Code")
       (dd "Tiark Rompf (Purdue University) "
	   "and Nada Amin (EPFL)")

       (dt "A Fast Compiler for NetKAT")
       (dd "Steffen Smolka (Cornell University), "
	   "Spiridon Eliopoulos (Inhabited Type), "
	   "Nate Foster (Cornell University), "
	   "and Arjun Guha (University of Massachusetts Amherst) ")

       (dt "Structures for structural recursion")
       (dd "Paul Downen (University of Oregon), "
	   "Philip Johnson-Freyd (University of Oregon), "
	   "and Zena M. Ariola (University of Oregon)")

       (dt "Automatic Refunctionalization to a Language with Copattern Matching: With Applications to the Expression Problem")
       (dd "Tillmann Rendel (University of T" uuml "bingen), "
	   "Julia Trieflinger (University of T" uuml "bingen), "
	   "and Klaus Ostermann (University of T" uuml "bingen)")

       (dt "Pilsner: A Compositionally Verified Compiler for a Higher-Order Imperative Language")
       (dd "Georg Neis (MPI-SWS, Germany), "
	   "Chung-Kil Hur (Seoul National University), "
	   "Jan-Oliver Kaiser (MPI-SWS, Germany), "
	   "Craig McLaughlin (University of Glasgow), "
	   "Derek Dreyer (MPI-SWS, Germany), "
	   "and Viktor Vafeiadis (MPI-SWS, Germany)")

       (dt "Practical SMT-Based Type Error Localization")
       (dd "Zvonimir Pavlinovic (New York University), "
	   "Tim King (Verimag), "
	   "and Thomas Wies (New York University)")

       (dt "Learning Refinement Types")
       (dd "He Zhu (Purdue University), "
	   "Aditya V. Nori (Microsoft Research), "
	   "and Suresh Jagannathan (Purdue University)")))))


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


