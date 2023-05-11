LDFLAGS="-L/usr/local/opt/flex/lib"

run: coul
	echo "noir add jaune" | ./coul

run2: coul
	echo "rouge" | ./coul

run3: coul
	echo "magenta add blanc" | ./coul


%: %.tab.c %.yy.c
	gcc  -o $@ $^ ${LDFLAGS} -ly -lfl

%.tab.c: %.y
	bison -d --report=all $^

%.yy.c: %.l
	flex -o $@ $^

clean:
	rm -f coul.output
	rm -f coul.tab.h
	rm coul
	ls