#
# A simple Makefile
#

######

all::
all::file-copying
file-copying:: ; make -C file-copying all
all::queue-sllist2
queue-sllist2:: ; make -C queue-sllist2 all
word-counting:: ; make -C word-counting all

######

cleanall::
cleanall:: ; make -C file-copying cleanall
cleanall:: ; make -C queue-sllist2 cleanall
cleanall:: ; make -C loop-as-tailrec cleanall
cleanall:: ; make -C word-counting cleanall

######

uploadall::
uploadall::upload_stack-array
uploadall::upload_file-copying
uploadall::upload_queue-sllist2
uploadall::upload_loop-as-tailrec
uploadall::upload_word-counting

######

upload_stack-array:: ; \
  scp \
  stack-array/Makefile \
  stack-array/main.html \
  stack-array/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/stack-array/

######

upload_queue-sllist2:: ; \
  scp \
  queue-sllist2/Makefile \
  queue-sllist2/main.html \
  queue-sllist2/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/queue-sllist2/

######

upload_file-copying:: ; \
  scp \
  file-copying/Makefile \
  file-copying/main.html \
  file-copying/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

upload_loop-as-tailrec:: ; \
  scp \
  loop-as-tailrec/Makefile \
  loop-as-tailrec/main.html \
  loop-as-tailrec/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/loop-as-tailrec/

######

upload_word-counting:: ; \
  scp \
  word-counting/Makefile \
  word-counting/main.html \
  word-counting/*.?ats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/word-counting/

######


###### end of [Makefile] ######
