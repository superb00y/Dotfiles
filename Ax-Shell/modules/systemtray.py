import gi

gi.require_version("Gray", "0.1")
from gi.repository import Gray, Gtk, Gdk, GdkPixbuf, GLib


class SystemTray(Gtk.Box):
    def __init__(self, pixel_size: int = 20, **kwargs) -> None:
        super().__init__(name="systray", orientation=Gtk.Orientation.HORIZONTAL, spacing=8, **kwargs)
        self.pixel_size = pixel_size
        self.watcher = Gray.Watcher()
        self.watcher.connect("item-added", self.on_item_added)

    def on_item_added(self, _, identifier: str):
        item = self.watcher.get_item_for_identifier(identifier)
        item_button = self.do_bake_item_button(item)
        item.connect("removed", lambda *args: item_button.destroy())
        item_button.show_all()
        self.add(item_button)

    def do_bake_item_button(self, item: Gray.Item) -> Gtk.Button:
        button = Gtk.Button()

        button.connect(
            "button-press-event",
            lambda button, event: self.on_button_click(button, item, event),
        )

        pixmap = Gray.get_pixmap_for_pixmaps(item.get_icon_pixmaps(), self.pixel_size)

        try:
            if pixmap is not None:
                pixbuf = pixmap.as_pixbuf(self.pixel_size, GdkPixbuf.InterpType.HYPER)
            else:
                icon_name = item.get_icon_name()
                icon_theme_path = item.get_icon_theme_path()

                # Use custom theme path if available
                if icon_theme_path:
                    custom_theme = Gtk.IconTheme.new()
                    custom_theme.prepend_search_path(icon_theme_path)
                    try:
                        pixbuf = custom_theme.load_icon(
                            icon_name,
                            self.pixel_size,
                            Gtk.IconLookupFlags.FORCE_SIZE,
                        )
                    except GLib.Error:
                        # Fallback to default theme if custom path fails
                        pixbuf = Gtk.IconTheme.get_default().load_icon(
                            icon_name,
                            self.pixel_size,
                            Gtk.IconLookupFlags.FORCE_SIZE,
                        )
                else:
                    pixbuf = Gtk.IconTheme.get_default().load_icon(
                        icon_name,
                        self.pixel_size,
                        Gtk.IconLookupFlags.FORCE_SIZE,
                    )
        except GLib.Error:
            # Fallback to 'image-missing' icon
            pixbuf = Gtk.IconTheme.get_default().load_icon(
                "image-missing",
                self.pixel_size,
                Gtk.IconLookupFlags.FORCE_SIZE,
            )

        button.set_image(Gtk.Image.new_from_pixbuf(pixbuf))
        return button

    def on_button_click(self, button, item: Gray.Item, event):
        if event.button == Gdk.BUTTON_PRIMARY:  # Click izquierdo
            try:
                item.activate(event.x, event.y)
            except Exception as e:
                print(f"Error al activar el item: {e}")
        elif event.button == Gdk.BUTTON_SECONDARY:  # Click derecho
            menu = item.get_menu()
            if menu:
                menu.set_name("system-tray-menu")
                menu.popup_at_widget(
                    button,
                    Gdk.Gravity.SOUTH,
                    Gdk.Gravity.NORTH,
                    event,
                )
            else:
                item.context_menu(event.x, event.y)
