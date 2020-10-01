#!/usr/bin/env bash
python3 -m pip install PyQt5==5.10 pip teton-pywim teton-3mf
Xvfb :1.0 -screen 0 1280x800x16 &
export DISPLAY=:1.0
export QT_QPA_PLATFORM=offscreen
python3 plugins/SmartSlicePlugin/tests/run.py

#python3 cura_app.py --headless
