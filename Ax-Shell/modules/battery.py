import time

import gi
import psutil
from fabric.utils import invoke_repeater
from fabric.widgets.box import Box
from fabric.widgets.circularprogressbar import CircularProgressBar
from gi.repository import GLib, Gtk

gi.require_version("Gtk", "3.0")


class BatteryModule(Gtk.Box):
    def __init__(self, **kwargs):
        super().__init__(
            name="battery", orientation=Gtk.Orientation.HORIZONTAL, spacing=5, **kwargs
        )

        self.progress_bar = self.create_circular_progress_bar("progress-bar")

        GLib.Thread.new(None, self.update_status)

        self.add(
            Box(
                children=[
                    self.progress_bar,
                ],
            )
        )

        # invoke_repeater(1000, self.update_status)

    def create_circular_progress_bar(self, name):
        return CircularProgressBar(
            name=name,
            min_value=0,
            max_value=100,
            size=25,
            line_style="round",
        )

    def update_status(self):
        while True:
            self.progress_bar.value = (
                psutil.sensors_battery().percent
                if psutil.sensors_battery() is not None
                else 100
            )
            time.sleep(1000)
