all: fm_tx.py turnoff.py deviation_test.py

fm_tx.py: fm_tx.grc
	grcc fm_tx.grc -d .

turnoff.py: turnoff.grc
	grcc turnoff.grc -d .

deviation_test.py: deviation_test.grc
	grcc deviation_test.grc -d .

clean:
	rm -f fm_tx.py turnoff.py deviation_test.py
