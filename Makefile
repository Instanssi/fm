all: fm_tx.py drm_receiver.py frequency_sweep.py

drm_receiver.py: drm_receiver.grc
	grcc drm_receiver.grc -d .

fm_tx.py: fm_tx.grc
	grcc fm_tx.grc -d .
	sed -i 's/tb.start()/tb.start\(\);import systemd.daemon;systemd.daemon.notify\("READY=1"\)/' fm_tx.py

frequency_sweep.py: frequency_sweep.grc
	grcc frequency_sweep.grc -d .

clean:
	rm -f fm_tx.py drm_receiver.py frequency_sweep.py
