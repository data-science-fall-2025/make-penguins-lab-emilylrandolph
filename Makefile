rexec= R CMD BATCH --no-save --no-restore
all: 

.PHONY: sims
sims: analysis/plot_penguin.R

analysis/plot_penguin.R: analysis/plot_penguin.R output/penguin_pairs.png
	quarto render $<
	mv $(<D)/$(@F) $@


output/penguin_report.qmd: analysis/penguin_report.qmd
	quarto render analysis/penguin_report.qmd output/penguin_report.html

output/penguin_class.csv: analysis/classify_penguins.R output/penguin_report.html
	$(rexec) analysis/classify_penguins.R output/penguin_report.html

.PHONY : clean
clean:
	rm -f ./output/penguin_report.html
	rm -f ./output/penguin_pairs.png
	rm -f ./output/penguin_class.csv
