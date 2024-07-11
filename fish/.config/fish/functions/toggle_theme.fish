function toggle_theme
	set current_theme (awk '$1=="include" {print $2}' "$HOME/.config/kitty/kitty.conf")
	set new_theme "rose-pine-dawn.conf"

	if [ "$current_theme" = "rose-pine-dawn.conf" ]
		set new_theme "rose-pine-moon.conf"
	end

	kitty @ set-colors --all --configured "~/.config/kitty/$new_theme"

	sed -i -e "s/include.*/include $new_theme/" "$HOME/.config/kitty/kitty.conf"
end
