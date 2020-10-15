### Custom [Polybar](https://github.com/polybar/polybar) theme
![theme_screenshot](https://github.com/vuckale/polybar-theme/blob/master/screenshot.png?raw=true)

* Using [https://github.com/Templarian/MaterialDesign](https://github.com/Templarian/MaterialDesign) fonts 
* Most modules are configured to use scripts from [scripts](https://github.com/vuckale/polybar-theme/tree/master/scripts) directory but some run desktop environment (GNOME in this case) based commands like `gnome-control-center` etc. which can be easily configured.
* pulseaudio-control module taken from [https://github.com/marioortizmanero/polybar-pulseaudio-control](https://github.com/marioortizmanero/polybar-pulseaudio-control) but modified.

Further instructions on how to modify it and install it will be added

## Fonts

1. Clone Material Design repository:
```bash
git clone https://github.com/Templarian/MaterialDesign
```
2. Move `.ttf` file to `~/.local/share/fonts`:
```bash
cd MaterialDesign-Font
mv *.ttf ~/.local/share/fonts
fc-cache -v
```
3. Get font name for `.config` to use it:
```bash
fc-list | grep "MaterialDesign"
```
this should return something like this:

```~/.local/share/fonts/MaterialDesignIconsDesktop.ttf: Material Design Icons Desktop:style=Regular```

and you have to copy part after ```:``` which is ```Material Design Icons Desktop:style=Regular```

4. Paste it to `.config` file:
```ini
[bar/example]
font-3 = Material Design Icons Desktop:style=Regular:pixelsize=15:antialias=true;4
```
