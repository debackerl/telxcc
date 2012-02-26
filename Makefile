CC = gcc
CCFLAGS = -O3 -Wall -std=c99
LDFLAGS = 

OBJS = telxcc.o
EXEC = telxcc

all : $(EXEC)

strip : $(EXEC)
	-strip $<

.PHONY : clean
clean :
	-rm -f $(OBJS) $(EXEC)

$(EXEC) : $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $<

%.o : %.c
	$(CC) -c $(CCFLAGS) -o $@ $<

profiled :
	make CCFLAGS="$(CCFLAGS) -fprofile-generate" LDFLAGS="$(LDFLAGS) -fprofile-generate" $(EXEC)
	for i in `ls -b ./*.ts` ; do ./telxcc -1 -c -v -p 888 < $$i > /dev/null 2> /dev/null ; done
	for i in `ls -b ./*.ts` ; do ./telxcc -1 -c -v -p 777 < $$i > /dev/null 2> /dev/null ; done
	make clean
	make CCFLAGS="$(CCFLAGS) -fprofile-use" LDFLAGS="$(LDFLAGS) -fprofile-use" $(EXEC)
	-rm -f *.gcda *.gcno *.dyn pgopti.dpi pgopti.dpi.lock
