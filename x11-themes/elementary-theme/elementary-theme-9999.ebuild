# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="The official elementary GTK theme"
HOMEPAGE="https://launchpad.net/egtk"
EGIT_REPO_URI="https://github.com/elementary/stylesheet.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+gtk +gtk3 +icons +wallpapers"

DEPEND="
	x11-themes/vanilla-dmz-aa-xcursors
	!x11-themes/plank-theme-pantheon"
RDEPEND="${DEPEND}
	media-fonts/droid
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
	)
	wallpapers? (
		x11-themes/elementary-wallpapers
	)"

RESTRICT="binchecks mirror strip"

src_prepare() {
	eapply_user

	# Correct cursor theme name
	sed -i 's/DMZ-Black/Vanilla-DMZ-AA/' index.theme
}

src_install() {
	insinto /usr/share/themes/elementary
	doins -r index.theme gtk-2.0 gtk-3.0 gtk-3.22

	insinto /usr/share/plank/themes/Pantheon
	doins plank/dock.theme
}
