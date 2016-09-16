# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit base

DESCRIPTION="The official elementary GTK theme designed to be smooth, attractive, fast, and usable"
HOMEPAGE="https://launchpad.net/egtk"
SRC_URI="https://launchpad.net/egtk/3.x/${PV}/+download/elementary.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="dark +gtk +gtk3 +icons +wallpapers"

DEPEND="
	x11-themes/vanilla-dmz-aa-xcursors"
RDEPEND="${DEPEND}
	media-fonts/droid
	gtk? (
		x11-libs/gtk+:2
		x11-themes/gtk-engines-murrine
	)
	gtk3? (
		<x11-libs/gtk+-3.5:3
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

S="${WORKDIR}/elementary"
DOCS=( AUTHORS CONTRIBUTORS COPYING )

src_prepare() {
	# Add support for dark theming
	use dark && epatch "${FILESDIR}/${P}-dark.patch"

	# Correct cursor theme name
	sed -i 's/DMZ-Black/Vanilla-DMZ-AA/' index.theme
}

src_install() {
	insinto /usr/share/themes/elementary
	doins -r index.theme metacity-1 gtk-2.0 gtk-3.0

	base_src_install_docs
}
