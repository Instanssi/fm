# README

How to broadcast Instanssi FM radio

## Configuration

Setup alsa loopbacks:

	sudo modprobe snd-aloop enable=1,1 index=10,11

## Startup

Startup order:

1. Stereo Tool
2. GNU Radio block
3. Audio source

## Audio source

curl http://instanssi.org:8000/fm.opus | opusdec - - | aplay -qfdat -D plughw:10,0 -B 1000000

## Realtime priority

Sometimes it may help.

	sudo chrt -p --rr 99 STEREOTOOL_PID
