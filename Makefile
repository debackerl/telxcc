all : telxcc

telxcc : telxcc.c
	gcc -D DETECT -c -O3 -Wall -std=c99 -o telxcc.o telxcc.c
	gcc -D DETECT -o telxcc telxcc.o
	-strip telxcc

profiled :
	gcc -fprofile-generate -c -O3 -Wall -std=c99 -o telxcc.o telxcc.c
	gcc -fprofile-generate -o telxcc telxcc.o
	for i in `ls -b ./*.ts` ; do ./telxcc -1 -c < $$i > /dev/null ; done
	-rm -f *.o telxcc
	gcc -fprofile-use -c -O3 -Wall -std=c99 -o telxcc.o telxcc.c
	gcc -fprofile-use -o telxcc telxcc.o
	-strip telxcc
	-rm -f *.gcda *.gcno *.dyn pgopti.dpi pgopti.dpi.lock

.PHONY : clean
clean :
	-rm -f *.o telxcc
	-rm -f *.gcda *.gcno *.dyn pgopti.dpi pgopti.dpi.lock
