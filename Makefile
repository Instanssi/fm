all: fm_tx.py turnoff.py

fm_tx.py: fm_tx.grc
	grcc fm_tx.grc -d .

turnoff.py: turnoff.grc
	grcc turnoff.grc -d .

clean:
	rm -f fm_tx.py turnoff.py
