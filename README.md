My nvim config. Has an epic vimtex setup

# Features
- Epic Latex editing, with easy to add snippets, and remapped jk keys for long wrapped lines
- Kind of buggy but still epic statusline color change for each window (visual feedback for the impaired)
- Disabled arrow keys for the ill mannered
- Epic mappings such as CTRL-L for window cycle, CTRL-J and K for scroll, etc
- Epic anti eye destruction when viewing pdfs with white background... *hisssss!!!* (see extras below)
- Edit zathurarc with user command `ZathurarcEdit`

# Todo
- Add some nice autoexpanding lua snippets (oneline if, for, etc)
- More visual feedback for window switch autocmd (WindowSTLine)
- Make winSTline friendlier with existing stline plugin
- Make winSTline not react to completion popup 
- Tidy up

# Extras
Earlier I had my revolutionary "Anti I(Eye) Depreciation System", or AIDS for short. This has now been removed, and is now a bash script. I highly recommend any avid PDF-readers to use zathura, and configure it to have a beige background. AIDS allows you to update the config depending on the time (or any condition of your choice for that matter).

Should you want to use this yourself, you can do the following:
## Setting up AIDS
This guide is for linux, if you're on windows, just switch lol
1. Create a script, in your location of choice
2. Write the script as you please, but for convenience, it should copy or write your desired config to the location of zathurarc, overwriting the existing config, allowing any program to use the config without need for extra setup
    1. See **man zathurarc** for options, or search the web (arch wiki!)
3. *(optional)* Ensure that the config is updated first every time you open zathura
    1. Set as default pdf reader (see xdg or whatever you use)
4. Profit

### Example
1. Make your desired config(s), for example
```
set recolor-lightcolor "#B9AFA1"
set recolor-darkcolor "#000000"
set recolor-keephue true
set recolor true
```
2. Make a shell script, and place it somewhere convenient, for example, placing **epic_script.sh** in **/home/coolusername/myscripts/**
3. Write your script, for example
```bash
#!/bin/bash
update_zathurarc()
{
    local current_hour=$(date +%H)
    local src 
    local dest="${HOME}/.config/zathura/zathurarc"
    if [ "$current_hour" -ge 17 ] && [ "$current_hour" -lt 22 ]; then
      src="${HOME}/zathuraconfig/evening"
    elif [ "$current_hour" -ge 22 ] || [ "$current_hour" -lt 6 ]; then
      src="${HOME}/zathuraconfig/night"
    else
      src="${HOME}/zathuraconfig/day"
    fi
    if cp "-f" "-T" "$src" "$dest"; then
      return 0
    fi
    return 1
}
# Run the shit
update_zathurarc && zathura "$@"
```
4. Make it executable `chmod +x epic_script.sh`
5. Update your pdf file association *(search for "change default application [distro]")*
6. Boom, thank me later

Pro tip: for night mode, do set `recolor-darkcolor` to brown, and `recolor-lightcolor` to black

# Credits
1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
2) NvChad starter
