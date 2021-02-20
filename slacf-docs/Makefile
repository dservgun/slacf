#A make file for public tex document.

all : report logo
report : SLACFObjectives.tex
	lualatex SLACFObjectives.tex

logo : slacflogo.tex
	lualatex slacflogo.tex
	pdftoppm slacflogo.pdf slacflogo -png
	cp slacflogo-1.png ./images
clean: 
	rm SLACFObjectives*.out
	rm SLACFObjectives*.aux
	rm SLACFObjectives*.lo?
