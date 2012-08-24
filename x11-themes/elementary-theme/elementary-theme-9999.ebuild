# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils fdo-mime bzr

DESCRIPTION="Elementary GTK THEME designed to be smooth, attractive, fast, and usable"
HOMEPAGE="https://launchpad.net/egtk"
EBZR_REPO_URI="lp:egtk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cursors +fonts gnome +gtk +gtk3 +icons lxde +wallpapers"

RDEPEND="
	cursors? ( 
		|| (
			x11-themes/vanilla-dmz-aa-xcursors
			x11-themes/vanilla-dmz-xcursors
		)
	)
	fonts? (
		media-fonts/droid
	)
	gtk? (
		x11-libs/gtk+:2
		x11-themes/gtk-engines-murrine
	)
	gtk3? (
		x11-libs/gtk+:3
		x11-themes/gtk-engines-unico
	)
	icons? ( 
		x11-themes/elementary-icon-theme
		x11-themes/hicolor-icon-theme
		gnome? ( x11-themes/gnome-icon-theme )
		!gnome? ( x11-themes/tango-icon-theme )
	)
	wallpapers? (
		x11-themes/elementary-wallpapers
	)"

RESTRICT="binchecks mirror strip"

pkg_setup() {
	DOCS="AUTHORS CONTRIBUTORS COPYING"
	THEMES="index.theme"
	use gnome && THEMES="${THEMES} metacity-1"
	use gtk && THEMES="${THEMES} gtk-2.0"
	use gtk3 && THEMES="${THEMES} gtk-3.0"
	use lxde && THEMES="${THEMES} openbox-3"
}

src_prepare() {
	# Add support for the openbox window manager
	use lxde && epatch "${FILESDIR}/${P}-openbox.patch"
}

src_install() {
	insinto /usr/share/themes/elementary
	doins -r ${THEMES}

	dodoc ${DOCS}
}

