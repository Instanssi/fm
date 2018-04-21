all: fm_tx.py

fm_tx.py: fm_tx.grc
	grcc fm_tx.grc -d .

clean:
	rm -f fm_tx.py
